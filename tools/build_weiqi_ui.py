# -*- coding: utf-8 -*-
"""围棋对局、占地、终局点目与复盘Dialog；只调用经过game校验的入口。"""
from pathlib import Path
import json
from build_weiqi_settings import build as settings_build, OBJECTIVES as SET_OBJECTIVES
from build_weiqi_input import build as input_build, OBJECTIVES as INPUT_OBJECTIVES

PACK=Path(__file__).resolve().parents[1]
ROOT=PACK/'data/weiqi/function'
OBJECTIVES={**SET_OBJECTIVES,**INPUT_OBJECTIVES}

def js(value):return json.dumps(value,ensure_ascii=False,separators=(',',':'))
def message(contents,color=None,width=470):
 if isinstance(contents,str):contents={'text':contents,**({'color':color} if color else {})}
 return {'type':'minecraft:plain_message','width':width,'contents':contents}

def build(root=ROOT):
 def put(name,text):
  path=root/(name+'.mcfunction');path.parent.mkdir(parents=True,exist_ok=True);path.write_text(text.strip()+'\n',encoding='utf8')
 put('name/capture','''
# loot的set_name在玩家上下文提前解析姓名，Dialog不读取未解析的selector。
data modify storage weiqi:runtime name.value set value {text:"未知玩家"}
kill @e[type=minecraft:item_display,tag=go.name_resolver,distance=..1,limit=1]
summon minecraft:item_display ~ ~ ~ {Tags:["go.name_resolver"],view_range:0f,item:{id:"minecraft:paper"}}
loot replace entity @e[type=minecraft:item_display,tag=go.name_resolver,distance=..1,sort=nearest,limit=1] contents loot weiqi:player_name
data modify storage weiqi:runtime name.value set from entity @e[type=minecraft:item_display,tag=go.name_resolver,distance=..1,sort=nearest,limit=1] item.components."minecraft:custom_name"
data remove storage weiqi:runtime name.value.click_event
data remove storage weiqi:runtime name.value.hover_event
data remove storage weiqi:runtime name.value.insertion
kill @e[type=minecraft:item_display,tag=go.name_resolver,distance=..1,sort=nearest,limit=1]
''')
 put('name/read','function weiqi:name/capture')
 loot=PACK/'data/weiqi/loot_table/player_name.json';loot.parent.mkdir(parents=True,exist_ok=True)
 loot.write_text(json.dumps({'pools':[{'rolls':1,'entries':[{'type':'minecraft:item','name':'minecraft:paper','functions':[{'function':'minecraft:set_name','entity':'this','name':{'selector':'@s'}}]}]}]},ensure_ascii=False,indent=2)+'\n',encoding='utf8')
 put('ui/refresh','''
# 阶段推进只恢复trigger资格，不强制打断视角弹窗。
function weiqi:system/context
scoreboard players set @a[tag=go.audience] go_action 0
scoreboard players enable @a[tag=go.audience] go_action
''')
 put('ui/begin','''
execute if score #panel_serial go_ctx matches 9999.. run scoreboard players add #ui_load go_ctx 1
execute unless score #panel_serial go_ctx matches 0..9998 run scoreboard players set #panel_serial go_ctx 0
scoreboard players add #panel_serial go_ctx 1
scoreboard players operation @s go_ui_serial = #panel_serial go_ctx
scoreboard players operation @s go_seen = @e[tag=go.current,limit=1] go_epoch
scoreboard players operation @s go_ui_load = #ui_load go_ctx
scoreboard players operation @s go_ui_table = @s go_table
scoreboard players operation #ui_base go_ctx = @s go_ui_serial
scoreboard players set #ui_factor go_ctx 10000
scoreboard players operation #ui_base go_ctx *= #ui_factor go_ctx
data modify storage weiqi:ui buttons set value []
scoreboard players set @s go_action 0
scoreboard players enable @s go_action
function weiqi:ui/summary
''')
 put('ui/summary','''
data modify storage weiqi:ui black_name set value {text:"黑方"}
data modify storage weiqi:ui white_name set value {text:"白方"}
data modify storage weiqi:ui black_name set from entity @e[tag=go.current,limit=1] data.weiqi.black_name
data modify storage weiqi:ui white_name set from entity @e[tag=go.current,limit=1] data.weiqi.white_name
data modify storage weiqi:ui turn set value "黑方"
execute if entity @e[tag=go.current,scores={go_turn=-1},limit=1] run data modify storage weiqi:ui turn set value "白方"
data modify storage weiqi:ui estimate_note set value "占地尚未查看；估算未判断死活，未定空点不计入。"
data modify storage weiqi:ui area_title set value "暂计占地"
execute if entity @a[tag=go.audience,scores={go_view=1}] run data modify storage weiqi:ui estimate_note set value "当前显示保守占地估算，未判断死活；未定空点不计入，标记同步于本桌棋盘。"
execute if entity @e[tag=go.current,scores={go_state=3},limit=1] run data modify storage weiqi:ui estimate_note set value "右键棋子，整组标记死子或恢复。双方确认后结算；有分歧可继续下棋。"
execute if entity @e[tag=go.current,scores={go_state=3..5},limit=1] run data modify storage weiqi:ui area_title set value "终局面积"
execute if entity @e[tag=go.current,scores={ct_state=0},limit=1] run data modify storage weiqi:ui area_title set value "终局面积"
''')
 for key in ['moves','bcap','wcap','komi','barea','warea','bterrit','wterrit','neutral','bscore','wscore','review']:
  # 无估算结果时使用0，避免宏缺参数整条窗口无法显示。
  put('ui/value_'+key,f'scoreboard players set #ui_value go_ctx 0\nexecute if score @e[tag=go.current,limit=1] go_{key} = @e[tag=go.current,limit=1] go_{key} run scoreboard players operation #ui_value go_ctx = @e[tag=go.current,limit=1] go_{key}\nexecute store result storage weiqi:ui {key} int 1 run scoreboard players get #ui_value go_ctx')
 summary=(root/'ui/summary.mcfunction').read_text(encoding='utf8')+'\n'.join('function weiqi:ui/value_'+key for key in ['moves','bcap','wcap','komi','barea','warea','bterrit','wterrit','neutral','bscore','wscore','review'])+'\n'
 for key in ['komi','bscore','wscore']:
  summary+=f'function weiqi:ui/half {{key:"{key}"}}\n'
 summary+='data modify storage weiqi:ui scoreline set value {text:""}\n'
 summary+='execute if entity @a[tag=go.audience,scores={go_view=1}] run function weiqi:ui/scoreline with storage weiqi:ui\n'
 summary+='execute if entity @e[tag=go.current,scores={go_state=3..5},limit=1] run function weiqi:ui/scoreline with storage weiqi:ui\n'
 summary+='execute if entity @e[tag=go.current,scores={ct_state=0},limit=1] run function weiqi:ui/scoreline with storage weiqi:ui\n'
 put('ui/summary',summary)
 put('ui/scoreline','$data modify storage weiqi:ui scoreline set value '+js({'text':'$(area_title)：黑$(barea) / 白$(warea)\n空地 黑$(bterrit) / 白$(wterrit) · 未定/公气$(neutral)\n含贴目得分：黑$(bscore_label) / 白$(wscore_label)\n复盘手数：$(review)','color':'gray'}))
 put('ui/half','''
$execute store result score #half go_ctx run data get storage weiqi:ui $(key)
data modify storage weiqi:ui half_sign set value ""
execute if score #half go_ctx matches ..-1 run data modify storage weiqi:ui half_sign set value "-"
scoreboard players set #half_minus go_ctx -1
execute if score #half go_ctx matches ..-1 run scoreboard players operation #half go_ctx *= #half_minus go_ctx
scoreboard players set #two go_ctx 2
scoreboard players operation #whole go_ctx = #half go_ctx
scoreboard players operation #whole go_ctx /= #two go_ctx
scoreboard players operation #half go_ctx %= #two go_ctx
execute store result storage weiqi:ui half_whole int 1 run scoreboard players get #whole go_ctx
$data modify storage weiqi:ui half_key set value "$(key)_label"
execute if score #half go_ctx matches 0 run function weiqi:ui/half_integer with storage weiqi:ui
execute unless score #half go_ctx matches 0 if score #whole go_ctx matches 0 run function weiqi:ui/half_fraction_zero with storage weiqi:ui
execute unless score #half go_ctx matches 0 unless score #whole go_ctx matches 0 run function weiqi:ui/half_fraction with storage weiqi:ui
''')
 put('ui/half_integer','$data modify storage weiqi:ui $(half_key) set value "$(half_sign)$(half_whole)"')
 put('ui/half_fraction','$data modify storage weiqi:ui $(half_key) set value "$(half_sign)$(half_whole)½"')
 put('ui/half_fraction_zero','$data modify storage weiqi:ui $(half_key) set value "$(half_sign)½"')
 put('ui/open','''
function weiqi:input/context
execute unless entity @s[tag=go.actor] run return 0
function weiqi:ui/begin
data modify storage weiqi:ui phase set value "等待对手行棋。"
execute if score @s go_side = @e[tag=go.current,limit=1] go_turn run data modify storage weiqi:ui phase set value "轮到你行棋。"
execute if entity @e[tag=go.current,scores={go_state=2},limit=1] run data modify storage weiqi:ui phase set value "落子动画中。"
execute if entity @e[tag=go.current,scores={go_state=3},limit=1] run data modify storage weiqi:ui phase set value "终局点目：请标记死子并确认。"
execute if entity @e[tag=go.current,scores={go_state=4},limit=1] run data modify storage weiqi:ui phase set value "对局已结束，正在返回大厅。"
execute if entity @e[tag=go.current,scores={ct_state=0},limit=1] run data modify storage weiqi:ui phase set value "终局保留：可开始逐手复盘。"
execute if entity @e[tag=go.current,scores={go_state=5},limit=1] run data modify storage weiqi:ui phase set value "复盘中：只读回看，不改终局记录。"
execute if entity @e[tag=go.current,scores={go_state=1},limit=1] if score @s go_side = @e[tag=go.current,limit=1] go_turn run function weiqi:ui/button {code:10,label:"停一手",color:"yellow"}
execute if entity @e[tag=go.current,scores={go_state=1},limit=1] if score @s go_side = @e[tag=go.current,limit=1] go_turn run function weiqi:ui/button {code:50,label:"坐标落子",color:"aqua"}
execute if entity @e[tag=go.current,scores={go_state=1,go_estimate=1},limit=1] unless score @s go_view matches 1 run function weiqi:ui/button {code:11,label:"查看占地",color:"aqua"}
execute if entity @e[tag=go.current,scores={go_state=1,go_estimate=1},limit=1] if score @s go_view matches 1 run function weiqi:ui/button {code:11,label:"关闭占地",color:"gray"}
execute if entity @e[tag=go.current,scores={go_state=1,go_undo=0},limit=1] run function weiqi:ui/button {code:20,label:"申请悔棋",color:"yellow"}
execute if entity @e[tag=go.current,scores={go_state=1},limit=1] unless entity @e[tag=go.current,scores={go_undo=0},limit=1] unless score @s go_side = @e[tag=go.current,limit=1] go_undo run function weiqi:ui/button {code:21,label:"同意悔棋",color:"green"}
execute if entity @e[tag=go.current,scores={go_state=1},limit=1] unless entity @e[tag=go.current,scores={go_undo=0},limit=1] unless score @s go_side = @e[tag=go.current,limit=1] go_undo run function weiqi:ui/button {code:22,label:"拒绝悔棋",color:"gray"}
execute if entity @e[tag=go.current,scores={go_state=1},limit=1] unless entity @e[tag=go.current,scores={go_undo=0},limit=1] if score @s go_side = @e[tag=go.current,limit=1] go_undo run data modify storage weiqi:ui phase set value "已申请悔棋，等待对手回应。"
execute if entity @e[tag=go.current,scores={go_state=1},limit=1] unless entity @e[tag=go.current,scores={go_undo=0},limit=1] unless score @s go_side = @e[tag=go.current,limit=1] go_undo run data modify storage weiqi:ui phase set value "对手申请悔棋。"
execute if entity @e[tag=go.current,scores={go_state=1..2},limit=1] run function weiqi:ui/button {code:30,label:"认输",color:"red"}
execute if entity @e[tag=go.current,scores={go_state=3},limit=1] run function weiqi:ui/button {code:40,label:"确认点目",color:"green"}
execute if entity @e[tag=go.current,scores={go_state=3},limit=1] run function weiqi:ui/button {code:41,label:"继续下棋",color:"yellow"}
execute if entity @e[tag=go.current,scores={go_state=3,go_bconfirm=1},limit=1] if score @s go_side matches 1 run data modify storage weiqi:ui phase set value "你已确认，等待白方确认；改动死子将取消双方确认。"
execute if entity @e[tag=go.current,scores={go_state=3,go_wconfirm=1},limit=1] if score @s go_side matches -1 run data modify storage weiqi:ui phase set value "你已确认，等待黑方确认；改动死子将取消双方确认。"
execute if entity @e[tag=go.current,scores={ct_state=0,go_state=0},limit=1] run function weiqi:ui/button {code:60,label:"逐手复盘",color:"aqua"}
execute if entity @e[tag=go.current,scores={go_state=5},limit=1] run function weiqi:ui/button {code:64,label:"最初棋面",color:"gray"}
execute if entity @e[tag=go.current,scores={go_state=5},limit=1] run function weiqi:ui/button {code:62,label:"上一手",color:"aqua"}
execute if entity @e[tag=go.current,scores={go_state=5},limit=1] run function weiqi:ui/button {code:63,label:"下一手",color:"aqua"}
execute if entity @e[tag=go.current,scores={go_state=5},limit=1] run function weiqi:ui/button {code:65,label:"终局棋面",color:"gray"}
execute if entity @e[tag=go.current,scores={go_state=5,go_autoplay=0},limit=1] run function weiqi:ui/button {code:66,label:"自动播放",color:"green"}
execute if entity @e[tag=go.current,scores={go_state=5,go_autoplay=1},limit=1] run function weiqi:ui/button {code:66,label:"暂停播放",color:"yellow"}
execute if entity @e[tag=go.current,scores={go_state=5},limit=1] run function weiqi:ui/button {code:61,label:"退出复盘",color:"red"}
function weiqi:ui/button {code:70,label:"规则",color:"white"}
function weiqi:ui/show with storage weiqi:ui
tag @a[tag=go.actor] remove go.actor
''')
 put('ui/resign','''
execute unless entity @e[tag=go.current,scores={go_state=1..2},limit=1] run return 0
function weiqi:ui/begin
data modify storage weiqi:ui phase set value "确认认输？"
function weiqi:ui/button {code:31,label:"确认认输",color:"red"}
function weiqi:ui/show with storage weiqi:ui
tag @a[tag=go.actor] remove go.actor
''')
 put('ui/button','''
$scoreboard players set #ui_code go_ctx $(code)
scoreboard players operation #ui_code go_ctx += #ui_base go_ctx
execute store result storage weiqi:ui code int 1 run scoreboard players get #ui_code go_ctx
$data modify storage weiqi:ui label set value "$(label)"
$data modify storage weiqi:ui color set value "$(color)"
function weiqi:ui/button_append with storage weiqi:ui
''')
 put('ui/button_append','$data modify storage weiqi:ui buttons append value {label:{text:"$(label)",color:"$(color)"},width:150,action:{type:"minecraft:run_command",command:"trigger go_action set $(code)"}}')
 # 姓名使用完整静态文本组件，避免Dialog把selector原样显示。
 body=[message('$(phase)','yellow'),message([{'text':'黑方：','color':'gray'},'__BLACK__',{'text':'\n白方：','color':'white'},'__WHITE__']),message('行棋：$(turn) · 第$(moves)手\n提子：黑$(bcap) / 白$(wcap)\n白方贴目：$(komi_label)目','gray'),message('$(estimate_note)','aqua'),{'type':'minecraft:plain_message','width':470,'contents':'__SCORE__'}]
 panel={'type':'minecraft:multi_action','title':{'text':'围棋 · 对局菜单','color':'gold'},'body':body,'columns':2,'actions':'__BUTTONS__','exit_action':{'label':{'text':'返回棋盘'}},'pause':False,'after_action':'none'}
 panel_text=js(panel).replace('"__BLACK__"','$(black_name)').replace('"__WHITE__"','$(white_name)').replace('"__BUTTONS__"','$(buttons)').replace('"__SCORE__"','$(scoreline)')
 put('ui/show','$dialog show @s '+panel_text)
 put('ui/coordinates','''
function weiqi:input/context
execute unless entity @s[tag=go.actor] run return 0
execute unless entity @e[tag=go.current,scores={go_state=1},limit=1] run return 0
execute unless score @s go_side = @e[tag=go.current,limit=1] go_turn run return 0
execute if score #coord_serial go_ctx matches 9999.. run scoreboard players add #ui_load go_ctx 1
execute unless score #coord_serial go_ctx matches 999..9998 run scoreboard players set #coord_serial go_ctx 999
scoreboard players add #coord_serial go_ctx 1
scoreboard players operation @s go_coordnonce = #coord_serial go_ctx
scoreboard players operation @s go_coordepoch = @e[tag=go.current,limit=1] go_epoch
scoreboard players operation @s go_coordload = #ui_load go_ctx
scoreboard players operation @s go_coordtable = @s go_table
scoreboard players set @s go_coord 0
scoreboard players enable @s go_coord
execute store result storage weiqi:coordinates nonce int 1 run scoreboard players get @s go_coordnonce
execute store result storage weiqi:coordinates size int 1 run scoreboard players get @e[tag=go.current,limit=1] go_size
data modify storage weiqi:coordinates row set value "$(row)"
data modify storage weiqi:coordinates col set value "$(col)"
execute if entity @e[tag=go.current,scores={go_size=13},limit=1] run function weiqi:ui/coordinates_13 with storage weiqi:coordinates
execute if entity @e[tag=go.current,scores={go_size=15},limit=1] run function weiqi:ui/coordinates_15 with storage weiqi:coordinates
execute if entity @e[tag=go.current,scores={go_size=19},limit=1] run function weiqi:ui/coordinates_19 with storage weiqi:coordinates
tag @a[tag=go.actor] remove go.actor
''')
 for size in [13,15,19]:
  coordinate={'type':'minecraft:confirmation','title':{'text':'围棋 · 坐标落子','color':'gold'},'body':[message('列从黑方视角左到右，跳过I；行从黑方一侧向对面。')],'inputs':[{'type':'minecraft:single_option','key':'col','label':{'text':'列'},'width':300,'options':[{'id':str(i+1),'display':{'text':letter},**({'initial':True} if i==0 else {})} for i,letter in enumerate('ABCDEFGHJKLMNOPQRST'[:size])]},{'type':'minecraft:number_range','key':'row','label':{'text':'行'},'start':1,'end':size,'step':1,'initial':1,'width':300}],'yes':{'label':{'text':'落子','color':'green'},'action':{'type':'minecraft:dynamic/run_command','template':'trigger go_coord set $(nonce)$(row)0$(col)'}},'no':{'label':{'text':'取消'}},'pause':False}
  put('ui/coordinates_'+str(size),'$dialog show @s '+js(coordinate))
 sections=[
 ('人数与目标','支持1～2名玩家；单人自动对战电脑，设置可选三档难度。黑方先行，在13×13、15×15或19×19棋盘交点落子。采用中国规则面积计分：活子与围住的空点之和，白方默认贴7½目。'),
 ('落子与提子','右键空交点落子。相邻同色棋子构成一组，横竖相邻空点是气；没有气的对方棋子整组提走。禁止自杀与全局同形重复（位置超级劫）；停一手不受重复检查限制。可开启同点两次确认，或按Q使用坐标落子；字母跳过I。'),
 ('占地','按Q选择查看占地，在公共棋盘显示黑、白保守估算占地。未定空点不计入，未自动判断棋子的死活，也不是胜率预测；落子后自动关闭。可在游戏设置禁用。终局点目采用双方确认死子后的严格面积计分。'),
 ('终局与点目','连续两次停一手进入终局点目。右键棋子可整组标记死子，再右键可恢复；任何改动都会清除双方确认。死子移除后按面积计分，并加白方贴目；双方确认才结算。有争议时选择继续下棋，由当前行棋方继续。人机局由玩家确认。'),
 ('对局菜单与复盘','快捷栏最后一格菜单按Q：停一手、占地、坐标落子、悔棋及认输。双人悔棋须对方同意，认输须本人确认。终局返回大厅后保留棋面，原对局玩家可逐手回看、跳到首尾或自动播放；复盘不改终局记录。'),
 ('设置与计时','所有设置集中一页，点击立即生效，开局后锁定。可调棋盘大小、经典/木色、方向、黑白方分配、贴目、人机难度、坐标、最后一手标记、落子确认和占地。每人无限制或5～30分钟，当前行棋方超时判负；动画及点目时暂停。黑方始终先手，默认按座位选边。'),
 ('重载与管理','普通玩家无需管理员。/reload保留棋局与时钟，旧菜单按Q重开；玩家离线中止本局。管理员可在桌旁执行 /function weiqi:admin/abort。'),
 ]
 rules={'type':'minecraft:notice','title':{'text':'围棋 · 游戏规则','color':'gold'},'body':[message([{'text':title+'\n','color':'aqua','bold':True},{'text':text,'color':'white'}],width=480) for title,text in sections],'pause':False}
 put('rules/show','dialog show @a[tag=ct.rules_actor,limit=1] '+js(rules))
 put('rules/player','dialog show @s '+js(rules)+'\ntag @a[tag=go.actor] remove go.actor')
 settings_build(root);input_build(root)

if __name__=='__main__':build();print('围棋菜单、设置、规则及输入已生成')
