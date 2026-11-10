"""卡坦岛和运动会：按桌隔离的公开记录、本人提醒、持续指引与目标提示。"""
import json
from pathlib import Path

PACK=Path(__file__).resolve().parents[1]


def js(value):return json.dumps(value,ensure_ascii=False,separators=(',',':'))


class Writer:
    def __init__(self,ns,p):self.ns=ns;self.p=p;self.root=PACK/f'data/{ns}/function'
    def put(self,name,body):
        path=self.root/(name+'.mcfunction');path.parent.mkdir(parents=True,exist_ok=True)
        lines=body if isinstance(body,list) else body.strip().splitlines()
        lines=[('$'+line if '$(' in line and not line.startswith(('$','#')) else line[1:] if line.startswith('$') and '$(' not in line else line) for line in lines]
        path.write_text('\n'.join(lines).strip()+'\n',encoding='utf-8')
    def hook(self,name,body,after=None):
        path=self.root/(name+'.mcfunction');text=path.read_text(encoding='utf-8')
        # 每次从旧生成器产物重建；独立标记便于单独重建本层。
        text=text.split('# feedback-v1')[0].rstrip()
        if after:
            # 行内插入必须幂等，不依赖末尾标记。
            text=text.replace('\n'+body+'\n','\n')
            text=text.replace(after,after+'\n'+body,1)
        else:text+='\n# feedback-v1\n'+body
        self.put(name,text)
    def name(self,side='$(actor)'):
        return {'nbt':f'data.{self.ns}.p{side}.name','entity':'@s','interpret':True}
    def chat(self,parts):
        label='卡坦岛' if self.ns=='catan' else '胡闹运动会'
        return '$tellraw @a[tag='+self.p+'.audience] '+js([{'text':f'[{label}] ','color':'gold'},*parts])
    def notice(self,text,color='yellow'):
        return f'function {self.ns}:hud/notice '+js({'text':{'text':text,'color':color}})
    def subtitle(self,text,color='yellow'):
        return f'function {self.ns}:feedback/subtitle '+js({'text':{'text':text,'color':color}})
    def common(self):
        self.put('feedback/subtitle',['title @s times 4 50 10','$title @s subtitle $(text)','title @s title {text:" "}'])
        self.put('feedback/reset',f'data remove entity @s data.{self.p}_feedback')
        self.hook('game/start',f'function {self.ns}:feedback/reset\nfunction {self.ns}:feedback/check')
        self.hook('game/cleanup',f'function {self.ns}:feedback/reset',after=f'function {self.ns}:system/context')


def catan():
    w=Writer('catan','ca');w.common()
    w.put('feedback/status',[
        'execute if entity @e[tag=ca.current,scores={ca_state=5},limit=1] run function catan:feedback/discard_status',
        'execute if data entity @e[tag=ca.current,limit=1] data.catan.trade run function catan:feedback/trade_status with entity @e[tag=ca.current,limit=1] data.catan.trade'])
    w.put('feedback/discard_status',['execute store result storage catan:feedback side int 1 run scoreboard players get @s ca_side','function catan:feedback/discard_status_read with storage catan:feedback'])
    w.put('feedback/discard_status_read',[
        '$execute store result score #due ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.p$(side).discard_due',
        'execute if score #due ca_ctx matches 0 run data modify storage fimel_title:io text.text set value "你无需弃牌：等待其他玩家完成"',
        'execute if score #due ca_ctx matches 1.. run data modify storage fimel_title:io text.text set value "你需要弃牌：资源按Q加入，选满自动提交"'])
    w.put('feedback/trade_status','$execute if score @s ca_side matches $(to) run data modify storage fimel_title:io text.text set value "收到交易报价：手持玩家交易物品按Q查看／答复"')
    # 对 last 的记录在动画改写 last.kind、产出记录之前完成。
    w.hook('game/after_action','function catan:feedback/action',after='function catan:game/sync')
    w.hook('game/after_action','function catan:feedback/check')
    w.put('game/log_event','# 公开行动由 feedback/action 统一记录。')
    labels={1:'放置初始村庄',2:'放置初始道路',10:'投掷骰子',11:'完成弃牌',12:'移动强盗',
        13:'偷取资源',20:'修建道路',21:'建造村庄',22:'升级城市',23:'购买了一张发展卡',
        29:'结束回合',30:'使用发展卡',31:'结束免费修路',40:'发起交易',41:'接受交易',42:'拒绝或撤销交易',50:'与银行／港口交换资源'}
    action=['data modify storage catan:feedback event set from entity @s data.catan.last',
        'data modify storage catan:feedback event.label set value "完成操作"']
    action += [f'execute if data storage catan:feedback event{{code:{code}}} run data modify storage catan:feedback event.label set value '+js(label) for code,label in labels.items()]
    for target,name in enumerate(('骑士','修路','垄断','丰收')):
        action += [f'execute if data storage catan:feedback event{{code:30,target:{target}}} run data modify storage catan:feedback event.label set value '+js('使用'+name)]
    action += ['execute unless data storage catan:feedback event{code:0} unless data storage catan:feedback event{code:90} unless data storage catan:feedback event{code:10} unless data storage catan:feedback event{code:13} unless data storage catan:feedback event{code:40} run function catan:feedback/log with storage catan:feedback event',
        'execute if data storage catan:feedback event{code:10} run function catan:feedback/dice with entity @s data.catan',
        'execute if data storage catan:feedback event{code:13} run function catan:feedback/stolen with storage catan:feedback event',
        'execute if data storage catan:feedback event{code:40} run function catan:feedback/offer with entity @s data.catan.trade',
        'data modify storage catan:feedback production set from entity @s data.catan.last.production',
        'execute if data storage catan:feedback production[0] run function catan:feedback/production',
        'function catan:feedback/awards']
    w.put('feedback/action',action)
    w.put('feedback/log',w.chat([w.name(),{'text':' · $(label)','color':'white'}]))
    w.put('feedback/dice',w.chat([w.name('$(turn)'),{'text':' 掷出 ','color':'gray'},{'nbt':'data.catan.dice[0]','entity':'@s'},{'text':' + '},{'nbt':'data.catan.dice[1]','entity':'@s'}]))
    w.put('feedback/stolen',[
        '$execute if data storage catan:feedback event{stolen:1} run '+w.chat([w.name(),{'text':' 从 ','color':'gray'},w.name('$(target)'),{'text':' 处随机偷取了一张资源。','color':'gray'}])[1:],
        '$execute if data storage catan:feedback event{stolen:0} run tellraw @a[tag=ca.audience] {text:"对方没有资源，未偷到资源。",color:"gray"}',
        '$execute if data storage catan:feedback event{stolen:1} as @a[tag=ca.audience,scores={ca_side=$(target)}] run '+w.subtitle('强盗来袭：你失去了一张资源','red'),
        '$execute as @a[tag=ca.audience,scores={ca_side=$(actor)}] run '+w.subtitle('偷取结算完成，资源已同步','green')])
    w.put('feedback/offer',[
        w.chat([w.name('$(from)'),{'text':' 向 ','color':'gray'},w.name('$(to)'),{'text':' 提出交易，等待答复。','color':'aqua'}]),
        '$execute as @a[tag=ca.audience,scores={ca_side=$(to)}] run '+w.subtitle('收到交易请求：手持交易物品按Q查看','aqua'),
        '$execute as @a[tag=ca.audience,scores={ca_side=$(to)}] run '+w.notice('有人向你报价，请使用“玩家交易”查看报价并接受或拒绝。','aqua')])
    w.put('feedback/production',[
        'function catan:feedback/resource_gain with storage catan:feedback production[0]',
        'data remove storage catan:feedback production[0]',
        'execute if data storage catan:feedback production[0] run function catan:feedback/production'])
    w.put('feedback/resource_gain',[
        '$data modify storage catan:feedback gain set value {owner:$(owner),amount:$(amount),resource:$(resource),label:"资源"}',
        *[f'execute if data storage catan:feedback gain{{resource:{i}}} run data modify storage catan:feedback gain.label set value '+js(label) for i,label in enumerate(('木材','砖块','羊毛','粮食','矿石'))],
        'function catan:feedback/gain_message with storage catan:feedback gain'])
    w.put('feedback/gain_message','$tellraw @a[tag=ca.audience,scores={ca_side=$(owner)}] {text:"[卡坦岛] 收获 $(amount) 张$(label)，已放入物品栏。",color:"green"}')
    # 最长道路/最大骑士军改变时才播报；job 完成(code90)也经过这里。
    awards=[]
    for field,label in [('longest','最长道路'),('army','最大骑士军')]:
        awards += [f'execute store success score #award_changed ca_ctx run data modify entity @s data.ca_feedback.{field} set from entity @s data.catan.{field}',
            f'execute if score #award_changed ca_ctx matches 1 run function catan:feedback/award_{field} with entity @s data.catan']
        w.put('feedback/award_'+field,[f'$execute unless predicate {{condition:"minecraft:value_check",value:$({field}),range:{{min:1,max:4}}}} run return 0',
            w.chat([w.name('$('+field+')'),{'text':' 获得'+label+'（2分）。','color':'gold'}]),
            f'$execute as @a[tag=ca.audience,scores={{ca_side=$({field})}}] run '+w.subtitle('获得'+label+'！','gold')])
    w.put('feedback/awards',awards)
    w.put('feedback/check',[
        'execute if score @s ca_state matches 10 run return 0',
        'data modify storage catan:feedback state set value {phase:0,turn:0}',
        'data modify storage catan:feedback state.phase set from entity @s data.catan.phase',
        'data modify storage catan:feedback state.turn set from entity @s data.catan.turn',
        'execute store success score #state_changed ca_ctx run data modify entity @s data.ca_feedback.state set from storage catan:feedback state',
        'execute if score #state_changed ca_ctx matches 1 run function catan:feedback/state with entity @s data.catan'])
    phase={1:'放置初始村庄：手持村庄，瞄准交点后右键两次',2:'放置初始道路：手持道路，瞄准刚建村庄相邻的边',3:'开始回合：手持骰子按Q投骰，或使用旧发展卡',4:'自由行动：建造、交易或使用发展卡；结束回合按Q两次',5:'掷出7：资源超过7张的玩家必须弃掉一半（向下取整）',6:'移动强盗：瞄准另一个地块，右键两次确认',7:'偷取资源：瞄准亮起的相邻对手，右键两次',8:'免费修路：手持道路选择位置，最多两条',11:'本局结束'}
    state=[]
    for code,label in phase.items():
        state += [f'$execute if score @s ca_state matches {code} run tellraw @a[tag=ca.audience] '+js([{'text':'[卡坦岛] ','color':'gold'},w.name('$(turn)'),{'text':' · '+label,'color':'yellow'}])]
        if code not in (5,11):
            short={1:'放置初始村庄',2:'放置初始道路',3:'投骰或使用旧发展卡',4:'建造、交易或结束回合',6:'移动强盗',7:'选择偷取对象',8:'免费修建道路'}[code]
            state += [f'$execute if score @s ca_state matches {code} as @a[tag=ca.audience,scores={{ca_side=$(turn)}}] run '+w.subtitle('轮到你了 · '+short,'aqua')]
    state += ['execute if score @s ca_state matches 5 as @a[tag=ca.audience] run function catan:feedback/discard_prompt',
        'execute as @a[tag=ca.audience] run function catan:hud/build']
    w.put('feedback/state',state)
    w.put('feedback/discard_prompt',['execute store result storage catan:feedback side int 1 run scoreboard players get @s ca_side','function catan:feedback/discard_due with storage catan:feedback'])
    w.put('feedback/discard_due',[
        '$execute store result score #due ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.p$(side).discard_due',
        'execute unless score #due ca_ctx matches 1.. run return 0',
        'execute store result storage catan:feedback due int 1 run scoreboard players get #due ca_ctx',
        'function catan:feedback/discard_message with storage catan:feedback'])
    w.put('feedback/discard_message',[w.subtitle('你需要弃掉 $(due) 张资源','red'),w.notice('需要弃掉 $(due) 张资源：选中资源按Q加入；撤销按Q退回，选满自动确认。','red')])
    # 强盗、投骰与桌面发展牌堆可直接提示；粒子沿外侧，避免盖住数字。
    w.hook('game/tick','execute if score @s ca_pulse matches 0 run function catan:feedback/guide')
    w.put('feedback/guide',[
        'execute if score @s ct_paused matches 1 run return 0',
        'execute if score @s ca_anim matches 1.. run return 0',
        'execute if score @s ca_vtimer matches 1.. run return 0',
        'execute if score @s ca_state matches 3 as @e[tag=ca.visual,scores={ca_vkind=8}] if score @s ct_id = #table ca_ctx at @s run function catan:feedback/dice_guide',
        'execute if score @s ca_state matches 6 as @e[tag=ca.visual,scores={ca_vkind=7}] if score @s ct_id = #table ca_ctx run data merge entity @s {Glowing:1b,glow_color_override:16766720}',
        'execute unless score @s ca_state matches 6 as @e[tag=ca.visual,scores={ca_vkind=7}] if score @s ct_id = #table ca_ctx run data merge entity @s {Glowing:0b}'])
    w.put('feedback/dice_guide',[
        *[f'data modify storage catan:feedback pose.{a} set from entity @s transformation.translation[{i}]' for i,a in enumerate(('x','y','z'))],
        'function catan:feedback/dice_particle with storage catan:feedback pose'])
    w.put('feedback/dice_particle','$execute positioned ~$(x) ~$(y) ~$(z) run particle minecraft:end_rod ~ ~0.12 ~ 0.09 0.02 0.09 0 1 normal @a[tag=ca.audience]')
    # 结束结算放在原赢家聊天之后，重要结果只显示一次。
    w.hook('game/winner_announce','$execute as @a[tag=ca.audience,scores={ca_side=$(winner)}] run '+w.subtitle('卡坦岛胜利！','gold'))


def magical_athlete():
    w=Writer('magical_athlete','ma');w.common()
    w.put('feedback/status',[
        'execute if score @s ma_side = @e[tag=ma.current,limit=1] ma_pending run data modify storage fimel_title:io text.text set value "你的技能待回应：手持选项按Q两次，或右键目标"',
        'execute if score @s ma_side = @e[tag=ma.current,limit=1] ma_pending if data entity @e[tag=ma.current,limit=1] data.magical_athlete.pending{kind:"ready"} run data modify storage fimel_title:io text.text set value "轮到你了：手持骰子按Q开始行动"',
        'execute if score @s ma_side = @e[tag=ma.current,limit=1] ma_pending if data entity @e[tag=ma.current,limit=1] data.magical_athlete.pending{kind:"thirdwheel"} run data modify storage fimel_title:io text.text set value "选择传送格：右键金色提示点两次，或选跳过"'])
    w.hook('game/after_animation','function magical_athlete:feedback/check',after='function magical_athlete:visual/refresh')
    w.hook('game/after_action','function magical_athlete:feedback/action',after='function magical_athlete:game/sync')
    # 此函数在成功事务之后执行；秘密阵容只报告已准备，不报告身份。
    w.put('feedback/action',[
        'execute if data storage magical_athlete:engine request{code:1} run function magical_athlete:feedback/draft with storage magical_athlete:engine request',
        'execute if data storage magical_athlete:engine request{code:2} run function magical_athlete:feedback/lineup with storage magical_athlete:engine request'])
    w.put('feedback/lineup',w.chat([w.name(),{'text':' 已提交一名本场选手；全员完成后统一揭晓。','color':'aqua'}]))
    w.put('feedback/draft',[
        '$data modify storage magical_athlete:feedback character set from storage magical_athlete:characters chars[$(target)]',
        '$data modify storage magical_athlete:feedback character.actor set value $(actor)',
        'function magical_athlete:feedback/drafted with storage magical_athlete:feedback character'])
    w.put('feedback/drafted',w.chat([w.name(),{'text':' 招募了 $(name)。','color':'aqua'}]))
    # 动画按事件顺序播报，避免先公布最后结果再播放过程。
    w.put('visual/event_announce','function magical_athlete:feedback/event with storage magical_athlete:visual event')
    w.put('feedback/event',[
        '$data modify storage magical_athlete:feedback event set value {kind:$(kind),pawn:$(pawn),from:$(from),to:$(to),source:$(source),amount:$(amount),die:$(die)}',
        '$data modify storage magical_athlete:feedback racer set from entity @s data.magical_athlete.racers[$(pawn)]',
        'execute if data storage magical_athlete:feedback racer{char:-1} run return 0',
        'function magical_athlete:feedback/event_name with storage magical_athlete:feedback racer',
        'function magical_athlete:feedback/event_text with storage magical_athlete:feedback event'])
    w.put('feedback/event_name',[
        '$data modify storage magical_athlete:feedback event.name set from storage magical_athlete:characters chars[$(char)].name',
        '$data modify storage magical_athlete:feedback event.actor set value $(owner)',
        '$data modify storage magical_athlete:feedback event.ability set from storage magical_athlete:characters chars[$(power)].ability'])
    labels={1:'前进／后退：$(from) → $(to) 格',2:'移动至 $(to) 格',3:'被绊倒，下次行动需先起身',4:'重新站起，本次行动结束',5:'被吞掉，本场出局',6:'抵达终点！名次：第 $(amount) 名',7:'积分变化：$(amount) 分',8:'触发能力：$(ability)',9:'掷出 $(die) 点'}
    lines=[]
    for kind,label in labels.items():
        color='green' if kind==6 else 'red' if kind in (3,5) else 'aqua' if kind in (7,8) else 'white'
        lines += [f'$execute if predicate {{condition:"minecraft:value_check",value:$(kind),range:{kind}}} run '+w.chat([w.name(),{'text':' 的 $(name)：'+label,'color':color}])[1:]]
        if kind in (3,4,5,6,7):
            lines += [f'$execute if predicate {{condition:"minecraft:value_check",value:$(kind),range:{kind}}} as @a[tag=ma.audience,scores={{ma_side=$(actor)}}] run '+w.subtitle('$(name)：'+label,color)]
    lines += ['$execute if predicate {condition:"minecraft:value_check",value:$(source),range:{min:0,max:35}} if predicate {condition:"minecraft:value_check",value:$(kind),range:{min:1,max:5}} run function magical_athlete:feedback/source with storage magical_athlete:feedback event']
    w.put('feedback/event_text',lines)
    w.put('feedback/source',[
        '$data modify storage magical_athlete:feedback source set from storage magical_athlete:characters chars[$(source)]',
        'function magical_athlete:feedback/source_text with storage magical_athlete:feedback source'])
    w.put('feedback/source_text','$tellraw @a[tag=ma.audience] {text:"  ↳ 来自「$(name)」的能力效果。",color:"gray"}')
    w.put('feedback/check',[
        'data modify storage magical_athlete:feedback state set value {phase:0,turn:0,round:0,active:-1,pending:{}}',
        *[f'data modify storage magical_athlete:feedback state.{field} set from entity @s data.magical_athlete.{field}' for field in ('phase','turn','round','active','pending')],
        'execute store success score #state_changed ma_ctx run data modify entity @s data.ma_feedback.state set from storage magical_athlete:feedback state',
        'execute if score #state_changed ma_ctx matches 1 run function magical_athlete:feedback/state with entity @s data.magical_athlete'])
    phases={1:'请招募选手：右键桌面角色两次确认，左键取消',2:'秘密选择本场阵容：手持角色按Q两次提交，全员完成后揭晓',3:'比赛进行中：等待当前选手行动',4:'本场结算完成，6秒后进入下一场',5:'四场比赛结束，正在公布总分'}
    state=[]
    for phase,label in phases.items():
        state += [f'$execute if score @s ma_state matches {phase} run tellraw @a[tag=ma.audience] '+js([{'text':'[胡闹运动会] 第$(round)/4场 · ','color':'gold'},w.name('$(turn)'),{'text':' · '+label,'color':'yellow'}])]
    state += ['execute if score @s ma_state matches 3 run function magical_athlete:feedback/reveal',
        'execute if score @s ma_state matches 4..5 run function magical_athlete:feedback/scores',
        '$execute if score @s ma_state matches 1 as @a[tag=ma.audience,scores={ma_side=$(turn)}] run '+w.subtitle('轮到你招募：右键选择一名角色','aqua'),
        'execute if score @s ma_state matches 2 as @a[tag=ma.audience] run '+w.subtitle('请选择本场阵容，手持角色按Q两次','aqua'),
        'execute if data entity @s data.magical_athlete.pending.options[0] run function magical_athlete:feedback/pending with entity @s data.magical_athlete.pending',
        'execute as @a[tag=ma.audience] run function magical_athlete:hud/build']
    w.put('feedback/state',state)
    w.put('feedback/pending',[
        '$data modify storage magical_athlete:feedback pending set value {owner:$(owner),kind:"$(kind)",label:"选择技能选项：手持选项按Q两次确认"}',
        *[f'execute if data storage magical_athlete:feedback pending{{kind:"{kind}"}} run data modify storage magical_athlete:feedback pending.label set value '+js(label) for kind,label in {
            'ready':'轮到你了：手持骰子按Q开始行动','genius':'请选择预测点数：0是不预测，1～6是预测骰子',
            'reroll':'选择接受当前点数，或重新投骰','hypnotist':'选择拉到身边的选手：右键亮起的棋子，或选择跳过',
            'flip':'选择交换位置的选手：右键亮起的棋子，或选择跳过','duel':'选择决斗目标：右键亮起的棋子，或选择跳过',
            'mastermind':'预测一名选手获胜：右键亮起的棋子','copycat':'选择要模仿的选手：右键亮起的棋子',
            'thirdwheel':'选择传送到的格子：右键金色提示点，或选择跳过','egg':'选择本场继承的能力：手持角色选项按Q两次',
            'twin':'选择能力：手持选项按Q，或查看全部候选能力','legs':'选择投骰，或直接走5格','rocket':'选择正常前进，或翻倍前进并承担绊倒风险','alchemist':'选择保留骰子，或改为4步'}.items()],
        'function magical_athlete:feedback/pending_message with storage magical_athlete:feedback pending'])
    w.put('feedback/pending_message',[
        w.chat([w.name('$(owner)'),{'text':' · $(label)','color':'aqua'}]),
        '$execute as @a[tag=ma.audience,scores={ma_side=$(owner)}] run '+w.subtitle('轮到你回应：查看下方操作提示','aqua'),
        '$execute as @a[tag=ma.audience,scores={ma_side=$(owner)}] run '+w.notice('$(label)','aqua')])
    w.put('feedback/reveal',[
        # 一场只揭晓一次，正常轮换和技能回应不会再次公布。
        'execute store result score #round ma_ctx run data get entity @s data.magical_athlete.round',
        'execute if score @s ma_fround = #round ma_ctx run return 0',
        'scoreboard players operation @s ma_fround = #round ma_ctx',
        *[f'execute if data entity @s data.magical_athlete.racers[{i}] run function magical_athlete:feedback/reveal_racer {{index:{i}}}' for i in range(6)]])
    w.hook('load','scoreboard objectives add ma_fround dummy')
    w.hook('feedback/reset','scoreboard players set @s ma_fround -1')
    w.put('feedback/reveal_racer',[
        '$data modify storage magical_athlete:feedback racer set from entity @s data.magical_athlete.racers[$(index)]',
        'execute if data storage magical_athlete:feedback racer{char:-1} run return 0',
        'function magical_athlete:feedback/revealed with storage magical_athlete:feedback racer'])
    w.put('feedback/revealed',[
        '$data modify storage magical_athlete:feedback character set from storage magical_athlete:characters chars[$(char)]',
        '$data modify storage magical_athlete:feedback character.actor set value $(owner)',
        'function magical_athlete:feedback/reveal_text with storage magical_athlete:feedback character'])
    w.put('feedback/reveal_text',w.chat([w.name(),{'text':' 派出 $(name)：$(ability)','color':'aqua'}]))
    w.put('feedback/scores',[f'execute if data entity @s data.magical_athlete.p{side}.name run function magical_athlete:feedback/score {{side:{side}}}' for side in range(1,7)])
    w.put('feedback/score',w.chat([w.name('$(side)'),{'text':' · 本场 '},{'nbt':'data.magical_athlete.p$(side).race_points','entity':'@s'},{'text':' 分 · 总分 '},{'nbt':'data.magical_athlete.p$(side).points','entity':'@s'}]))
    w.hook('game/announce','$execute as @a[tag=ma.audience,scores={ma_side=$(side)}] run '+w.subtitle('胡闹运动会总冠军！','gold'))
    # 提示合法目标使用稀疏粒子；蓝色实线发光继续专用于玩家实际选中。
    w.hook('game/tick','execute if score @s ma_pulse matches 0 run function magical_athlete:feedback/guide')
    w.put('feedback/guide',[
        'execute if score @s ma_anim matches 1.. run return 0',
        'execute if score @s ct_paused matches 1 run return 0',
        'execute if score @s ma_state matches 1 as @e[tag=ma.pool] if score @s ct_id = #table ma_ctx at @s run particle minecraft:end_rod ~ ~0.33 ~ 0.03 0.01 0.03 0 1 normal @a[tag=ma.audience]',
        'execute if score @s ma_state matches 3 if data entity @s data.magical_athlete.pending{kind:"ready"} as @e[tag=ma.die] if score @s ct_id = #table ma_ctx at @s run particle minecraft:end_rod ~ ~0.22 ~ 0.04 0.01 0.04 0 1 normal @a[tag=ma.audience]',
        'execute if data entity @s data.magical_athlete.pending.options[0] run function magical_athlete:feedback/targets with entity @s data.magical_athlete.pending'])
    targetlines=['$data modify storage magical_athlete:feedback target_options set value $(options)',
        'scoreboard players set #target_kind ma_ctx 0']
    for kind in ('hypnotist','flip','duel','mastermind','copycat'):
        targetlines += [f'execute if data entity @s data.magical_athlete.pending{{kind:"{kind}"}} run scoreboard players set #target_kind ma_ctx 1']
    targetlines += ['execute if score #target_kind ma_ctx matches 1 as @e[tag=ma.racer] if score @s ct_id = #table ma_ctx at @s run function magical_athlete:feedback/racer_target',
        'execute if data entity @s data.magical_athlete.pending{kind:"thirdwheel"} as @e[tag=ma.hit,scores={ma_dtype=3}] if score @s ct_id = #table ma_ctx at @s run function magical_athlete:feedback/cell_target']
    w.put('feedback/targets',targetlines)
    w.put('feedback/racer_target',['execute store result storage magical_athlete:feedback id int 1 run scoreboard players get @s ma_vid',
        *[f'data modify storage magical_athlete:feedback {a} set from entity @s transformation.translation[{i}]' for i,a in enumerate(('x','y','z'))],
        'function magical_athlete:feedback/target_particle with storage magical_athlete:feedback'])
    w.put('feedback/cell_target',['execute store result storage magical_athlete:feedback id int 1 run scoreboard players get @s ma_did',
        'data modify storage magical_athlete:feedback x set value 0.0','data modify storage magical_athlete:feedback y set value 0.0','data modify storage magical_athlete:feedback z set value 0.0',
        'function magical_athlete:feedback/target_particle with storage magical_athlete:feedback'])
    w.put('feedback/target_particle','$execute if data storage magical_athlete:feedback {target_options:[$(id)]} positioned ~$(x) ~$(y) ~$(z) run particle minecraft:dust{color:[1.0,0.82,0.24],scale:0.55} ~ ~0.025 ~ 0.005 0 0.005 0 1 normal @a[tag=ma.audience]')


if __name__=='__main__':
    catan();magical_athlete()
