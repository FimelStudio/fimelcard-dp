"""普通玩家可用的卡坦岛私有菜单：单次nonce、桌号、载入代次和引擎epoch校验。"""
import json
from build_catan_game import put, ROOT
from catan_topology import PORTS
from build_catan_font import FONT_ID, RESOURCE_GLYPHS, DEVELOPMENT_GLYPHS

OBJECTIVES={n:'dummy' for n in ['ca_nonce','ca_ui_load','ca_ui_table','ca_seen','ca_edit','ca_partner','ca_pay','ca_receive','ca_batch','ca_a','ca_b','ca_panel','ca_trade_id']+[f'ca_{x}{i}' for x in ('g','w') for i in range(5)]}
R=['木材','砖块','羊毛','粮食','矿石']
COLORS=[('红','red'),('蓝','blue'),('白','white'),('橙','gold')]


def button(code,label,color='white',guard=None,icon=None):
    fields = {'code':code,'label':label,'color':color}
    if icon:
        fields['icon'] = icon
    cmd='function catan:ui/'+('icon_button' if icon else 'button')+' '+json.dumps(fields,ensure_ascii=False,separators=(',',':'))
    return 'execute '+guard+' run '+cmd if guard else cmd


def text(value, color='white'):
    return {'text': value, 'color': color}


def icon(glyph):
    return {'text': glyph, 'font': FONT_ID, 'color': 'white'}


def resources(field, heading='', color='white'):
    parts = [text(heading, color)] if heading else []
    for i, name in enumerate(R):
        parts += [icon(RESOURCE_GLYPHS[i]), text(' '+name+' ×$('+field+str(i)+')　', color)]
    return parts


def component_line(path, parts):
    return '$data modify storage catan:ui '+path+' set value '+json.dumps({'text':'','extra':parts},ensure_ascii=False,separators=(',',':'))


def main():
    (ROOT/'ui/editor_note.mcfunction').unlink(missing_ok=True)
    put('ui/begin','''
execute if score #panel_serial ca_ctx matches 99999.. run scoreboard players add #ui_load ca_ctx 1
execute unless score #panel_serial ca_ctx matches 1..99998 run scoreboard players set #panel_serial ca_ctx 1
scoreboard players add #panel_serial ca_ctx 1
scoreboard players operation @s ca_nonce = #panel_serial ca_ctx
scoreboard players operation @s ca_seen = @e[tag=ca.current,limit=1] ca_epoch
scoreboard players operation @s ca_ui_load = #ui_load ca_ctx
scoreboard players operation @s ca_ui_table = @s ca_table
scoreboard players operation #ui_base ca_ctx = @s ca_nonce
scoreboard players operation #ui_base ca_ctx *= #factor ca_ctx
data modify storage catan:ui buttons set value []
scoreboard players set @s ca_action 0
scoreboard players enable @s ca_action
scoreboard players set @s ca_panel 0
function catan:ui/summary
''')
    put('ui/button','''
$scoreboard players set #ui_code ca_ctx $(code)
scoreboard players operation #ui_code ca_ctx += #ui_base ca_ctx
execute store result storage catan:ui code int 1 run scoreboard players get #ui_code ca_ctx
$data modify storage catan:ui label set value "$(label)"
$data modify storage catan:ui color set value "$(color)"
function catan:ui/button_append with storage catan:ui
''')
    put('ui/button_append','$data modify storage catan:ui buttons append value {label:{text:"$(label)",color:"$(color)"},width:$(button_width),action:{type:"run_command",command:"trigger ca_action set $(code)"}}')
    put('ui/icon_button','''
$scoreboard players set #ui_code ca_ctx $(code)
scoreboard players operation #ui_code ca_ctx += #ui_base ca_ctx
execute store result storage catan:ui code int 1 run scoreboard players get #ui_code ca_ctx
$data modify storage catan:ui label set value "$(label)"
$data modify storage catan:ui color set value "$(color)"
$data modify storage catan:ui icon set value "$(icon)"
function catan:ui/icon_append with storage catan:ui
''')
    put('ui/icon_append','$data modify storage catan:ui buttons append value {label:{text:"",extra:[{text:"$(icon)",font:"card:catan",color:"white"},{text:" $(label)",color:"$(color)"}]},width:$(button_width),action:{type:"run_command",command:"trigger ca_action set $(code)"}}')
    put('ui/named_button','''
$scoreboard players set #ui_code ca_ctx $(code)
scoreboard players operation #ui_code ca_ctx += #ui_base ca_ctx
execute store result storage catan:ui code int 1 run scoreboard players get #ui_code ca_ctx
$data modify storage catan:ui button_name set from entity @e[tag=ca.current,limit=1] data.catan.p$(side).name
function catan:ui/named_append with storage catan:ui
''')
    put('ui/named_append','$data modify storage catan:ui buttons append value {label:$(button_name),width:$(button_width),action:{type:"run_command",command:"trigger ca_action set $(code)"}}')
    put('ui/summary','''
execute store result storage catan:ui side int 1 run scoreboard players get @s ca_side
function catan:ui/color_label
data modify storage catan:ui public set value {text:"",extra:[]}
data modify storage catan:ui phase set value "等待其他玩家操作。"
data modify storage catan:ui note set value {text:"",color:"aqua"}
data modify storage catan:ui title set value "卡坦岛 · 对局菜单"
data modify storage catan:ui columns set value 3
data modify storage catan:ui button_width set value 145
function catan:ui/private with storage catan:ui
execute as @e[tag=ca.current,limit=1] run function catan:ui/public
function catan:ui/phase
data modify storage catan:ui turn_name set value {text:"—",color:"gray"}
function catan:ui/turn_name with storage catan:ui
''')
    put('ui/turn_name','$data modify storage catan:ui turn_name set from entity @e[tag=ca.current,limit=1] data.catan.p$(turn).name')
    put('ui/color_label',[f'execute if score @s ca_side matches {side} run data modify storage catan:ui color_label set value "{label}"' for side,(label,color) in enumerate(COLORS,1)])
    private=['data modify storage catan:ui hand set value {resources:[0,0,0,0,0],dev:[0,0,0,0,0],fresh:[0,0,0,0,0],vp:0,roads_left:15,settlements_left:5,cities_left:4,discard_due:0}',
             '$data modify storage catan:ui hand merge from entity @e[tag=ca.current,limit=1] data.catan.p$(side)',
             '$data modify storage catan:ui hand.side set value $(side)',
             '$data modify storage catan:ui hand.color_label set value "$(color_label)"']
    private+=['data modify storage catan:ui bank set from entity @e[tag=ca.current,limit=1] data.catan.bank','function catan:ui/hand_summary with storage catan:ui hand']
    put('ui/private',private)
    put('ui/hand_summary',component_line('private', [text('你是 $(side) 号（$(color_label)）\n\n','gold')]+resources('r')+[text('\n\n胜利点：$(vp)　剩余道路$(roads_left)／村庄$(settlements_left)／城市$(cities_left)','gray')]))
    # 宏字段必须是平面名字；NBT path 不能直接当宏占位符。
    put('ui/private',private[:-1]+[f'data modify storage catan:ui hand.r{i} set from storage catan:ui hand.resources[{i}]' for i in range(5)]+['function catan:ui/hand_summary with storage catan:ui hand'])
    pub=[]
    for p in range(1,5):
        label,color=COLORS[p-1]
        pub += [f'execute if data entity @s data.catan.p{p}.name run function catan:ui/public_player {{side:{p},label:"{label}",color:"{color}"}}']
    put('ui/public',pub)
    put('ui/public_player','''
$data modify storage catan:ui person set from entity @s data.catan.p$(side)
$data modify storage catan:ui person.side set value $(side)
$data modify storage catan:ui person.color_label set value "$(label)"
$data modify storage catan:ui person.color set value "$(color)"
function catan:ui/public_append with storage catan:ui person
''')
    put('ui/public_append',r'$data modify storage catan:ui public.extra append value {text:"",extra:[{text:"$(side)号（$(color_label)）· ",color:"$(color)"},$(name),{text:" · $(public_vp)分 · $(resource_count)资源 · $(dev_count)开发牌\n",color:"gray"}]}')
    phase=[]
    for p,t in [(1,'初始布置：放置村庄'),(2,'初始布置：放置相邻道路'),(3,'投掷双骰'),(4,'建造、交易或使用开发牌'),(5,'掷出 7：超过 7 张资源的玩家必须弃一半（向下取整）'),(6,'移动强盗到其他地块'),(7,'选择强盗偷取对象'),(8,'修路卡：免费建造道路'),(10,'正在计算最长道路'),(11,'对局结束')]:
        phase += [f'execute if entity @e[tag=ca.current,scores={{ca_state={p}}},limit=1] run data modify storage catan:ui phase set value "{t}"']
    phase += ['execute store result storage catan:ui turn int 1 run scoreboard players get @e[tag=ca.current,limit=1] ca_turn']
    put('ui/phase',phase)
    put('ui/show','$dialog show @s {type:"minecraft:multi_action",title:{text:"$(title)",color:"gold"},body:[{type:"minecraft:plain_message",width:470,contents:{text:"$(phase)",color:"yellow"}},{type:"minecraft:plain_message",width:470,contents:{text:"当前行动：",color:"gray",extra:[$(turn_name)]}},{type:"minecraft:plain_message",width:470,contents:$(private)},{type:"minecraft:plain_message",width:470,contents:$(public)},{type:"minecraft:plain_message",width:470,contents:$(note)}],columns:$(columns),actions:$(buttons),exit_action:{label:{text:"返回棋盘"}},pause:false,after_action:"none"}')
    op=['function catan:input/context','execute unless entity @s[tag=ca.actor] run return 0','function catan:ui/begin']
    turn='if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn '
    normal=turn+'if entity @e[tag=ca.current,scores={ca_state=4,ca_anim=0},limit=1]'
    op += [button(100,'瞄准放置','green',turn+'if entity @e[tag=ca.current,scores={ca_state=1..2},limit=1]'),button(10,'投骰子','gold',turn+'if entity @e[tag=ca.current,scores={ca_state=3,ca_anim=0},limit=1]')]
    for code,label in [(102,'建村庄 · 木砖羊粮'),(103,'修道路 · 木砖'),(104,'升级城市 · 2粮3矿'),(23,'买开发牌 · 羊粮矿'),(210,'银行与港口'),(220,'使用开发牌'),(29,'结束回合')]:op+=[button(code,label,'white',normal)]
    op += [button(200,'玩家交易','aqua','if entity @e[tag=ca.current,scores={ca_state=4,ca_anim=0},limit=1]')]
    op += [button(220,'使用开发牌','aqua',turn+'if entity @e[tag=ca.current,scores={ca_state=3},limit=1]'),button(100,'选择强盗地块','red',turn+'if entity @e[tag=ca.current,scores={ca_state=6},limit=1]'),button(103,'免费修路','green',turn+'if entity @e[tag=ca.current,scores={ca_state=8},limit=1]'),button(31,'放弃剩余免费道路','gray',turn+'if entity @e[tag=ca.current,scores={ca_state=8},limit=1]'),button(230,'选择弃牌','red','if data storage catan:ui hand {discard_due:1}')]
    # 任意正数都必须可弃牌，不写死1张。
    op[-1]=button(230,'选择弃牌','red','if entity @e[tag=ca.current,scores={ca_state=5,ca_anim=0},limit=1] unless data storage catan:ui hand{discard_due:0}')
    for p in range(1,5):
        op += [f'execute {turn}if entity @e[tag=ca.current,scores={{ca_state=7,ca_anim=0}},limit=1] if data entity @e[tag=ca.current,limit=1] data.catan{{eligible:[{p}]}} run function catan:ui/named_button {{code:{400+p},side:{p}}}']
    op += [button(240,'查看交易请求','aqua','if data entity @e[tag=ca.current,limit=1] data.catan.trade'),button(250,'音乐开关','gray'),button(260,'规则','gray'),'function catan:ui/show with storage catan:ui']
    put('ui/open',op)
    put('ui/confirm',['function catan:ui/begin','scoreboard players set @s ca_panel 1','data modify storage catan:ui title set value "卡坦岛 · 确认位置"','execute store result storage catan:ui target int 1 run scoreboard players get @s ca_pick','data modify storage catan:ui note set value {text:"金色标记为目标位置。确认后按规则扣除费用。",color:"aqua"}',button(300,'确认放置','green'),button(100,'重新瞄准','yellow'),'function catan:ui/show with storage catan:ui'])
    put('ui/handle','''
scoreboard players operation #encoded ca_ctx = @s ca_action
scoreboard players set @s ca_action 0
function catan:input/context
execute unless entity @s[tag=ca.actor] run return 0
execute unless score #encoded ca_ctx matches 20000..999991141 run return 0
scoreboard players operation #nonce ca_ctx = #encoded ca_ctx
scoreboard players operation #nonce ca_ctx /= #factor ca_ctx
execute unless score #nonce ca_ctx = @s ca_nonce run return 0
scoreboard players reset @s ca_nonce
execute unless score @s ca_ui_load = #ui_load ca_ctx run return run function catan:ui/stale
execute unless score @s ca_ui_table = @s ca_table run return run function catan:ui/stale
execute unless score @s ca_seen = @e[tag=ca.current,limit=1] ca_epoch run return run function catan:ui/stale
scoreboard players operation #code ca_ctx = #encoded ca_ctx
scoreboard players operation #code ca_ctx %= #factor ca_ctx
function catan:ui/dispatch
''')
    put('ui/stale',['tellraw @s {text:"[卡坦岛] 局面已更新，请重新操作。",color:"gray"}','function catan:ui/open'])
    dispatch=[]
    for codes,panel in [('300',1),('501..504',2),('600..603',4),('1000..1141',3),('350..354',3),('360..361',5)]:
        dispatch += [f'execute if score #code ca_ctx matches {codes} unless score @s ca_panel matches {panel} run return run function catan:ui/open']
    for codes,edit in [('1000..1014','1..2'),('1020..1034','2'),('1100..1114','3'),('1120..1134','4..5'),('1140..1141','3')]:
        dispatch += [f'execute if score #code ca_ctx matches {codes} unless score @s ca_edit matches {edit} run return run function catan:ui/open']
    for code,edit in [(350,2),(351,1),(352,3),(353,4),(354,5)]:
        dispatch += [f'execute if score #code ca_ctx matches {code} unless score @s ca_edit matches {edit} run return run function catan:ui/open']
    for code in (10,23,29,31):dispatch += [f'execute if score #code ca_ctx matches {code} run return run function catan:ui/simple {{code:{code}}}']
    dispatch += ['execute if score #code ca_ctx matches 100 run return run function catan:input/aim']
    for code,mode in [(102,2),(103,3),(104,4)]:
        dispatch += [f'execute if score #code ca_ctx matches {code} run scoreboard players set @s ca_mode {mode}',f'execute if score #code ca_ctx matches {code} run return run function catan:ui/aim_note']
    for code,name in [(200,'partners'),(210,'bank'),(220,'development'),(230,'discard'),(240,'trade_response'),(250,'music'),(260,'rules'),(300,'place'),(350,'send_trade'),(351,'send_discard'),(352,'send_bank'),(353,'send_monopoly'),(354,'send_plenty'),(360,'accept'),(361,'refuse')]:
        dispatch += [f'execute if score #code ca_ctx matches {code} run return run function catan:ui/{name}']
    for p in range(1,5):
        dispatch += [f'execute if score #code ca_ctx matches {400+p} run return run function catan:ui/steal {{target:{p}}}',f'execute if score #code ca_ctx matches {500+p} run scoreboard players set @s ca_partner {p}',f'execute if score #code ca_ctx matches {500+p} run return run function catan:ui/trade_begin']
    for kind in range(4):dispatch += [f'execute if score #code ca_ctx matches {600+kind} run return run function catan:ui/dev_{kind}']
    for i in range(5):
        for base,obj,delta in [(1000,'g',1),(1010,'g',-1),(1020,'w',1),(1030,'w',-1)]:
            c=base+i
            dispatch += [f'execute if score #code ca_ctx matches {c} run scoreboard players {"add" if delta>0 else "remove"} @s ca_{obj}{i} {abs(delta)}',f'execute if score @s ca_{obj}{i} matches ..-1 run scoreboard players set @s ca_{obj}{i} 0',f'execute if score @s ca_{obj}{i} matches 20.. run scoreboard players set @s ca_{obj}{i} 19',f'execute if score #code ca_ctx matches {c} run return run function catan:ui/editor']
        for base,obj in [(1100,'pay'),(1110,'receive'),(1120,'a'),(1130,'b')]:
            dispatch += [f'execute if score #code ca_ctx matches {base+i} run scoreboard players set @s ca_{obj} {i}',f'execute if score #code ca_ctx matches {base+i} run return run function catan:ui/editor']
    for c,d in [(1140,1),(1141,-1)]:dispatch += [f'execute if score #code ca_ctx matches {c} run scoreboard players {"add" if d>0 else "remove"} @s ca_batch {abs(d)}',f'execute if score @s ca_batch matches ..0 run scoreboard players set @s ca_batch 1',f'execute if score @s ca_batch matches 20.. run scoreboard players set @s ca_batch 19',f'execute if score #code ca_ctx matches {c} run return run function catan:ui/editor']
    put('ui/dispatch',dispatch)
    put('ui/aim_note',['dialog clear @s','tellraw @s {text:"[卡坦岛] 右键棋盘选择位置；也可瞄准后在第 1 格按 Q。",color:"aqua"}'])
    put('ui/prepare','''
data modify storage catan:action input set value {actor:0,code:0,target:-1,a:-1,b:-1,epoch:0,offer:[0,0,0,0,0],want:[0,0,0,0,0]}
execute store result storage catan:action input.actor int 1 run scoreboard players get @s ca_side
execute store result storage catan:action input.epoch int 1 run scoreboard players get @s ca_seen
''')
    put('ui/submit',['dialog clear @s','execute as @e[tag=ca.current,limit=1] at @s run function catan:game/action'])
    put('ui/simple',['function catan:ui/prepare','$data modify storage catan:action input.code set value $(code)','function catan:ui/submit'])
    place=['function catan:ui/prepare','execute store result storage catan:action input.target int 1 run scoreboard players get @s ca_pick','data modify storage catan:action input.code set value 0','execute if score @s ca_mode matches 1 run data modify storage catan:action input.code set value 12','execute if score @s ca_mode matches 2 run data modify storage catan:action input.code set value 21','execute if score @s ca_mode matches 3 run data modify storage catan:action input.code set value 20','execute if score @s ca_mode matches 4 run data modify storage catan:action input.code set value 22','execute if entity @e[tag=ca.current,scores={ca_state=1},limit=1] run data modify storage catan:action input.code set value 1','execute if entity @e[tag=ca.current,scores={ca_state=2},limit=1] run data modify storage catan:action input.code set value 2','function catan:ui/submit']
    put('ui/place',place)
    put('ui/music',['execute as @e[tag=ca.current,limit=1] at @s run function catan:sound/toggle','function catan:ui/open'])
    put('ui/rules',['tag @a[tag=ct.rules_actor] remove ct.rules_actor','tag @s add ct.rules_actor','execute as @e[tag=ca.current,limit=1] at @s run function catan:rules/show','tag @s remove ct.rules_actor'])
    put('ui/steal',['function catan:ui/prepare','data modify storage catan:action input.code set value 13','$data modify storage catan:action input.target set value $(target)','function catan:ui/submit'])
    partners=['function catan:ui/begin','scoreboard players set @s ca_panel 2','data modify storage catan:ui title set value "卡坦岛 · 交易对象"','data modify storage catan:ui note set value {text:"选择交易对象；交易双方须包含当前行动者。",color:"aqua"}']
    for p in range(1,5):partners += [f'execute unless score @s ca_side matches {p} if data entity @e[tag=ca.current,limit=1] data.catan.p{p}.name run function catan:ui/partner {{side:{p},code:{500+p}}}']
    put('ui/partner',['$execute unless score @s ca_side = @e[tag=ca.current,limit=1] ca_turn unless score @e[tag=ca.current,limit=1] ca_turn matches $(side) run return 0','$function catan:ui/named_button {side:$(side),code:$(code)}'])
    put('ui/partners',partners+['function catan:ui/show with storage catan:ui'])
    reset=[f'scoreboard players set @s ca_{x}{i} 0' for x in ('g','w') for i in range(5)]
    put('ui/trade_begin',reset+['scoreboard players set @s ca_edit 2','function catan:ui/editor'])
    put('ui/discard',reset+['scoreboard players set @s ca_edit 1','function catan:ui/editor'])
    put('ui/bank',['scoreboard players set @s ca_edit 3','scoreboard players set @s ca_pay 0','scoreboard players set @s ca_receive 1','scoreboard players set @s ca_batch 1','function catan:ui/editor'])
    editor=['function catan:ui/begin','scoreboard players set @s ca_panel 3','data modify storage catan:ui title set value "卡坦岛 · 资源操作"','data modify storage catan:ui columns set value 2','execute if score @s ca_edit matches 2 run data modify storage catan:ui columns set value 4','execute if score @s ca_edit matches 2 run data modify storage catan:ui button_width set value 110','function catan:ui/editor_summary']
    for i,r in enumerate(R):
        glyph=RESOURCE_GLYPHS[i]
        editor += [button(1000+i,'弃 '+r+' +','yellow','if score @s ca_edit matches 1',glyph),button(1010+i,'弃 '+r+' −','gray','if score @s ca_edit matches 1',glyph),button(1000+i,'给 '+r+' +','yellow','if score @s ca_edit matches 2',glyph),button(1010+i,'给 '+r+' −','gray','if score @s ca_edit matches 2',glyph),button(1020+i,'索 '+r+' +','aqua','if score @s ca_edit matches 2',glyph),button(1030+i,'索 '+r+' −','gray','if score @s ca_edit matches 2',glyph),button(1100+i,'支付 '+r,'yellow','if score @s ca_edit matches 3',glyph),button(1110+i,'换取 '+r,'aqua','if score @s ca_edit matches 3',glyph),button(1120+i,'第一张 '+r,'aqua','if score @s ca_edit matches 5',glyph),button(1120+i,'垄断 '+r,'aqua','if score @s ca_edit matches 4',glyph),button(1130+i,'第二张 '+r,'yellow','if score @s ca_edit matches 5',glyph)]
    editor += [button(1140,'兑换批数 +','yellow','if score @s ca_edit matches 3'),button(1141,'兑换批数 −','gray','if score @s ca_edit matches 3')]
    for edit,c,label in [(1,351,'确认弃牌'),(2,350,'提交报价'),(3,352,'确认兑换'),(4,353,'确认垄断'),(5,354,'确认丰收')]:editor += [button(c,label,'green',f'if score @s ca_edit matches {edit}')]
    put('ui/editor',editor+['function catan:ui/show with storage catan:ui'])
    es=[]
    for x in ('g','w'):
        es += [f'execute store result storage catan:ui {x}{i} int 1 run scoreboard players get @s ca_{x}{i}' for i in range(5)]
    for name in ('partner','pay','receive','batch','a','b','edit'):es += [f'execute store result storage catan:ui {name} int 1 run scoreboard players get @s ca_{name}']
    es += ['data modify storage catan:ui due set from storage catan:ui hand.discard_due',
           'data modify storage catan:ui partner_name set value {text:"—"}',
           'function catan:ui/partner_name with storage catan:ui','function catan:ui/resource_labels',
           'execute if score @s ca_edit matches 3 run function catan:ui/bank_summary']
    for edit in range(1,6):es += [f'execute if score @s ca_edit matches {edit} run function catan:ui/editor_note_{edit} with storage catan:ui']
    put('ui/editor_summary',es)
    put('ui/partner_name','$data modify storage catan:ui partner_name set from entity @e[tag=ca.current,limit=1] data.catan.p$(partner).name')
    labels=[]
    for obj in ('pay','receive','a','b'):
        for i,label in enumerate(R):labels += [f'execute if score @s ca_{obj} matches {i} run data modify storage catan:ui {obj}_label set value "{label}"']
    put('ui/resource_labels',labels)
    put('ui/editor_note_1',component_line('note',[text('须弃 $(due) 张\n\n','red')]+resources('g','已选：','yellow')))
    put('ui/editor_note_2',component_line('note',[text('交易对象：','aqua'),{'nbt':'partner_name','storage':'catan:ui','interpret':True},text('\n\n')]+resources('g','你给予：','yellow')+[text('\n\n')]+resources('w','你索取：','aqua')).replace('{"nbt":"partner_name","storage":"catan:ui","interpret":true}','$(partner_name)'))
    bank_parts=[text('支付 $(pay_label)，换取 $(receive_label) ×$(batch)\n\n','aqua')]
    for i in range(5):
        bank_parts += [icon(RESOURCE_GLYPHS[i]),text(' '+R[i]+' $(ratio'+str(i)+'):1　')]
    bank_parts += [text('\n\n')]+resources('bank','银行：','gray')
    put('ui/editor_note_3',component_line('note',bank_parts))
    put('ui/editor_note_4',component_line('note',[icon(DEVELOPMENT_GLYPHS[2]),text(' 垄断资源：$(a_label)','aqua')]))
    put('ui/editor_note_5',component_line('note',[icon(DEVELOPMENT_GLYPHS[3]),text(' 发明取牌：$(a_label) ＋ $(b_label)','aqua')]))
    # Player-owned ports immediately affect the displayed bank ratios.
    bank=[f'scoreboard players set #ui_ratio{i} ca_ctx 4' for i in range(5)]
    for port in PORTS:
        for vertex in port['vertices']:
            bank += [f'execute store result score #ui_owner ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.vertex_owner[{vertex}]',f'execute if score #ui_owner ca_ctx = @s ca_side run function catan:ui/port_rate {{port:{port["id"]}}}']
    bank += [f'execute store result storage catan:ui ratio{i} int 1 run scoreboard players get #ui_ratio{i} ca_ctx' for i in range(5)]
    bank += [f'data modify storage catan:ui bank{i} set from storage catan:ui bank[{i}]' for i in range(5)]
    put('ui/bank_summary',bank)
    put('ui/port_rate',['$execute store result score #ui_port ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.port_types[$(port)]']+[f'execute if score #ui_port ca_ctx matches -1 if score #ui_ratio{i} ca_ctx matches 4 run scoreboard players set #ui_ratio{i} ca_ctx 3' for i in range(5)]+[f'execute if score #ui_port ca_ctx matches {i} run scoreboard players set #ui_ratio{i} ca_ctx 2' for i in range(5)])
    # 每人初始化全部编辑字段，避免未定义占位符使整个宏静默失败。
    put('ui/init',reset+[f'scoreboard players set @s ca_{name} {value}' for name,value in [('partner',0),('pay',0),('receive',1),('batch',1),('a',0),('b',1),('edit',0),('panel',0),('trade_id',-1)]])
    for name,code in [('send_trade',40),('send_discard',11),('send_bank',50),('send_monopoly',30),('send_plenty',30)]:
        s=['function catan:ui/prepare',f'data modify storage catan:action input.code set value {code}']
        for x,path in [('g','offer'),('w','want')]:s += [f'execute store result storage catan:action input.{path}[{i}] int 1 run scoreboard players get @s ca_{x}{i}' for i in range(5)]
        if name=='send_trade':s+=['execute store result storage catan:action input.target int 1 run scoreboard players get @s ca_partner']
        if name=='send_bank':s += [f'execute store result storage catan:action input.{path} int 1 run scoreboard players get @s ca_{obj}' for path,obj in [('target','pay'),('a','receive'),('b','batch')]]
        if name in ('send_monopoly','send_plenty'):
            s += [f'data modify storage catan:action input.target set value {2 if name=="send_monopoly" else 3}']+[f'execute store result storage catan:action input.{x} int 1 run scoreboard players get @s ca_{x}' for x in ('a','b')]
        put('ui/'+name,s+['function catan:ui/submit'])
    dev=['function catan:ui/begin','scoreboard players set @s ca_panel 4','data modify storage catan:ui title set value "卡坦岛 · 开发牌"','data modify storage catan:ui columns set value 2']
    dev += [f'data modify storage catan:ui old{i} set from storage catan:ui hand.dev[{i}]' for i in range(5)]
    dev += [f'data modify storage catan:ui new{i} set from storage catan:ui hand.fresh[{i}]' for i in range(5)]
    dev += ['function catan:ui/development_note with storage catan:ui']
    dev_parts=[text('牌种　　　　旧牌 / 本回合买入\n\n','gray')]
    for i,name in enumerate(['骑士','修路','垄断','发明','胜利点']):
        dev_parts += [icon(DEVELOPMENT_GLYPHS[i]),text(' '+name+'　'),text('$(old'+str(i)+')','aqua'),text(' / '),text('$(new'+str(i)+')','gray'),text('\n\n')]
    dev_parts += [text('每回合至多使用一张非胜利点旧牌。新买牌下回合才能使用；胜利点自动计分。','gray')]
    put('ui/development_note',component_line('note',dev_parts))
    for i,n in enumerate(['骑士','修路','垄断','发明']):dev += [button(600+i,n,'aqua',icon=DEVELOPMENT_GLYPHS[i])]
    put('ui/development',dev+['function catan:ui/show with storage catan:ui'])
    for i in range(4):
        if i<2:put(f'ui/dev_{i}',['function catan:ui/prepare','data modify storage catan:action input.code set value 30',f'data modify storage catan:action input.target set value {i}','function catan:ui/submit'])
        else:put(f'ui/dev_{i}',[f'scoreboard players set @s ca_edit {i+2}','function catan:ui/editor'])
    put('ui/trade_response',['execute unless data entity @e[tag=ca.current,limit=1] data.catan.trade run return run function catan:ui/open','data modify storage catan:ui trade set from entity @e[tag=ca.current,limit=1] data.catan.trade','function catan:ui/trade_guard with storage catan:ui trade'])
    put('ui/trade_guard',['$execute unless score @s ca_side matches $(from) unless score @s ca_side matches $(to) run return run function catan:ui/open','function catan:ui/begin','scoreboard players set @s ca_panel 5','data modify storage catan:ui trade set from entity @e[tag=ca.current,limit=1] data.catan.trade','execute store result score @s ca_trade_id run data get storage catan:ui trade.id']+[f'data modify storage catan:ui trade.{x}{i} set from storage catan:ui trade.{field}[{i}]' for x,field in [('g','offer'),('w','want')] for i in range(5)]+['function catan:ui/trade_names with storage catan:ui trade','function catan:ui/trade_note with storage catan:ui trade',button(360,'同意交易','green','if score @s ca_side = #ui_trade_to ca_ctx'),button(361,'拒绝／撤销','red'),'function catan:ui/show with storage catan:ui'])
    put('ui/trade_names',['$data modify storage catan:ui trade.from_name set from entity @e[tag=ca.current,limit=1] data.catan.p$(from).name','$data modify storage catan:ui trade.to_name set from entity @e[tag=ca.current,limit=1] data.catan.p$(to).name','$scoreboard players set #ui_trade_to ca_ctx $(to)'])
    trade_parts=[{'text':'FROM_NAME'},text(' → '),{'text':'TO_NAME'},text('\n\n')]+resources('g','发起者给予：','yellow')+[text('\n\n')]+resources('w','发起者索取：','aqua')
    put('ui/trade_note',component_line('note',trade_parts).replace('{"text":"FROM_NAME"}','$(from_name)').replace('{"text":"TO_NAME"}','$(to_name)'))
    for name,code in [('accept',41),('refuse',42)]:put('ui/'+name,['function catan:ui/prepare',f'data modify storage catan:action input.code set value {code}','execute store result storage catan:action input.target int 1 run scoreboard players get @s ca_trade_id','function catan:ui/submit'])
    print('Catan private dialogs generated')


if __name__=='__main__': main()
