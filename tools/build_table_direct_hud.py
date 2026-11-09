"""直接交互游戏的固定双侧文字HUD；通知单独计时，避免轮询立即覆盖原因。"""
import json
from pathlib import Path

PACK=Path(__file__).resolve().parents[1]


def build(ns, prefix, title, players):
    p=prefix
    root=PACK/f'data/{ns}/function/hud'
    def put(name,lines):
        path=root/(name+'.mcfunction');path.parent.mkdir(parents=True,exist_ok=True)
        path.write_text(('\n'.join(lines) if isinstance(lines,list) else lines).strip()+'\n',encoding='utf-8')
    def js(v):return json.dumps(v,ensure_ascii=False,separators=(',',':'))
    put('load',[f'scoreboard objectives add {p}_{x} dummy' for x in ('hpanel','hprev','htimer')])
    put('activate',f'''
execute unless data storage fimel_title:io panels run function fimel_title:code/load
execute if entity @s[tag={p}.hud] run return 0
scoreboard players set @s {p}_hprev 0
execute if score @s fbt_panel matches 1.. run scoreboard players operation @s {p}_hprev = @s fbt_panel
function fimel_title:new_panel {{id:"@s {p}_hpanel"}}
scoreboard players set @s {p}_htimer 0
tag @s add {p}.hud
''')
    put('deactivate',f'''
execute unless entity @s[tag={p}.hud] run return 0
data modify storage fimel_title:io panel_buffer set value []
scoreboard players operation panel_id fbt_io = @s {p}_hpanel
function fimel_title:replace_panel
execute if score @s fbt_panel = @s {p}_hpanel run function {ns}:hud/restore
execute if entity @s[tag={p}.owns_hud] run tag @s remove fimel.anim_text.replace.actionbar
tag @s remove {p}.owns_hud
tag @s remove {p}.hud
''')
    put('restore',f'scoreboard players operation panel_id fbt_io = @s {p}_hprev\nfunction fimel_title:use_panel')
    buildlines=[f'function {ns}:hud/activate','data modify storage fimel_title:io panel_buffer set value []',
        'data modify storage fimel_title:io text set value '+js({'text':title,'color':'gold','bold':False}),
        'function '+ns+':hud/line {x:8,y:-8,origin:"left_top",align:"left"}']
    for side in range(1,players+1):
        x=8 if side%2 else -8;y=-24-((side-1)//2)*40
        buildlines += [f'execute if data entity @e[tag={p}.current,limit=1] data.{ns}.p{side}.name run function {ns}:hud/row '+js({'side':side,'x':x,'y':y,'y2':y-12,'y3':y-24,'origin':'left_top' if side%2 else 'right_top','align':'left' if side%2 else 'right'})]
    buildlines += [f'execute if score @s {p}_htimer matches 1.. run function {ns}:hud/show_notice',f'execute unless score @s {p}_htimer matches 1.. run function {ns}:hud/status',f'scoreboard players operation panel_id fbt_io = @s {p}_hpanel','function fimel_title:replace_panel',
        'execute unless entity @s[tag=fimel.anim_text.replace.actionbar] run tag @s add '+p+'.owns_hud',
        'tag @s add fimel.anim_text.replace.actionbar','function fimel_title:use_panel']
    put('build',buildlines)
    name={'nbt':f'data.{ns}.p$(side).name','entity':f'@e[tag={p}.current,limit=1]','interpret':True}
    def val(field,color='white'):
        return {'nbt':f'data.{ns}.p$(side).{field}','entity':f'@e[tag={p}.current,limit=1]','color':color}
    rows=[]
    if ns=='magical_athlete':
        texts=[{'text':'','bold':False,'extra':[name,{'text':' · '},val('points','gold'),{'text':'分','color':'gold'}]},
            {'text':'本场 ','color':'gray','bold':False,'extra':[val('race_points','aqua'),{'text':'分'}]},
            {'text':'角色与能力：查看物品栏','color':'gray','bold':False}]
    else:
        texts=[{'text':'','bold':False,'extra':[name,{'text':' · '},val('public_vp','gold'),{'text':'分'}]},
            {'text':'资源 ','color':'gray','bold':False,'extra':[val('resource_count'),{'text':' · 发展 '},val('dev_count')]},
            {'text':'道路 ','color':'gray','bold':False,'extra':[val('road_length','aqua'),{'text':' · 骑士 '},val('knights','aqua')]}]
    for i,t in enumerate(texts):
        y='y' if i==0 else 'y'+str(i+1)
        encoded=js(t)
        rows+=[('$' if '$(' in encoded else '')+'data modify storage fimel_title:io text set value '+encoded]
        if i==0:
            rows += [f'$execute if entity @e[tag={p}.current,scores={{{p}_turn=$(side)}},limit=1] run data modify storage fimel_title:io text.text set value "▶ "']
        if ns=='catan' and i==2:
            for field,label in [('longest',' · 最长道路'),('army',' · 最大骑士军')]:
                rows += [f'$execute if data entity @e[tag=ca.current,limit=1] data.catan{{{field}:$(side)}} run data modify storage fimel_title:io text.extra append value '+js({'text':label,'color':'gold'})]
        rows += [f'$function {ns}:hud/line {{x:$(x),y:$({y}),origin:"$(origin)",align:"$(align)"}}']
    put('row',rows)
    put('line',[
        'data modify storage fimel_title:io font set value "minecraft:default_mod"',
        'data modify storage fimel_title:io neg_font set value "minecraft:default_neg"',
        '$data modify storage fimel_title:io x set value $(x)d','$data modify storage fimel_title:io y set value $(y)d',
        '$data modify storage fimel_title:io origin set value "$(origin)"','$data modify storage fimel_title:io align set value "$(align)"',
        'data modify storage fimel_title:io dx set value 0.0d','data modify storage fimel_title:io dy set value 0.0d','function fimel_title:new_text'])
    put('center','function '+ns+':hud/line {x:0,y:0,origin:"default",align:"middle"}')
    status=[]
    states=({1:'招募：右键角色选择／确认，左键取消',2:'秘密出场：角色按Q选中，再按Q确认',3:'行动：骰子按Q；技能选项按Q或右键目标',4:'本场已结算，即将进入下一场',5:'四场比赛结束'} if ns=='magical_athlete' else
        {1:'初始村庄：手持村庄瞄准交点，右键或Q两次确认',2:'初始道路：手持道路瞄准相邻边，右键或Q两次确认',3:'投骰前：骰子按Q，或使用旧发展卡',4:'行动：建造／交易／发展卡；结束回合按Q两次',5:'弃牌：资源按Q加入，撤销物品按Q退回，选满自动提交',6:'强盗：瞄准新地块，右键或Q两次确认',7:'偷取：选择相邻对手',8:'免费修路：选择道路位置，或按Q放弃',11:'本局已结束'})
    status+=['data modify storage fimel_title:io text set value '+js({'text':'等待其他玩家行动','color':'yellow','bold':False})]
    for state,label in states.items():
        extra=[{'nbt':f'data.{ns}.p1.name','entity':f'@e[tag={p}.current,limit=1]','interpret':True}]
        status += [f'execute if entity @e[tag={p}.current,scores={{{p}_state={state}}},limit=1] run data modify storage fimel_title:io text set value '+js({'text':label,'color':'yellow','bold':False})]
    status += [f'function {ns}:hud/status_turn with entity @e[tag={p}.current,limit=1] data.{ns}']
    if ns=='magical_athlete':
        for side in range(1,7):
            status += [f'execute if entity @e[tag=ma.current,scores={{ma_pending={side}}},limit=1] run data modify storage fimel_title:io text.extra append value '+js({'text':' · 待回应：','color':'aqua','extra':[{'nbt':f'data.magical_athlete.p{side}.name','entity':'@e[tag=ma.current,limit=1]','interpret':True}]})]
    status += [f'function {ns}:hud/center']
    extra=[{'text':' · '},{'nbt':f'data.{ns}.p$(turn).name','entity':f'@e[tag={p}.current,limit=1]','interpret':True}]
    if ns=='magical_athlete':extra += [{'text':' · 第$(round)/4场','color':'gold'}]
    put('status_turn','$data modify storage fimel_title:io text.extra set value '+js(extra))
    put('status',status)
    put('notice', [f'$data modify storage {ns}:hud incoming set value $(text)',f'function {ns}:hud/activate',
        f'execute store result storage {ns}:hud panel int 1 run scoreboard players get @s {p}_hpanel',
        f'function {ns}:hud/store_notice with storage {ns}:hud',f'scoreboard players set @s {p}_htimer 80',f'function {ns}:hud/build'])
    put('store_notice',f'$data modify storage {ns}:hud notices.p$(panel) set from storage {ns}:hud incoming')
    put('show_notice',[f'execute store result storage {ns}:hud panel int 1 run scoreboard players get @s {p}_hpanel',f'function {ns}:hud/read_notice with storage {ns}:hud',f'function {ns}:hud/center'])
    put('read_notice',f'$data modify storage fimel_title:io text set from storage {ns}:hud notices.p$(panel)')
    put('tick',[f'execute if score @s {p}_htimer matches 1.. run scoreboard players remove @s {p}_htimer 1'])
    game=PACK/f'data/{ns}/function/game/hud.mcfunction'
    game.write_text(f'scoreboard players set @s {p}_pulse 0\nfunction {ns}:system/context\nexecute as @a[tag={p}.audience] run function {ns}:hud/build\n',encoding='utf-8')
