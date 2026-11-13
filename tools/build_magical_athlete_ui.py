# -*- coding: utf-8 -*-
"""胡闹运动会：私有阵容、公开选角和技能目标窗口，所有提交使用一次性 trigger。"""
import json
from build_magical_athlete_game import put as _put, PACK


def put(name, body):
    """Minecraft函数每行一条命令；SNBT文本内的换行保存为反斜线n。"""
    source='\n'.join(body) if isinstance(body,list) else body
    out=[];quote=None;escaped=False
    for char in source:
        if quote:
            if char=='\n':out.append('\\n');continue
            out.append(char)
            if escaped:escaped=False
            elif char=='\\':escaped=True
            elif char==quote:quote=None
        else:
            out.append(char)
            if char in ('"',"'"):quote=char
    _put(name,''.join(out))


def js(value):return json.dumps(value,ensure_ascii=False,separators=(',',':'))


def button(code,label,color='white'):
    return 'function magical_athlete:ui/button '+js({'code':code,'label':label,'color':color})


def main():
    source=json.loads((PACK/'tools/magical_athlete_characters.json').read_text(encoding='utf-8'))
    chars=source if isinstance(source,list) else source['characters']
    put('ui/load','data modify storage magical_athlete:characters chars set value '+js(chars))
    put('ui/begin','''
execute if score #panel_serial ma_ctx matches 99999.. run scoreboard players add #ui_load ma_ctx 1
execute unless score #panel_serial ma_ctx matches 1..99998 run scoreboard players set #panel_serial ma_ctx 1
scoreboard players add #panel_serial ma_ctx 1
scoreboard players operation @s ma_nonce = #panel_serial ma_ctx
scoreboard players operation @s ma_seen = @e[tag=ma.current,limit=1] ma_epoch
scoreboard players operation @s ma_ui_load = #ui_load ma_ctx
scoreboard players operation @s ma_ui_table = @s ma_table
scoreboard players operation @s ma_ui_seat = @s ct_seat
scoreboard players operation #ui_base ma_ctx = @s ma_nonce
scoreboard players operation #ui_base ma_ctx *= #factor ma_ctx
scoreboard players set @s ma_action 0
scoreboard players enable @s ma_action
data modify storage magical_athlete:ui buttons set value []
data modify storage magical_athlete:ui detail set value {text:"",extra:[{text:""}]}
data modify storage magical_athlete:ui title set value "胡闹运动会 · 比赛菜单"
execute store result storage magical_athlete:ui close int 1 run scoreboard players get #ui_base ma_ctx
execute store result storage magical_athlete:ui side int 1 run scoreboard players get @s ma_side
function magical_athlete:ui/private with storage magical_athlete:ui
execute as @e[tag=ma.current,limit=1] run function magical_athlete:ui/summary with entity @s data.magical_athlete
''')
    put('ui/button','''
$scoreboard players set #ui_code ma_ctx $(code)
scoreboard players operation #ui_code ma_ctx += #ui_base ma_ctx
execute store result storage magical_athlete:ui code int 1 run scoreboard players get #ui_code ma_ctx
$data modify storage magical_athlete:ui label set value "$(label)"
$data modify storage magical_athlete:ui color set value "$(color)"
function magical_athlete:ui/button_append with storage magical_athlete:ui
''')
    put('ui/button_append','$data modify storage magical_athlete:ui buttons append value {label:{text:"$(label)",color:"$(color)"},width:145,action:{type:"minecraft:run_command",command:"trigger ma_action set $(code)"}}')
    put('ui/show','$dialog show @s {type:"minecraft:multi_action",title:{text:"$(title)",color:"gold"},body:[{type:"minecraft:plain_message",width:470,contents:$(public)},{type:"minecraft:plain_message",width:470,contents:$(private)},{type:"minecraft:plain_message",width:470,contents:$(detail)}],columns:3,actions:$(buttons),exit_action:{label:{text:"返回牌桌"},action:{type:"minecraft:run_command",command:"trigger ma_action set $(close)"}},pause:false,can_close_with_escape:true,after_action:"none"}')
    put('ui/private','''
$data modify storage magical_athlete:ui hand set from entity @e[tag=ma.current,limit=1] data.magical_athlete.p$(side)
function magical_athlete:ui/private_summary with storage magical_athlete:ui hand
''')
    put('ui/private_summary','$data modify storage magical_athlete:ui private set value {text:"你的队伍：$(points)分",color:"aqua"}')
    put('ui/summary','''
$data modify storage magical_athlete:ui public set value {text:"第$(round)／4场 · ",color:"gold",extra:[]}
$data modify storage magical_athlete:ui public.extra append from entity @s data.magical_athlete.p$(turn).name
execute if score @s ma_state matches 1 run data modify storage magical_athlete:ui public.extra append value {text:" 选角中",color:"yellow"}
execute if score @s ma_state matches 2 run data modify storage magical_athlete:ui public.extra append value {text:" · 各队秘密选择参赛选手",color:"yellow"}
execute if score @s ma_state matches 3 run data modify storage magical_athlete:ui public.extra append value {text:" 行动中",color:"yellow"}
execute if score @s ma_state matches 4 run data modify storage magical_athlete:ui public.extra append value {text:" · 本场已结束",color:"green"}
execute if score @s ma_state matches 5 run data modify storage magical_athlete:ui public.extra append value {text:" · 全场已结束",color:"green"}
execute if data entity @s data.magical_athlete{track:0} run data modify storage magical_athlete:ui public.extra append value {text:" · 普通跑道",color:"gray"}
execute if data entity @s data.magical_athlete{track:1} run data modify storage magical_athlete:ui public.extra append value {text:" · 狂野跑道",color:"red"}
''')
    put('ui/open','''
function magical_athlete:input/context
execute unless entity @s[tag=ma.actor] run return 0
function magical_athlete:ui/begin
execute if entity @e[tag=ma.current,scores={ma_anim=1..},limit=1] run data modify storage magical_athlete:ui detail.extra append value {text:"正在播放比赛动画……",color:"gray"}
execute if entity @e[tag=ma.current,scores={ma_anim=0},limit=1] run function magical_athlete:ui/phase
'''+ '\n'.join([button(6,'我的队员','aqua'),button(7,'比赛与积分','aqua'),button(8,'游戏规则','gray'),button(9,'音乐开关','gray'),'function magical_athlete:ui/show with storage magical_athlete:ui']))
    put('ui/phase','''
execute if entity @e[tag=ma.current,scores={ma_state=1},limit=1] run return run function magical_athlete:ui/draft
execute if entity @e[tag=ma.current,scores={ma_state=2},limit=1] run return run function magical_athlete:ui/lineup
execute if entity @e[tag=ma.current,scores={ma_state=4},limit=1] run return run function magical_athlete:ui/results
execute if score @s ma_side = @e[tag=ma.current,limit=1] ma_pending run return run function magical_athlete:ui/pending
execute if score @s ma_side = @e[tag=ma.current,limit=1] ma_turn run return run function magical_athlete:ui/start_pawn
data modify storage magical_athlete:ui detail.extra append value {text:"等待其他队伍行动。",color:"gray"}
''')
    put('ui/draft',['execute unless score @s ma_side = @e[tag=ma.current,limit=1] ma_turn run return 0','data modify storage magical_athlete:ui title set value "胡闹运动会 · 选择队员"','data modify storage magical_athlete:ui detail.extra append value {text:"点击选手加入自己的队伍。\n\n",color:"yellow"}']+[f'execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{{pool:[{c["id"]}]}} run function magical_athlete:ui/character {{id:{c["id"]},code:{100+c["id"]}}}' for c in chars])
    put('ui/lineup',['data modify storage magical_athlete:ui title set value "胡闹运动会 · 秘密参赛阵容"','scoreboard players set #selected ma_ctx 0','execute store result score #selected ma_ctx run data get storage magical_athlete:ui hand.selected','execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{n:2} if score #selected ma_ctx matches 2.. run return run function magical_athlete:ui/lineup_wait','execute unless data entity @e[tag=ma.current,limit=1] data.magical_athlete{n:2} if score #selected ma_ctx matches 1.. run return run function magical_athlete:ui/lineup_wait','data modify storage magical_athlete:ui detail.extra append value {text:"从尚未参赛的队员中选择，各队选好后一起公开。两人局每队选择两位，先选的角色先行动，此后本场顺序固定。\n\n",color:"yellow"}']+[f'execute if data storage magical_athlete:ui hand{{hand:[{c["id"]}]}} run function magical_athlete:ui/character {{id:{c["id"]},code:{200+c["id"]}}}' for c in chars])
    put('ui/lineup_wait','data modify storage magical_athlete:ui detail.extra append value {text:"本场阵容已提交，等待其他队伍选择。",color:"gray"}')
    # 角色说明和按钮来自唯一36角元数据；图片字体留出24px基线。
    character=['$data modify storage magical_athlete:ui character set from storage magical_athlete:characters chars[$(id)]','$scoreboard players set #ui_code ma_ctx $(code)','scoreboard players operation #ui_code ma_ctx += #ui_base ma_ctx','execute store result storage magical_athlete:ui character.command int 1 run scoreboard players get #ui_code ma_ctx']
    character += [f'$execute if predicate {{condition:"minecraft:value_check",value:$(id),range:{c["id"]}}} run data modify storage magical_athlete:ui character.glyph set value '+js(chr(0xE200+c['id'])) for c in chars]
    character += ['function magical_athlete:ui/character_append with storage magical_athlete:ui character']
    put('ui/character',character)
    put('ui/character_append','$data modify storage magical_athlete:ui detail.extra append value {text:"",extra:[{text:"$(glyph)",font:"magical_athlete:icons",click_event:{action:"run_command",command:"trigger ma_action set $(command)"}},{text:" $(name) ",color:"aqua",bold:true,click_event:{action:"run_command",command:"trigger ma_action set $(command)"}},{text:"\n$(ability)\n\n\n",color:"gray"}]}')
    put('ui/start_pawn',['execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.queue[0] run return 0','data modify storage magical_athlete:ui detail.extra append value {text:"请选择本回合行动的选手。技能、投骰及其连锁全部结算后才轮到下一位。\n",color:"yellow"}']+[f'execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[{i}] run function magical_athlete:ui/pawn_button {{index:{i}}}' for i in range(6)])
    put('ui/pawn_button','''
$data modify storage magical_athlete:ui racer set from entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[$(index)]
$data modify storage magical_athlete:ui racer.index set value $(index)
execute store result score #pawn_owner ma_ctx run data get storage magical_athlete:ui racer.owner
execute unless score #pawn_owner ma_ctx = @s ma_side run return 0
execute if data storage magical_athlete:ui racer{status:1} run return 0
execute if data storage magical_athlete:ui racer{status:2} run return 0
execute if data storage magical_athlete:ui racer{done:1} run return 0
scoreboard players set #forced ma_ctx -1
execute store result score #forced ma_ctx run data get entity @e[tag=ma.current,limit=1] data.magical_athlete.forced
$scoreboard players set #pawn_index ma_ctx $(index)
execute if score #forced ma_ctx matches 0..5 unless score #forced ma_ctx = #pawn_index ma_ctx run return 0
scoreboard players set #allowed ma_ctx 1
'''+ '\n'.join(f'execute if score #forced ma_ctx matches -1 if score #pawn_index ma_ctx matches {j+1}..5 if data entity @e[tag=ma.current,limit=1] data.magical_athlete{{n:2}} run function magical_athlete:ui/prior_pawn {{index:{j}}}' for j in range(5))+'''
execute unless score #allowed ma_ctx matches 1 run return 0
function magical_athlete:ui/pawn_name with storage magical_athlete:ui racer
''')
    put('ui/prior_pawn',['$data modify storage magical_athlete:ui prior set from entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[$(index)]','execute unless data storage magical_athlete:ui prior{status:0,done:0} run return 0','execute store result score #earlier_owner ma_ctx run data get storage magical_athlete:ui prior.owner','execute if score #earlier_owner ma_ctx = @s ma_side run scoreboard players set #allowed ma_ctx 0'])
    put('ui/pawn_name','''
$data modify storage magical_athlete:ui character set from storage magical_athlete:characters chars[$(char)]
$scoreboard players set #button_code ma_ctx $(index)
scoreboard players add #button_code ma_ctx 300
execute store result storage magical_athlete:ui character.code int 1 run scoreboard players get #button_code ma_ctx
function magical_athlete:ui/pawn_label with storage magical_athlete:ui character
''')
    put('ui/pawn_label','$function magical_athlete:ui/button {code:$(code),label:"$(name)行动",color:"green"}')
    put('ui/pending','''
data modify storage magical_athlete:ui pending set from entity @e[tag=ma.current,limit=1] data.magical_athlete.pending
data modify storage magical_athlete:ui title set value "胡闹运动会 · 选手技能"
function magical_athlete:ui/pending_description with storage magical_athlete:ui pending
'''+ '\n'.join(f'execute if data storage magical_athlete:ui pending.options[{i}] run function magical_athlete:ui/option {{index:{i}}}' for i in range(36)))
    kinds={'ready':'开始主要移动','reroll':'是否重掷？接受后按当前骰值前进；重掷必须使用新的结果。','alchemist':'炼金术士：将本次1或2改为4？','rocket':'火箭科学家：移动翻倍，随后绊倒？','cheerleader':'啦啦队长：给末位选手加油？','hypnotist':'催眠师：选择传送到自己位置的选手。','flip':'翻转者：选择交换位置的选手。','duel':'决斗者：选择同格对手决斗。','mastermind':'谋划者：预测本场冠军。','copycat':'模仿者：选择本场要复制的能力。','genius':'天才：选择要预测的骰值（0表示放弃）。','legs':'大长腿：选择正常掷骰，或直接前进5格。','egg':'蛋：选择孵化后的角色。','twin':'双胞胎：选择附带的角色能力。','suckerfish':'吸盘鱼：跟随目标一起移动？','thirdwheel':'电灯泡：选择要插入的格子，或放弃。'}
    put('ui/pending_description',['data modify storage magical_athlete:ui detail.extra append value {text:"请选择技能选项。\n\n",color:"yellow"}']+[f'execute if data storage magical_athlete:ui pending{{kind:"{key}"}} run data modify storage magical_athlete:ui detail.extra append value '+js({'text':value+'\n\n','color':'aqua'}) for key,value in kinds.items()])
    put('ui/option','''
$data modify storage magical_athlete:ui target set from storage magical_athlete:ui pending.options[$(index)]
execute store result score #option ma_ctx run data get storage magical_athlete:ui target
scoreboard players operation #choice_code ma_ctx = #option ma_ctx
scoreboard players add #choice_code ma_ctx 2100
execute store result storage magical_athlete:ui option.code int 1 run scoreboard players get #choice_code ma_ctx
data modify storage magical_athlete:ui option.target set from storage magical_athlete:ui target
data modify storage magical_athlete:ui option.kind set from storage magical_athlete:ui pending.kind
function magical_athlete:ui/option_label with storage magical_athlete:ui option
''')
    put('ui/option_label','''
$data modify storage magical_athlete:ui option.label set value "选项 $(target)"
$execute if predicate {condition:"minecraft:value_check",value:$(target),range:-1} run data modify storage magical_athlete:ui option.label set value "放弃技能"
execute if data storage magical_athlete:ui option{kind:"ready"} run data modify storage magical_athlete:ui option.label set value "投骰／开始移动"
'''+ '\n'.join(f'execute if data storage magical_athlete:ui option{{kind:"{kind}",target:{target}}} run data modify storage magical_athlete:ui option.label set value '+js(label) for kind,pairs in {'reroll':[(0,'接受骰值'),(1,'再掷一次')],'alchemist':[(0,'保留骰值'),(1,'改为4点')],'rocket':[(0,'正常前进'),(1,'移动翻倍并绊倒')],'cheerleader':[(0,'不加油'),(1,'加油')],'legs':[(0,'正常投骰'),(1,'直接前进5格')],'genius':[(0,'不预测')],'suckerfish':[(0,'不跟随'),(1,'跟随移动')]}.items() for target,label in pairs)+'''
execute if data storage magical_athlete:ui option{kind:"hypnotist"} run function magical_athlete:ui/target_label with storage magical_athlete:ui option
execute if data storage magical_athlete:ui option{kind:"flip"} run function magical_athlete:ui/target_label with storage magical_athlete:ui option
execute if data storage magical_athlete:ui option{kind:"duel"} run function magical_athlete:ui/target_label with storage magical_athlete:ui option
execute if data storage magical_athlete:ui option{kind:"mastermind"} run function magical_athlete:ui/target_label with storage magical_athlete:ui option
execute if data storage magical_athlete:ui option{kind:"copycat"} run function magical_athlete:ui/target_label with storage magical_athlete:ui option
execute if data storage magical_athlete:ui option{kind:"egg"} run function magical_athlete:ui/character_label with storage magical_athlete:ui option
execute if data storage magical_athlete:ui option{kind:"twin"} run function magical_athlete:ui/character_label with storage magical_athlete:ui option
execute if data storage magical_athlete:ui option{kind:"genius"} unless score #option ma_ctx matches 0 run function magical_athlete:ui/guess_label with storage magical_athlete:ui option
execute if data storage magical_athlete:ui option{kind:"thirdwheel"} unless score #option ma_ctx matches -1 run function magical_athlete:ui/space_label with storage magical_athlete:ui option
function magical_athlete:ui/choice_button with storage magical_athlete:ui option
''')
    put('ui/target_label','''
execute if score #option ma_ctx matches -1 run return 0
$execute unless data entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[$(target)] run return 0
$data modify storage magical_athlete:ui target_racer set from entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[$(target)]
function magical_athlete:ui/target_name with storage magical_athlete:ui target_racer
''')
    put('ui/target_name',['$data modify storage magical_athlete:ui target_char set from storage magical_athlete:characters chars[$(char)]','function magical_athlete:ui/character_label_show with storage magical_athlete:ui target_char'])
    put('ui/character_label',['execute if score #option ma_ctx matches -1 run return 0','$execute unless data storage magical_athlete:characters chars[$(target)] run return 0','$data modify storage magical_athlete:ui target_char set from storage magical_athlete:characters chars[$(target)]','function magical_athlete:ui/character_label_show with storage magical_athlete:ui target_char','function magical_athlete:ui/ability_description with storage magical_athlete:ui target_char'])
    put('ui/character_label_show','$data modify storage magical_athlete:ui option.label set value "$(name)"')
    put('ui/ability_description','$data modify storage magical_athlete:ui detail.extra append value {text:"$(name)：$(ability)\n\n",color:"aqua"}')
    put('ui/guess_label','$data modify storage magical_athlete:ui option.label set value "预测$(target)点"')
    put('ui/space_label','$data modify storage magical_athlete:ui option.label set value "前往第$(target)格"')
    put('ui/choice_button','$function magical_athlete:ui/button {code:$(code),label:"$(label)",color:"green"}')
    put('ui/results',['data modify storage magical_athlete:ui detail.extra append value {text:"本场积分已结算。查看队伍积分后，任意玩家可进入下一场；尚未参赛的队员继续留队。",color:"yellow"}',button(5,'进入下一场','green')])
    put('ui/myteam',['function magical_athlete:ui/begin','data modify storage magical_athlete:ui title set value "胡闹运动会 · 我的队员"','data modify storage magical_athlete:ui detail.extra append value {text:"尚未参赛：\n\n",color:"gold"}']+[f'execute if data storage magical_athlete:ui hand{{hand:[{c["id"]}]}} run function magical_athlete:ui/character {{id:{c["id"]},code:1}}' for c in chars]+['data modify storage magical_athlete:ui detail.extra append value {text:"本场参赛阵容（仅本人）：\n\n",color:"gold"}']+[f'execute if data storage magical_athlete:ui hand{{selected:[{c["id"]}]}} run function magical_athlete:ui/character {{id:{c["id"]},code:1}}' for c in chars]+[button(1,'返回比赛菜单'),'function magical_athlete:ui/show with storage magical_athlete:ui'])
    put('ui/public',['function magical_athlete:ui/begin','data modify storage magical_athlete:ui title set value "胡闹运动会 · 比赛与积分"']+[f'execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.p{i}.name run function magical_athlete:ui/team {{side:{i}}}' for i in range(1,7)]+['data modify storage magical_athlete:ui detail.extra append value {text:"\n当前跑道：\n",color:"gold"}']+[f'execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[{i}] run function magical_athlete:ui/public_racer {{index:{i}}}' for i in range(6)]+[button(1,'返回比赛菜单'),'function magical_athlete:ui/show with storage magical_athlete:ui'])
    put('ui/team','''
$data modify storage magical_athlete:ui team set from entity @e[tag=ma.current,limit=1] data.magical_athlete.p$(side)
function magical_athlete:ui/team_append with storage magical_athlete:ui team
''')
    put('ui/team_append','$data modify storage magical_athlete:ui detail.extra append value {text:"",extra:[$(name),{text:" · $(points)分\n",color:"gold"}]}')
    put('ui/public_racer','''
$data modify storage magical_athlete:ui racer set from entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[$(index)]
execute if data storage magical_athlete:ui racer{char:-1} run return 0
execute if data storage magical_athlete:ui racer{owner:0} run return 0
function magical_athlete:ui/public_racer_data with storage magical_athlete:ui racer
''')
    put('ui/public_racer_data','''
$data modify storage magical_athlete:ui racer.name set from storage magical_athlete:characters chars[$(char)].name
$data modify storage magical_athlete:ui racer.ability set from storage magical_athlete:characters chars[$(char)].ability
$data modify storage magical_athlete:ui racer.owner_name set from entity @e[tag=ma.current,limit=1] data.magical_athlete.p$(owner).name
data modify storage magical_athlete:ui racer.state_label set value "比赛中"
execute if data storage magical_athlete:ui racer{status:1} run data modify storage magical_athlete:ui racer.state_label set value "已冲线"
execute if data storage magical_athlete:ui racer{status:2} run data modify storage magical_athlete:ui racer.state_label set value "已淘汰"
data modify storage magical_athlete:ui racer.trip_label set value ""
execute if data storage magical_athlete:ui racer{trip:1} run data modify storage magical_athlete:ui racer.trip_label set value " · 已绊倒"
function magical_athlete:ui/public_racer_show with storage magical_athlete:ui racer
execute store result score #actual_char ma_ctx run data get storage magical_athlete:ui racer.char
execute store result score #actual_power ma_ctx run data get storage magical_athlete:ui racer.power
execute unless score #actual_char ma_ctx = #actual_power ma_ctx if score #actual_power ma_ctx matches 0..35 run function magical_athlete:ui/public_power with storage magical_athlete:ui racer
''')
    put('ui/public_racer_show','$data modify storage magical_athlete:ui detail.extra append value {text:"",extra:[{text:"$(name) · 第$(pos)格 · $(state_label)$(trip_label) · ",color:"aqua"},$(owner_name),{text:"\n固有能力：$(ability)\n\n",color:"gray"}]}')
    put('ui/public_power',['$data modify storage magical_athlete:ui power set from storage magical_athlete:characters chars[$(power)]','function magical_athlete:ui/public_power_show with storage magical_athlete:ui power'])
    put('ui/public_power_show','$data modify storage magical_athlete:ui detail.extra append value {text:"当前继承 · $(name)：$(ability)\n\n",color:"yellow"}')
    put('ui/handle','''
scoreboard players operation #encoded ma_ctx = @s ma_action
scoreboard players set @s ma_action 0
function magical_athlete:input/context
execute unless entity @s[tag=ma.actor] run scoreboard players reset @s ma_nonce
execute unless entity @s[tag=ma.actor] run return 0
execute unless score #encoded ma_ctx matches 20000..999992135 run return 0
scoreboard players operation #nonce ma_ctx = #encoded ma_ctx
scoreboard players operation #nonce ma_ctx /= #factor ma_ctx
execute unless score #nonce ma_ctx = @s ma_nonce run return 0
scoreboard players reset @s ma_nonce
execute unless score @s ma_ui_load = #ui_load ma_ctx run return run function magical_athlete:ui/stale
execute unless score @s ma_ui_table = @s ma_table run return run function magical_athlete:ui/stale
execute unless score @s ma_ui_seat = @s ct_seat run return run function magical_athlete:ui/stale
execute unless score @s ma_seen = @e[tag=ma.current,limit=1] ma_epoch run return run function magical_athlete:ui/stale
scoreboard players operation #code ma_ctx = #encoded ma_ctx
scoreboard players operation #code ma_ctx %= #factor ma_ctx
execute if score #code ma_ctx matches 0 run return run dialog clear @s
function magical_athlete:ui/dispatch
''')
    put('ui/dispatch','''
execute if score #code ma_ctx matches 1 run return run function magical_athlete:ui/open
execute if score #code ma_ctx matches 6 run return run function magical_athlete:ui/myteam
execute if score #code ma_ctx matches 7 run return run function magical_athlete:ui/public
execute if score #code ma_ctx matches 8 run return run function magical_athlete:ui/rules
execute if score #code ma_ctx matches 9 run return run function magical_athlete:ui/music
execute if entity @e[tag=ma.current,scores={ma_anim=1..},limit=1] run return run function magical_athlete:ui/open
scoreboard players set #action_code ma_ctx 0
scoreboard players set #target ma_ctx 0
execute if score #code ma_ctx matches 5 run scoreboard players set #action_code ma_ctx 5
execute if score #code ma_ctx matches 100..135 run scoreboard players set #action_code ma_ctx 1
execute if score #code ma_ctx matches 100..135 run scoreboard players operation #target ma_ctx = #code ma_ctx
execute if score #code ma_ctx matches 100..135 run scoreboard players remove #target ma_ctx 100
execute if score #code ma_ctx matches 200..235 run scoreboard players set #action_code ma_ctx 2
execute if score #code ma_ctx matches 200..235 run scoreboard players operation #target ma_ctx = #code ma_ctx
execute if score #code ma_ctx matches 200..235 run scoreboard players remove #target ma_ctx 200
execute if score #code ma_ctx matches 300..305 run scoreboard players set #action_code ma_ctx 3
execute if score #code ma_ctx matches 300..305 run scoreboard players operation #target ma_ctx = #code ma_ctx
execute if score #code ma_ctx matches 300..305 run scoreboard players remove #target ma_ctx 300
execute if score #code ma_ctx matches 2099..2135 run scoreboard players set #action_code ma_ctx 4
execute if score #code ma_ctx matches 2099..2135 run scoreboard players operation #target ma_ctx = #code ma_ctx
execute if score #code ma_ctx matches 2099..2135 run scoreboard players remove #target ma_ctx 2100
execute if score #action_code ma_ctx matches 0 run return run function magical_athlete:ui/open
data modify storage magical_athlete:action input set value {actor:0,code:0,target:0,epoch:0}
execute store result storage magical_athlete:action input.actor int 1 run scoreboard players get @s ma_side
execute store result storage magical_athlete:action input.code int 1 run scoreboard players get #action_code ma_ctx
execute store result storage magical_athlete:action input.target int 1 run scoreboard players get #target ma_ctx
execute store result storage magical_athlete:action input.epoch int 1 run scoreboard players get @s ma_seen
execute as @e[tag=ma.current,limit=1] at @s run function magical_athlete:game/action
''')
    put('ui/stale',['tellraw @s {text:"[胡闹运动会] 局面或窗口已更新，请重新选择。",color:"gray"}','function magical_athlete:ui/open'])
    put('ui/refresh','''
function magical_athlete:system/context
execute as @a[tag=ma.audience] run function magical_athlete:input/give
execute if score @s ma_anim matches 1.. run return 0
execute if data entity @s data.magical_athlete.queue[0] unless data entity @s data.magical_athlete.pending.options[0] run return 0
execute if score @s ma_state matches 2 as @a[tag=ma.audience] run function magical_athlete:ui/open
execute unless score @s ma_state matches 2 as @a[tag=ma.audience] if score @s ma_side = @e[tag=ma.current,limit=1] ma_pending run function magical_athlete:ui/open
execute unless score @s ma_state matches 2 if score @s ma_pending matches 0 as @a[tag=ma.audience] if score @s ma_side = @e[tag=ma.current,limit=1] ma_turn run function magical_athlete:ui/open
''')
    put('ui/rules',['tag @a[tag=ct.rules_actor] remove ct.rules_actor','tag @s add ct.rules_actor','execute as @e[tag=ma.current,limit=1] at @s run function magical_athlete:rules/show','tag @s remove ct.rules_actor'])
    put('ui/music',['execute as @e[tag=ma.current,limit=1] at @s run function magical_athlete:ui/toggle_music','function magical_athlete:ui/open'])
    put('ui/toggle_music',['scoreboard players add @s ma_music 1','execute if score @s ma_music matches 2.. run scoreboard players set @s ma_music 0','function magical_athlete:sound/stop','execute if score @s ma_music matches 1 run function magical_athlete:sound/start'])


if __name__=='__main__':main()
