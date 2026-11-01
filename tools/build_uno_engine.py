"""生成 UNO 服务端核心；界面、资源和通用牌桌接入由对应模块维护。"""
from pathlib import Path
from textwrap import dedent

ROOT = Path(__file__).resolve().parents[1] / "data/uno/function"


def put(name, text):
    target = ROOT / (name + ".mcfunction")
    target.parent.mkdir(parents=True, exist_ok=True)
    lines = dedent(text).strip().splitlines()
    # 输入入口只允许真人；核心用同一套桌号/玩家标签处理牌权，便于服务端
    # GameTest 用 marker 模拟座位。所有对用户发消息的 targets 仍限制为 @a。
    result = []
    for line in lines:
        if not any(token in line for token in ("tellraw", "input/give", "cardtable:seat/mount", "player/clear_state", "tag @a[tag=un.audience] remove")):
            line = line.replace("@a[tag=un.actor", "@e[tag=un.actor")
            line = line.replace("@a[tag=un.audience", "@e[tag=un.audience")
            line = line.replace("@a[tag=un.player", "@e[tag=un.player")
        result.append(line.lstrip())
    target.write_text("\n".join(result) + "\n", encoding="utf-8")


OBJECTIVES = """un_state un_turn un_dir un_color un_value un_top un_epoch un_round un_timer
un_pending un_challenger un_offender un_wildbad un_mode un_rounds un_target un_auto
un_challenge un_window un_table un_seat un_count un_score un_pick un_seen un_card
un_owner un_idx un_order un_drawn un_drew un_size un_effect un_next un_winner
un_after un_dealt un_say un_chosen un_matchend un_called un_clock un_points
un_set_table un_setnonce un_nonce un_caught un_ui_tmp un_load un_colorpick un_anim_wait
un_panel un_prev_panel un_hud_dirty""".split()

put("load", """
    # 安装只执行一次；重载保留牌组、回合与计时，只让旧对话框失效。
    scoreboard objectives add un_ctx dummy
    execute unless score #version un_ctx matches 1.. run function uno:system/install
    execute if score #version un_ctx matches 1 run function uno:system/upgrade_v2
    execute if score #version un_ctx matches 2 run function uno:system/upgrade_v3
    scoreboard players add #ui_load un_ctx 1
    execute as @e[type=minecraft:marker,tag=un.controller] at @s run function uno:system/reload
""")
put("system/install", "\n".join(f"scoreboard objectives add {o} dummy" for o in OBJECTIVES) + """
scoreboard objectives add un_action trigger
scoreboard objectives add un_settings trigger
scoreboard objectives add un_drop minecraft.dropped:minecraft.purple_dye
scoreboard players set #version un_ctx 3
scoreboard players set #epoch un_ctx 0
scoreboard players set #ui_load un_ctx 0
scoreboard players set #one un_ctx 1
scoreboard players set #minus un_ctx -1
scoreboard players set #eight un_ctx 8
""")
put("system/upgrade_v2", """
    # 只增加队列冷却目标，不重发真实手牌或重置旧牌局。
    scoreboard objectives add un_anim_wait dummy
    scoreboard players set #version un_ctx 2
""")
put("system/upgrade_v3", """
    # HUD 仅新增私有面板目标，保留真实牌组、分数、队列及当前回合。
    scoreboard objectives add un_panel dummy
    scoreboard objectives add un_prev_panel dummy
    scoreboard objectives add un_hud_dirty dummy
    scoreboard players set #version un_ctx 3
""")
put("system/context", """
    # 同步临时标签由每次入口重新构造，绝不以距离认定实例。
    scoreboard players operation #table un_ctx = @s ct_id
    tag @e[tag=un.current] remove un.current
    # @a 跨维度；先清全体真人，再清本维度的 GameTest 模拟玩家。
    tag @a[tag=un.audience] remove un.audience
    tag @e[tag=un.audience] remove un.audience
    tag @e[tag=un.cards] remove un.cards
    tag @e[tag=un.selected] remove un.selected
    tag @s add un.current
    execute as @a[tag=un.player,tag=ct.player] if score @s un_table = #table un_ctx if score @s ct_id = #table un_ctx run tag @s add un.audience
    execute as @e[type=minecraft:marker,tag=un.card] if score @s ct_id = #table un_ctx run tag @s add un.cards
""")
put("system/advance", """
    scoreboard players add #epoch un_ctx 1
    execute if score #epoch un_ctx matches 2000001.. run scoreboard players set #epoch un_ctx 1
    scoreboard players operation @s un_epoch = #epoch un_ctx
    function uno:ui/refresh
    function uno:hud/refresh
    function uno:visual/update_status
""")
put("system/flush", """
    # 一次摸多张只在刻末刷新一次 HUD 和公开名单。
    execute unless score @s un_hud_dirty matches 1 run return 0
    execute unless score @s un_state matches 1..5 run return 0
    function uno:hud/refresh
    function uno:visual/update_status
""")
put("system/reload", """
    function uno:system/context
    execute unless data entity @s data.uno.deal_queue run data modify entity @s data.uno.deal_queue set value []
    execute unless score @s un_anim_wait matches 0..1 run scoreboard players set @s un_anim_wait 0
    # 迁移旧临时牌盒，只补回桌心常驻盒，保留出牌、待发队列和飞行牌。
    function cardtable:animation/deal/box/clear
    function uno:visual/ensure_box
    function uno:visual/repair_faces
    function uno:system/advance
    execute as @a[tag=un.audience] run function uno:input/give
    tellraw @a[tag=un.audience] [{text:'[UNO] ',color:'gold'},{text:'数据包已重新加载，牌局与计时已保留。轮到自己时按 Q 打开手牌。',color:'yellow'}]
""")
put("log", """
    # 自行添加 ct.debug 后查看关键状态，默认不启用。
    $tellraw @a[tag=ct.debug] [{text:"[UNO Debug] $(text)",color:"gray"}]
""")

put("game/init_table", """
    # 只修正缺失或越界设置，活跃对局和有效设置保持原值。
    execute unless score @s un_mode matches 0..2 run scoreboard players set @s un_mode 0
    execute unless score @s un_rounds matches 1..32 run scoreboard players set @s un_rounds 3
    execute unless score @s un_target matches 100..1000 run scoreboard players set @s un_target 500
    execute unless score @s un_auto matches 0..1 run scoreboard players set @s un_auto 0
    execute unless score @s un_challenge matches 0..1 run scoreboard players set @s un_challenge 1
    execute unless score @s un_window matches 20..100 run scoreboard players set @s un_window 60
""")
put("game/start", """
    function uno:game/init_table
    function uno:log {text:"检查开局人数、在线状态及第一格快捷栏"}
    execute unless score @s ct_joined matches 2..8 run tellraw @a[tag=ct.start_actor,limit=1] [{text:'[UNO] 需要 2～8 名玩家。',color:'red'}]
    execute unless score @s ct_joined matches 2..8 run return fail
    execute if score @s ct_joined > @s ct_capacity run return fail
    scoreboard players operation #table un_ctx = @s ct_id
    scoreboard players set #u_online un_ctx 0
    scoreboard players set #u_blocked un_ctx 0
    execute as @a[tag=ct.player] if score @s ct_id = #table un_ctx run scoreboard players add #u_online un_ctx 1
    execute as @a[tag=ct.player] if score @s ct_id = #table un_ctx if items entity @s hotbar.0 * unless items entity @s hotbar.0 minecraft:purple_dye[minecraft:custom_data~{uno:{tool:1b}}] run scoreboard players set #u_blocked un_ctx 1
    execute unless score #u_online un_ctx = @s ct_joined run tellraw @a[tag=ct.start_actor,limit=1] [{text:'[UNO] 有已入座的玩家不在线。',color:'red'}]
    execute unless score #u_online un_ctx = @s ct_joined run return fail
    execute if score #u_blocked un_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] [{text:'[UNO] 请所有玩家先清空快捷栏第一格。',color:'red'}]
    execute if score #u_blocked un_ctx matches 1 run return fail
    tag @s add un.controller
    scoreboard players operation @s un_size = @s ct_joined
    scoreboard players set @s un_round 0
    scoreboard players set @s un_clock 0
    scoreboard players set @s un_matchend 0
    execute as @a[tag=ct.player] if score @s ct_id = #table un_ctx run function uno:player/init
    function uno:system/context
    execute as @a[tag=un.audience] run function cardtable:seat/mount
    execute as @a[tag=un.audience] run function uno:input/give
    scoreboard players set @s ct_start 1
    function uno:round/start
""")
put("player/init", """
    tag @s add un.player
    scoreboard players operation @s un_table = @s ct_id
    scoreboard players operation @s un_seat = @s ct_seat
    scoreboard players set @s un_score 0
    scoreboard players set @s un_count 0
    scoreboard players set @s un_pick -1
    scoreboard players set @s un_colorpick -1
    scoreboard players set @s un_seen -1
    scoreboard players set @s un_drop 0
    scoreboard players set @s un_action 0
""")
put("player/clear_state", """
    # 独占 custom_data 清理，保留玩家的普通纸、染料和其他游戏物品。
    function uno:hud/deactivate
    clear @s *[minecraft:custom_data~{uno:{tool:1b}}]
    clear @s *[minecraft:custom_data~{uno:{card:1b}}]
    scoreboard players reset @s un_table
    scoreboard players reset @s un_seat
    scoreboard players reset @s un_count
    scoreboard players reset @s un_score
    scoreboard players reset @s un_pick
    scoreboard players reset @s un_colorpick
    scoreboard players reset @s un_seen
    scoreboard players reset @s un_drop
    scoreboard players reset @s un_action
    scoreboard players reset @s un_set_table
    scoreboard players reset @s un_setnonce
    scoreboard players reset @s un_nonce
    scoreboard players reset @s un_settings
    tag @s remove un.player
    tag @s remove un.audience
    tag @s remove un.actor
""")
put("game/player_left", """
    execute unless entity @s[tag=un.controller] run return fail
    function uno:system/context
    tellraw @a[tag=un.audience] [{text:'[UNO] 有玩家离线或离桌，本场中止。',color:'yellow'}]
    function uno:game/abort
""")
put("game/end_vote", """
    execute unless entity @s[tag=un.controller] run return fail
    function uno:system/context
    tellraw @a[tag=un.audience] [{text:'[UNO] 结束投票通过，本场提前结束。',color:'yellow'}]
    function uno:game/cleanup
""")
put("game/abort", """
    execute unless entity @s[tag=un.controller] run return fail
    function uno:system/context
    tellraw @a[tag=un.audience] [{text:'[UNO] 本场游戏已中止，牌桌返回大厅。',color:'yellow'}]
    function uno:log {text:"中止对局并清理专属状态"}
    function uno:game/cleanup
""")
put("game/finish", """
    execute unless entity @s[tag=un.controller] run return fail
    function uno:system/context
    scoreboard players set #u_best un_ctx -1
    execute as @a[tag=un.audience] if score @s un_score > #u_best un_ctx run scoreboard players operation #u_best un_ctx = @s un_score
    tellraw @a[tag=un.audience] [{text:'[UNO] 本场结束，最高总分 ',color:'gold'},{score:{name:'#u_best',objective:'un_ctx'},color:'yellow'},{text:'。'}]
    scoreboard players operation #u_winner un_ctx = @s un_winner
    execute if score @s un_mode matches 0 as @a[tag=un.audience] if score @s un_seat = #u_winner un_ctx run tellraw @a[tag=un.audience] [{text:'本场胜者：',color:'gold'},{selector:'@s',color:'aqua'}]
    execute unless score @s un_mode matches 0 as @a[tag=un.audience] if score @s un_score = #u_best un_ctx run tellraw @a[tag=un.audience] [{text:'本场胜者：',color:'gold'},{selector:'@s',color:'aqua'}]
    execute as @a[tag=un.audience] run tellraw @a[tag=un.audience] [{selector:'@s',color:'aqua'},{text:'：'},{score:{name:'@s',objective:'un_score'},color:'yellow'},{text:' 分'}]
    function uno:log {text:"完成整场结算，返回大厅"}
    function uno:game/cleanup
""")
put("game/cleanup", """
    # 先锁结束，防止通用人数维护重入结束回调。
    scoreboard players set @s un_state 6
    function uno:system/context
    function uno:visual/clear
    function uno:animation/clear
    kill @e[type=minecraft:marker,tag=un.cards]
    execute store result storage uno:runtime cleanup.table int 1 run scoreboard players get @s ct_id
    function uno:player/clear_drops with storage uno:runtime cleanup
    execute as @a[tag=un.player] if score @s un_table = #table un_ctx at @s run function uno:player/clear_drops with storage uno:runtime cleanup
    execute as @e[type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{uno:{tool:1b}}] run function uno:player/kill_drop
    # 离开维度的玩家不参与本桌操作，但中止时仍须清掉其 UNO 专属物品。
    execute as @a[tag=un.player] if score @s un_table = #table un_ctx run function uno:player/clear_state
    scoreboard players set @s un_state 0
    scoreboard players set @s un_pending 0
    scoreboard players set @s un_timer 0
    tag @s remove un.controller
    tag @s remove un.current
    function cardtable:game/return_lobby
""")
put("player/kill_drop", """
    # 实体关系用于补充刚刚丢出、尚未来得及处理的 Q 操作物。
    scoreboard players set #u_killdrop un_ctx 0
    execute if score @s ct_id = #table un_ctx run scoreboard players set #u_killdrop un_ctx 1
    execute on origin if entity @s[tag=un.audience] run scoreboard players set #u_killdrop un_ctx 1
    execute if score #u_killdrop un_ctx matches 1 run kill @s
""")
put("player/clear_drops", """
    # 新操作物将桌号写入 custom_data，即使 origin 已离线仍能精确清理。
    $execute as @e[type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{uno:{tool:1b,table:$(table)}}] run kill @s
""")
put("admin/abort", """
    # 可直接 /function 调用；只处理同维度八格内最近的一场 UNO。
    execute unless entity @s[type=minecraft:player] run return fail
    execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=un.controller,distance=..8,sort=nearest,limit=1] run tellraw @s [{text:'[UNO] 同维度 8 格内没有正在运行的 UNO 牌桌。',color:'red'}]
    execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=un.controller,distance=..8,sort=nearest,limit=1] run return fail
    execute as @e[type=minecraft:marker,tag=ct.controller,tag=un.controller,distance=..8,sort=nearest,limit=1] at @s run function uno:game/abort
""")

# 标准 108 张：每色一张 0、两套 1..9/跳过/反转/+2，另四张万能与四张 +4。
cards = []
for color in range(4):
    for value in [0] + list(range(1, 13)) * 2:
        cards.append((color * 13 + value, color, value))
cards.extend([(52, 4, 13)] * 4 + [(53, 4, 14)] * 4)
assert len(cards) == 108
put("deck/create", "# 每张后台牌使用独立 marker，真实手牌不依赖可伪造的实体物品。\n" + "\n".join(
    f"execute summon minecraft:marker run function uno:deck/card_init {{idx:{idx},card:{card},color:{color},value:{value}}}"
    for idx, (card, color, value) in enumerate(cards, 1)))
put("deck/card_init", """
    tag @s add un.card
    tag @s add un.cards
    scoreboard players operation @s ct_id = #table un_ctx
    $scoreboard players set @s un_idx $(idx)
    $scoreboard players set @s un_card $(card)
    $scoreboard players set @s un_color $(color)
    $scoreboard players set @s un_value $(value)
    scoreboard players set @s un_owner 0
    scoreboard players set @s un_order 0
""")
put("deck/reshuffle", """
    # 保留唯一顶牌；其余弃牌随机抽取即构成新洗牌堆。
    scoreboard players operation #u_top un_ctx = @s un_top
    execute as @e[type=minecraft:marker,tag=un.cards,scores={un_owner=-1}] unless score @s un_idx = #u_top un_ctx run scoreboard players set @s un_owner 0
    execute if entity @e[type=minecraft:marker,tag=un.cards,scores={un_owner=0}] run tellraw @a[tag=un.audience] [{text:'[UNO] 摸牌堆已耗尽，弃牌重新洗回。',color:'gray'}]
""")
put("deck/take", """
    # 输入 #seat，输出唯一 un.selected 和 #draw_idx；不足时返回 0，不递归死循环。
    tag @e[tag=un.selected] remove un.selected
    scoreboard players set #draw_idx un_ctx 0
    execute unless entity @e[type=minecraft:marker,tag=un.cards,scores={un_owner=0}] run function uno:deck/reshuffle
    execute unless entity @e[type=minecraft:marker,tag=un.cards,scores={un_owner=0}] run return fail
    tag @e[type=minecraft:marker,tag=un.cards,scores={un_owner=0},sort=random,limit=1] add un.selected
    scoreboard players operation @e[type=minecraft:marker,tag=un.selected,limit=1] un_owner = #seat un_ctx
    scoreboard players operation #draw_idx un_ctx = @e[type=minecraft:marker,tag=un.selected,limit=1] un_idx
    execute as @a[tag=un.audience] if score @s un_seat = #seat un_ctx run scoreboard players add @s un_count 1
    function uno:animation/enqueue
    scoreboard players set @s un_hud_dirty 1
""")
put("deck/draw", """
    # 输入 #seat、#amount；只摸到实际有的牌，每张成功取得的牌都会入公共动画队列。
    scoreboard players operation #draw_left un_ctx = #amount un_ctx
    scoreboard players set #draw_actual un_ctx 0
    execute if score #draw_left un_ctx matches 109.. run scoreboard players set #draw_left un_ctx 108
    execute if score #draw_left un_ctx matches 1.. run function uno:deck/draw_loop
""")
put("deck/draw_loop", """
    function uno:deck/take
    execute if score #draw_idx un_ctx matches 0 run return fail
    scoreboard players add #draw_actual un_ctx 1
    scoreboard players remove #draw_left un_ctx 1
    execute if score #draw_left un_ctx matches 1.. run function uno:deck/draw_loop
""")
put("deck/animate", """
    # 后台先发真牌，公共动画只展示牌背，不泄露其他玩家的手牌。
    function cardtable:animation/deal/spawn_card
    $item replace entity @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,limit=1] contents with minecraft:paper[minecraft:item_model="card:uno/back",minecraft:custom_data={uno:{card:1b,table:$(table),idx:$(idx)}},minecraft:max_stack_size=1]
    tag @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,limit=1] add ct.visual_only
    function cardtable:animation/deal/sound
    function cardtable:animation/deal/launch with storage cardtable:deal
""")
put("animation/enqueue", """
    # take 已确认真实牌到账；不改变逻辑输入 #seat/#draw_idx 或 un.selected。
    execute unless data entity @s data.uno.deal_queue run data modify entity @s data.uno.deal_queue set value []
    execute store result storage uno:animation pending.seat int 1 run scoreboard players get #seat un_ctx
    execute store result storage uno:animation pending.idx int 1 run scoreboard players get #draw_idx un_ctx
    function uno:animation/append with storage uno:animation pending
""")
put("animation/append", """
    $data modify entity @s data.uno.deal_queue append value {seat:$(seat),idx:$(idx)}
""")
put("animation/tick", """
    # 单桌持久队列，每两刻一张；正常出牌/等待质疑时也继续播放。
    execute unless score @s un_anim_wait matches 0..1 run scoreboard players set @s un_anim_wait 0
    execute if score @s un_anim_wait matches 1 run return run scoreboard players remove @s un_anim_wait 1
    execute unless data entity @s data.uno.deal_queue[0] run return 0
    data modify storage uno:animation launch set from entity @s data.uno.deal_queue[0]
    execute store result storage uno:animation launch.table int 1 run scoreboard players get @s ct_id
    data modify storage cardtable:deal seat set from storage uno:animation launch.seat
    function uno:deck/animate with storage uno:animation launch
    data remove entity @s data.uno.deal_queue[0]
    scoreboard players set @s un_anim_wait 1
""")
put("animation/clear", """
    # 只清本桌排队与公共飞行牌；UNO 常驻盒由 visual/clear 管理。
    data remove entity @s data.uno.deal_queue
    scoreboard players set @s un_anim_wait 0
    function cardtable:animation/deal/clear
""")

put("round/start", """
    function uno:system/context
    function uno:visual/clear_cards
    function uno:animation/clear
    function uno:visual/ensure_box
    kill @e[type=minecraft:marker,tag=un.cards]
    scoreboard players add @s un_round 1
    scoreboard players set @s un_state 1
    scoreboard players set @s un_timer 20
    scoreboard players set @s un_dealt 0
    scoreboard players set @s un_dir 1
    scoreboard players set @s un_pending 0
    scoreboard players set @s un_top 0
    scoreboard players set @s un_drew 0
    scoreboard players set @s un_drawn 0
    scoreboard players set @s un_winner 0
    scoreboard players set @s un_called 0
    scoreboard players set @s un_matchend 0
    execute as @a[tag=un.audience] run scoreboard players set @s un_count 0
    execute as @a[tag=un.audience] run scoreboard players set @s un_pick -1
    scoreboard players operation @s un_turn = @a[tag=un.audience,sort=random,limit=1] un_seat
    function uno:deck/create
    function uno:system/advance
    tellraw @a[tag=un.audience] [{text:'[UNO] 第 ',color:'gold'},{score:{name:'@s',objective:'un_round'}},{text:' 局：每人七张牌。'}]
    function uno:log {text:"开始新小局及公共逐张发牌动画"}
""")
put("round/deal_tick", """
    execute if score @s un_timer matches 1.. run scoreboard players remove @s un_timer 1
    execute if score @s un_timer matches 1.. run return 0
    scoreboard players set @s un_timer 2
    scoreboard players operation #u_total un_ctx = @s un_size
    scoreboard players set #u_seven un_ctx 7
    scoreboard players operation #u_total un_ctx *= #u_seven un_ctx
    execute if score @s un_dealt >= #u_total un_ctx run return run function uno:round/deal_finish
    scoreboard players operation #seat un_ctx = @s un_turn
    function uno:deck/take
    scoreboard players add @s un_dealt 1
    function uno:round/step
""")
put("round/deal_finish", """
    tag @e[tag=un.selected] remove un.selected
    tag @e[type=minecraft:marker,tag=un.cards,scores={un_owner=0,un_value=0..9},sort=random,limit=1] add un.selected
    scoreboard players set @e[type=minecraft:marker,tag=un.selected,limit=1] un_owner -1
    scoreboard players operation @s un_top = @e[type=minecraft:marker,tag=un.selected,limit=1] un_idx
    scoreboard players operation @s un_color = @e[type=minecraft:marker,tag=un.selected,limit=1] un_color
    scoreboard players operation @s un_value = @e[type=minecraft:marker,tag=un.selected,limit=1] un_value
    scoreboard players operation #card un_ctx = @e[type=minecraft:marker,tag=un.selected,limit=1] un_card
    scoreboard players set #seat un_ctx 0
    function uno:visual/setup
    function uno:round/turn_begin
""")
put("round/step", """
    # 按实际座号和方向寻找下一名玩家，空座最多扫描八次。
    scoreboard players operation #u_seek un_ctx = @s un_turn
    scoreboard players operation #u_dir un_ctx = @s un_dir
    scoreboard players set #u_steps un_ctx 0
    function uno:round/step_loop
    scoreboard players operation @s un_turn = #u_seek un_ctx
""")
put("round/step_loop", """
    scoreboard players operation #u_seek un_ctx += #u_dir un_ctx
    execute if score #u_seek un_ctx matches 9.. run scoreboard players set #u_seek un_ctx 1
    execute if score #u_seek un_ctx matches ..0 run scoreboard players set #u_seek un_ctx 8
    scoreboard players add #u_steps un_ctx 1
    scoreboard players set #u_found un_ctx 0
    execute as @a[tag=un.audience] if score @s un_seat = #u_seek un_ctx run scoreboard players set #u_found un_ctx 1
    execute if score #u_found un_ctx matches 0 if score #u_steps un_ctx matches ..7 run function uno:round/step_loop
""")
put("round/turn_begin", """
    scoreboard players set @s un_state 2
    scoreboard players set @s un_drew 0
    scoreboard players set @s un_drawn 0
    scoreboard players set @s un_pending 0
    scoreboard players set @s un_winner 0
    scoreboard players operation #u_turn un_ctx = @s un_turn
    execute as @a[tag=un.audience] if score @s un_seat = #u_turn un_ctx run tellraw @a[tag=un.audience] [{text:'[UNO] 轮到 ',color:'gold'},{selector:'@s',color:'aqua'},{text:'。',color:'gold'}]
    execute as @a[tag=un.audience] if score @s un_seat = #u_turn un_ctx run tellraw @s [{text:'按 Q 打开第一格的 UNO 手牌；选择出牌或摸一张。',color:'yellow'}]
    function uno:system/advance
""")
put("round/resolve_play", """
    scoreboard players set @s un_pending 0
    # 先应用方向，再寻找下家；二人反转等同跳过。
    execute if score @s un_effect matches 2 run scoreboard players operation @s un_dir *= #minus un_ctx
    function uno:round/step
    execute if score @s un_effect matches 1 run function uno:round/step
    execute if score @s un_effect matches 2 if score @s un_size matches 2 run function uno:round/step
    execute if score @s un_effect matches 3 run function uno:round/penalty_two
    execute if score @s un_effect matches 4 run return run function uno:round/offer_four
    execute if score @s un_winner matches 1..8 run return run function uno:round/win
    function uno:round/turn_begin
""")
put("round/penalty_two", """
    scoreboard players operation #seat un_ctx = @s un_turn
    scoreboard players set #amount un_ctx 2
    function uno:deck/draw
    tellraw @a[tag=un.audience] [{text:'[UNO] 下家摸两张并跳过回合，罚牌不能叠加。',color:'yellow'}]
    function uno:round/step
""")
put("round/offer_four", """
    scoreboard players operation @s un_challenger = @s un_turn
    execute if score @s un_challenge matches 0 run return run function uno:round/accept_four
    scoreboard players set @s un_state 4
    scoreboard players set @s un_drew 0
    scoreboard players set @s un_drawn 0
    scoreboard players operation #u_turn un_ctx = @s un_challenger
    execute as @a[tag=un.audience] if score @s un_seat = #u_turn un_ctx run tellraw @s [{text:'[UNO] 你收到变色 +4。请在响应框选择接受罚四张，或质疑对方当时仍有当前颜色牌。',color:'yellow'}]
    tellraw @a[tag=un.audience] [{text:'[UNO] 等待下家接受或质疑变色 +4。',color:'gold'}]
    function uno:log {text:"进入变色 +4 接受或质疑阶段"}
    function uno:system/advance
""")
put("round/accept_four", """
    scoreboard players operation #seat un_ctx = @s un_challenger
    scoreboard players set #amount un_ctx 4
    function uno:deck/draw
    tellraw @a[tag=un.audience] [{text:'[UNO] 下家接受变色 +4，摸四张并跳过回合。',color:'yellow'}]
    scoreboard players operation @s un_turn = @s un_challenger
    function uno:round/step
    execute if score @s un_winner matches 1..8 run return run function uno:round/win
    function uno:round/turn_begin
""")
put("round/win", """
    # 数字按牌面值；功能牌 20，万能牌 50。末张罚牌已处理后才到这里。
    execute if score @s un_state matches 5..6 run return 0
    execute unless score @s un_winner matches 1..8 run return fail
    scoreboard players set @s un_state 5
    scoreboard players set @s un_timer 100
    scoreboard players set #u_points un_ctx 0
    execute as @e[type=minecraft:marker,tag=un.cards,scores={un_owner=1..8}] run function uno:round/count_points
    scoreboard players operation @s un_points = #u_points un_ctx
    scoreboard players operation #u_winner un_ctx = @s un_winner
    execute as @a[tag=un.audience] if score @s un_seat = #u_winner un_ctx run scoreboard players operation @s un_score += #u_points un_ctx
    execute as @a[tag=un.audience] if score @s un_seat = #u_winner un_ctx run tellraw @a[tag=un.audience] [{text:'[UNO] ',color:'gold'},{selector:'@s',color:'aqua'},{text:' 出完手牌，赢得本局！本局得分 '},{score:{name:'#u_points',objective:'un_ctx'},color:'yellow'},{text:'。'}]
    scoreboard players set @s un_matchend 0
    execute if score @s un_mode matches 0 run scoreboard players set @s un_matchend 1
    execute if score @s un_mode matches 1 if score @s un_round >= @s un_rounds run scoreboard players set @s un_matchend 1
    scoreboard players operation #u_target un_ctx = @s un_target
    execute if score @s un_mode matches 2 as @a[tag=un.audience] if score @s un_score >= #u_target un_ctx run scoreboard players set @e[tag=un.current,limit=1] un_matchend 1
    function uno:firework/winner
    function uno:system/advance
    function uno:log {text:"小局结束，完成剩余手牌计分"}
""")
put("round/count_points", """
    execute if score @s un_value matches 0..9 run scoreboard players operation #u_points un_ctx += @s un_value
    execute if score @s un_value matches 10..12 run scoreboard players add #u_points un_ctx 20
    execute if score @s un_value matches 13..14 run scoreboard players add #u_points un_ctx 50
""")

put("tick", """
    # 即时输入由 UI 模块处理；只逐刻维护正在游戏的控制器。
    # 旧正面实体只迁移一次，亦覆盖重载之后才加载的区块。
    execute as @e[type=minecraft:item_display,tag=un.face,tag=!un.face_up_v2] run function uno:visual/repair_face
    function uno:input/tick
    execute as @e[type=minecraft:marker,tag=un.controller,scores={un_state=1..5}] at @s run function uno:system/tick
    execute as @e[type=minecraft:marker,tag=un.controller,scores={un_hud_dirty=1,un_state=1..5}] at @s run function uno:system/flush
""")
put("system/tick", """
    scoreboard players add @s un_clock 1
    execute if score @s un_clock matches 20.. run function uno:system/check_online
    execute unless entity @s[tag=un.controller] run return 0
    execute if data entity @s data.uno.deal_queue[0] run function uno:animation/tick
    # 正常回合和质疑没有倒计时，不逐刻扫描手牌或重建界面。
    execute if score @s un_state matches 2 run return 0
    execute if score @s un_state matches 4 run return 0
    function uno:system/context
    execute if score @s un_state matches 1 run return run function uno:round/deal_tick
    execute if score @s un_state matches 3 run return run function uno:round/uno_tick
    execute if score @s un_state matches 5 run function uno:round/result_tick
""")
put("system/check_online", """
    function uno:system/context
    scoreboard players set @s un_clock 0
    scoreboard players set #u_online un_ctx 0
    execute as @a[tag=un.audience,tag=ct.player] if score @s ct_id = #table un_ctx run scoreboard players add #u_online un_ctx 1
    execute unless score #u_online un_ctx = @s un_size run function uno:game/player_left
""")
put("round/uno_tick", """
    scoreboard players remove @s un_timer 1
    execute if score @s un_timer matches ..0 run function uno:round/resolve_play
""")
put("round/result_tick", """
    # 末张 +2/+4 的补牌先逐张飞完，再进入小局结算倒计时。
    execute if data entity @s data.uno.deal_queue[0] run return 0
    scoreboard players remove @s un_timer 1
    execute if score @s un_timer matches 1.. run return 0
    execute if score @s un_matchend matches 1 run return run function uno:game/finish
    function uno:round/start
""")

ACTION_HEADER = """
function uno:system/context
execute unless entity @s[type=minecraft:marker,tag=un.controller] run return fail
execute unless score @s ct_game matches 11 run return fail
execute unless score @s ct_state matches 1 run return fail
execute unless entity @e[tag=un.actor,tag=un.player,tag=ct.player,tag=un.audience,limit=1] run return fail
scoreboard players set #u_actors un_ctx 0
execute as @a[tag=un.actor] run scoreboard players add #u_actors un_ctx 1
execute unless score #u_actors un_ctx matches 1 run return fail
scoreboard players operation #u_actor un_ctx = @a[tag=un.actor,tag=un.audience,limit=1] un_seat
"""
TURN_HEADER = ACTION_HEADER + """
execute unless score @s un_state matches 2 run return fail
execute unless score #u_actor un_ctx = @s un_turn run tellraw @a[tag=un.actor,limit=1] [{text:'[UNO] 现在不是你的回合。',color:'red'}]
execute unless score #u_actor un_ctx = @s un_turn run return fail
"""

put("action/play", """
    # 验证期间仅用临时分数，拒绝动作不改变控制器和手牌。
    scoreboard players operation #u_say un_ctx = #say un_ctx
    scoreboard players operation #u_chosen un_ctx = #color un_ctx
""" + TURN_HEADER + """
scoreboard players operation #u_pick un_ctx = @a[tag=un.actor,limit=1] un_pick
scoreboard players operation #u_drawn un_ctx = @s un_drawn
scoreboard players operation #u_drew un_ctx = @s un_drew
execute unless score #u_pick un_ctx matches 0..53 run tellraw @a[tag=un.actor,limit=1] [{text:'[UNO] 请先选择一张手牌。',color:'red'}]
execute unless score #u_pick un_ctx matches 0..53 run return fail
execute as @e[type=minecraft:marker,tag=un.cards] if score @s un_owner = #u_actor un_ctx if score @s un_card = #u_pick un_ctx unless entity @e[tag=un.selected] if score #u_drew un_ctx matches 0 run tag @s add un.selected
execute as @e[type=minecraft:marker,tag=un.cards] if score @s un_owner = #u_actor un_ctx if score @s un_card = #u_pick un_ctx if score @s un_idx = #u_drawn un_ctx if score #u_drew un_ctx matches 1 run tag @s add un.selected
execute unless entity @e[type=minecraft:marker,tag=un.selected,limit=1] run tellraw @a[tag=un.actor,limit=1] [{text:'[UNO] 这张牌不属于你，或不是本回合刚摸的牌。',color:'red'}]
execute unless entity @e[type=minecraft:marker,tag=un.selected,limit=1] run return fail
scoreboard players operation #u_color un_ctx = @s un_color
scoreboard players operation #u_value un_ctx = @s un_value
scoreboard players set #u_valid un_ctx 0
execute if score @e[tag=un.selected,limit=1] un_color = #u_color un_ctx run scoreboard players set #u_valid un_ctx 1
execute if score @e[tag=un.selected,limit=1] un_value = #u_value un_ctx run scoreboard players set #u_valid un_ctx 1
execute if score #u_pick un_ctx matches 52..53 run scoreboard players set #u_valid un_ctx 1
execute if score #u_valid un_ctx matches 0 run tellraw @a[tag=un.actor,limit=1] [{text:'[UNO] 需匹配当前颜色、数字或功能符号。',color:'red'}]
execute if score #u_valid un_ctx matches 0 run return fail
execute if score #u_pick un_ctx matches 52..53 unless score #u_chosen un_ctx matches 0..3 run tellraw @a[tag=un.actor,limit=1] [{text:'[UNO] 请选择红、黄、绿或蓝。',color:'red'}]
execute if score #u_pick un_ctx matches 52..53 unless score #u_chosen un_ctx matches 0..3 run return fail
scoreboard players set #u_wildbad un_ctx 0
execute if score #u_pick un_ctx matches 53 as @e[type=minecraft:marker,tag=un.cards] if score @s un_owner = #u_actor un_ctx if score @s un_color = #u_color un_ctx run scoreboard players set #u_wildbad un_ctx 1
execute if score #u_pick un_ctx matches 53 if score #u_wildbad un_ctx matches 1 if score @s un_challenge matches 0 run tellraw @a[tag=un.actor,limit=1] [{text:'[UNO] 你仍有当前颜色牌，关闭质疑时不能打出 +4。',color:'red'}]
execute if score #u_pick un_ctx matches 53 if score #u_wildbad un_ctx matches 1 if score @s un_challenge matches 0 run return fail
function uno:action/commit_play
""")
put("action/commit_play", """
    # 到此才提交牌权与张数；不合法操作不会先改手牌。
    scoreboard players set #ui_played un_ctx 1
    scoreboard players operation @s un_say = #u_say un_ctx
    scoreboard players operation @s un_chosen = #u_chosen un_ctx
    scoreboard players operation @s un_wildbad = #u_wildbad un_ctx
    scoreboard players operation @s un_offender = #u_actor un_ctx
    scoreboard players operation @s un_top = @e[tag=un.selected,limit=1] un_idx
    scoreboard players operation @s un_value = @e[tag=un.selected,limit=1] un_value
    scoreboard players operation @s un_color = @e[tag=un.selected,limit=1] un_color
    execute if score #u_pick un_ctx matches 52..53 run scoreboard players operation @s un_color = @s un_chosen
    scoreboard players set @e[tag=un.selected,limit=1] un_owner -1
    scoreboard players operation @e[tag=un.selected,limit=1] un_order = @s un_epoch
    scoreboard players remove @a[tag=un.actor,limit=1] un_count 1
    scoreboard players set @a[tag=un.actor,limit=1] un_pick -1
    scoreboard players set @s un_effect 0
    execute if score @s un_value matches 10 run scoreboard players set @s un_effect 1
    execute if score @s un_value matches 11 run scoreboard players set @s un_effect 2
    execute if score @s un_value matches 12 run scoreboard players set @s un_effect 3
    execute if score @s un_value matches 14 run scoreboard players set @s un_effect 4
    scoreboard players set @s un_winner 0
    execute if score @a[tag=un.actor,limit=1] un_count matches 0 run scoreboard players operation @s un_winner = #u_actor un_ctx
    scoreboard players operation #card un_ctx = #u_pick un_ctx
    scoreboard players operation #seat un_ctx = #u_actor un_ctx
    function uno:message/play
    function uno:visual/play
    function uno:log {text:"合法出牌已提交，处理 UNO、功能牌及胜利判定"}
    execute if score @a[tag=un.actor,limit=1] un_count matches 1 if score @s un_auto matches 0 unless score @s un_say matches 1 run return run function uno:round/offer_uno
    execute if score @a[tag=un.actor,limit=1] un_count matches 1 run tellraw @a[tag=un.audience] [{text:'[UNO] ',color:'gold'},{selector:'@a[tag=un.actor,limit=1]',color:'aqua'},{text:'：UNO！',color:'yellow'}]
    function uno:round/resolve_play
""")

# 聊天是公开出牌的记录；出牌成功后才调用，绝不播报未提交的手牌选择。
card_labels = []
for colour in ("红", "黄", "绿", "蓝"):
    card_labels.extend([colour + str(n) for n in range(10)] + [colour + "·跳过", colour + "·反转", colour + "·+2"])
card_labels += ["变色", "变色+4"]
play_message = ['data modify storage uno:message play.card set value {text:"未知牌",color:"white"}',
                'data modify storage uno:message play.chosen set value {text:""}']
for index, label in enumerate(card_labels):
    colour = ("red", "yellow", "green", "blue")[index // 13] if index < 52 else "light_purple"
    play_message.append(f'execute if score #u_pick un_ctx matches {index} run data modify storage uno:message play.card set value {{text:"{label}",color:"{colour}"}}')
for index, (label, colour) in enumerate(zip(("红", "黄", "绿", "蓝"), ("red", "yellow", "green", "blue"))):
    play_message.append(f'execute if score #u_pick un_ctx matches 52..53 if score @s un_color matches {index} run data modify storage uno:message play.chosen set value {{text:"（改为{label}色）",color:"{colour}"}}')
play_message.append('function uno:message/play_text with storage uno:message play')
put('message/play', '\n'.join(play_message))
put('message/play_text', '''
$tellraw @a[tag=un.audience] [{text:"[UNO] ",color:"gold"},{selector:"@a[tag=un.actor,limit=1]",color:"aqua"},{text:" 出了 ",color:"gray"},$(card),$(chosen),{text:"。",color:"gray"}]
''')
put("round/offer_uno", """
    scoreboard players set @s un_state 3
    scoreboard players operation @s un_pending = @s un_offender
    scoreboard players operation @s un_timer = @s un_window
    scoreboard players set @s un_called 0
    scoreboard players set @s un_drew 0
    scoreboard players set @s un_drawn 0
    tellraw @a[tag=un.audience] [{text:'[UNO] 有人只剩一张牌却没喊 UNO！请在响应框抓 UNO；本人可以补喊。',color:'yellow'}]
    function uno:log {text:"暂停下家回合，开放抓 UNO 窗口"}
    function uno:system/advance
""")
put("action/draw", TURN_HEADER + """
execute if score @s un_drew matches 1 run tellraw @a[tag=un.actor,limit=1] [{text:'[UNO] 本回合已经摸过牌，只能打刚摸的牌或结束回合。',color:'red'}]
execute if score @s un_drew matches 1 run return fail
scoreboard players operation #seat un_ctx = #u_actor un_ctx
scoreboard players set #amount un_ctx 1
function uno:deck/draw
scoreboard players set @a[tag=un.actor,limit=1] un_pick -1
execute if score #draw_idx un_ctx matches 0 run tellraw @a[tag=un.actor,limit=1] [{text:'[UNO] 当前没有可摸的牌，回合结束。',color:'yellow'}]
execute if score #draw_idx un_ctx matches 0 run return run function uno:action/end_turn
scoreboard players operation @s un_drawn = #draw_idx un_ctx
scoreboard players set @s un_drew 1
scoreboard players operation #u_color un_ctx = @s un_color
scoreboard players operation #u_value un_ctx = @s un_value
scoreboard players set #u_valid un_ctx 0
execute if score @e[tag=un.selected,limit=1] un_color = #u_color un_ctx run scoreboard players set #u_valid un_ctx 1
execute if score @e[tag=un.selected,limit=1] un_value = #u_value un_ctx run scoreboard players set #u_valid un_ctx 1
execute if score @e[tag=un.selected,limit=1] un_card matches 52..53 run scoreboard players set #u_valid un_ctx 1
# 关闭质疑时，刚摸的非法 +4 也不能打出，直接结束回合。
scoreboard players set #u_hascolor un_ctx 0
execute as @e[type=minecraft:marker,tag=un.cards] if score @s un_owner = #u_actor un_ctx if score @s un_color = #u_color un_ctx run scoreboard players set #u_hascolor un_ctx 1
execute if score @e[tag=un.selected,limit=1] un_card matches 53 if score @s un_challenge matches 0 if score #u_hascolor un_ctx matches 1 run scoreboard players set #u_valid un_ctx 0
execute if score #u_valid un_ctx matches 0 run tellraw @a[tag=un.actor,limit=1] [{text:'[UNO] 摸到的牌不能出，回合结束。',color:'yellow'}]
execute if score #u_valid un_ctx matches 0 run return run function uno:action/end_turn
scoreboard players operation @a[tag=un.actor,limit=1] un_pick = @e[tag=un.selected,limit=1] un_card
tellraw @a[tag=un.actor,limit=1] [{text:'[UNO] 刚摸的牌可以出。按 Q 选择打出它或结束回合。',color:'yellow'}]
function uno:system/advance
""")
put("action/pass", TURN_HEADER + """
execute unless score @s un_drew matches 1 run tellraw @a[tag=un.actor,limit=1] [{text:'[UNO] 请先摸一张牌，不能直接跳过。',color:'red'}]
execute unless score @s un_drew matches 1 run return fail
function uno:action/end_turn
""")
put("action/end_turn", """
    function uno:round/step
    function uno:round/turn_begin
""")
put("action/call", ACTION_HEADER + """
execute unless score @s un_state matches 3 run return fail
execute unless score #u_actor un_ctx = @s un_pending run return fail
scoreboard players set @s un_called 1
tellraw @a[tag=un.audience] [{text:'[UNO] ',color:'gold'},{selector:'@a[tag=un.actor,limit=1]',color:'aqua'},{text:' 及时补喊 UNO！',color:'yellow'}]
function uno:round/resolve_play
""")
put("action/catch", ACTION_HEADER + """
execute unless score @s un_state matches 3 run return fail
execute if score #u_actor un_ctx = @s un_pending run return fail
scoreboard players operation #seat un_ctx = @s un_pending
scoreboard players set #amount un_ctx 2
function uno:deck/draw
tellraw @a[tag=un.audience] [{text:'[UNO] 抓 UNO 成功，漏喊者摸两张。',color:'yellow'}]
function uno:round/resolve_play
""")
FOUR_HEADER = ACTION_HEADER + """
execute unless score @s un_state matches 4 run return fail
execute unless score #u_actor un_ctx = @s un_challenger run return fail
"""
put("action/accept", FOUR_HEADER + "function uno:round/accept_four\n")
put("action/challenge", FOUR_HEADER + """
execute if score @s un_wildbad matches 1 run return run function uno:action/challenge_success
scoreboard players operation #seat un_ctx = @s un_challenger
scoreboard players set #amount un_ctx 6
function uno:deck/draw
tellraw @a[tag=un.audience] [{text:'[UNO] 质疑失败：+4 合法。质疑者摸六张并跳过回合。',color:'yellow'}]
scoreboard players operation @s un_turn = @s un_challenger
function uno:round/step
execute if score @s un_winner matches 1..8 run return run function uno:round/win
function uno:round/turn_begin
""")
put("action/challenge_success", """
    scoreboard players operation #seat un_ctx = @s un_offender
    scoreboard players set #amount un_ctx 4
    function uno:deck/draw
    scoreboard players set @s un_winner 0
    tellraw @a[tag=un.audience] [{text:'[UNO] 质疑成功：出牌者当时仍有当前颜色牌，罚摸四张；质疑者正常行动。',color:'yellow'}]
    scoreboard players operation @s un_turn = @s un_challenger
    function uno:round/turn_begin
""")

print(f"Generated {len(list(ROOT.rglob('*.mcfunction')))} UNO function files (including independently maintained UI).")
