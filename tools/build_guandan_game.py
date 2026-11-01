"""掼蛋18：108张实卡、四方队伍、贡还、接风及多副升级生命周期。"""
from pathlib import Path
import json

PACK = Path(__file__).resolve().parents[1]
ROOT = PACK/'data/guandan/function'
OBJECTIVES = '''gd_state gd_phase gd_turn gd_epoch gd_timer gd_anim gd_tick gd_round gd_level
gd_team0 gd_team1 gd_playteam gd_first gd_lastseat gd_lastkind gd_lastsize gd_lasthi gd_lastpow
gd_kind gd_size gd_high gd_power gd_actor gd_passes gd_done gd_winner gd_steps gd_scored
gd_pair gd_startlevel gd_mode gd_rounds gd_show gd_limit gd_clock gd_dealt gd_dealorder
gd_seat gd_order gd_team gd_count gd_rank gd_prevrank gd_points gd_table gd_id gd_type
gd_owner gd_sel gd_used gd_point gd_suit gd_wild gd_strength gd_giftid gd_returnid gd_peer
gd_tribute gd_return gd_tribn gd_firstorder gd_matchwin gd_drop gd_hud gd_panel'''.split()


def put(name, body):
    target=ROOT/(name+'.mcfunction');target.parent.mkdir(parents=True,exist_ok=True)
    target.write_text(('\n'.join(body) if isinstance(body,list) else body).strip()+'\n',encoding='utf-8')


def build():
    objectives={name:'dummy' for name in OBJECTIVES};objectives['gd_ctx']='dummy'
    objectives.update({'gd_action':'trigger','gd_settings':'trigger','gd_drop':'minecraft.dropped:minecraft.purple_dye'})
    for module in ('build_guandan_ui','build_guandan_settings','build_guandan_hud','build_guandan_cards'):
        try:
            mod=__import__(module);extra=getattr(mod,'OBJECTIVES',{})
            objectives.update(extra if isinstance(extra,dict) else {name:'dummy' for name in extra})
        except ImportError:
            pass
    put('load',[f'scoreboard objectives add {name} {kind}' for name,kind in sorted(objectives.items())]+[
        'execute unless score #version gd_ctx matches 1.. run scoreboard players set #version gd_ctx 1',
        'execute unless score #epoch_serial gd_ctx matches 10000..999999 run scoreboard players set #epoch_serial gd_ctx 10000',
        'scoreboard players set #four gd_ctx 4','scoreboard players set #fiftyfour gd_ctx 54','function guandan:cards/constants',
        'scoreboard players add #ui_load gd_ctx 1','scoreboard players reset * gd_action','scoreboard players reset * gd_settings',
        'function guandan:visual/load',
        'execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=18}] at @s run function guandan:system/reload'])
    put('tick','''
function guandan:input/tick
execute as @e[type=minecraft:marker,tag=gd.controller,scores={ct_game=18,gd_state=1..5}] at @s run function guandan:game/tick
execute as @e[type=minecraft:marker,tag=gd.controller,scores={ct_game=18}] at @s run function guandan:visual/tick
''')
    put('system/context','''
scoreboard players operation #table gd_ctx = @s ct_id
tag @e[tag=gd.current] remove gd.current
tag @e[tag=gd.board] remove gd.board
tag @e[tag=gd.cards] remove gd.cards
tag @e[tag=gd.audience] remove gd.audience
tag @s add gd.current
execute as @e[type=minecraft:marker,tag=gd.part] if score @s ct_id = #table gd_ctx run tag @s add gd.board
execute as @e[type=minecraft:marker,tag=gd.card] if score @s ct_id = #table gd_ctx run tag @s add gd.cards
execute as @a[tag=gd.player,tag=ct.player] if score @s gd_table = #table gd_ctx if score @s ct_id = #table gd_ctx run tag @s add gd.audience
''')
    put('system/reload','''
tag @s add gd.controller
execute if score @s ct_state matches 0 run return run function guandan:game/init_table
function guandan:system/context
function guandan:game/bump_epoch
function guandan:visual/refresh
execute as @a[tag=gd.audience] run function guandan:input/give
function guandan:hud/refresh
# 活跃牌库、选中的贡还牌、计时和发牌进度全部保留。
''')
    put('game/bump_epoch','''
scoreboard players add #epoch_serial gd_ctx 1
execute unless score #epoch_serial gd_ctx matches 10000..999999 run scoreboard players set #epoch_serial gd_ctx 10000
scoreboard players operation @s gd_epoch = #epoch_serial gd_ctx
''')
    init=['tag @s add gd.controller']
    for obj,bounds,value in [('gd_pair','0..1',1),('gd_startlevel','2..14',2),('gd_mode','0..1',0),('gd_rounds','1..32',8),('gd_show','0..1',1),('gd_limit','0..120',0)]:
        init +=[f'execute unless score @s {obj} matches {bounds} run scoreboard players set @s {obj} {value}']
    init+=['execute if score @s ct_state matches 1 run return 0','scoreboard players set @s gd_state 0','function guandan:visual/setup']
    put('game/init_table',init)
    put('game/start','''
scoreboard players set @s ct_start 0
execute if score @s ct_state matches 1 run return fail
execute unless score @s ct_joined matches 4 run return run function guandan:game/bad_count
execute unless score @s ct_capacity matches 4 unless score @s ct_capacity matches 8 run return fail
scoreboard players operation #table gd_ctx = @s ct_id
scoreboard players set #online gd_ctx 0
scoreboard players set #occupied gd_ctx 0
tag @a[tag=gd.start] remove gd.start
execute as @a[tag=ct.player] if score @s ct_id = #table gd_ctx run tag @s add gd.start
execute as @a[tag=gd.start] run scoreboard players add #online gd_ctx 1
execute unless score #online gd_ctx matches 4 run return run function guandan:game/bad_count
execute as @a[tag=gd.start] if items entity @s hotbar.0 * run scoreboard players set #occupied gd_ctx 1
execute as @a[tag=gd.start] if items entity @s hotbar.8 * run scoreboard players set #occupied gd_ctx 1
execute if score #occupied gd_ctx matches 1 run return run function guandan:game/bad_slots
function guandan:game/init_table
execute if score @s gd_pair matches 0 run function guandan:game/check_sides
execute if score @s gd_pair matches 0 unless score #sides_ok gd_ctx matches 1 run return run function guandan:game/bad_sides
function guandan:game/clear
tag @s add gd.controller
function guandan:system/context
execute if score @s gd_pair matches 1 run function guandan:game/random_sides
execute as @a[tag=gd.start] run function guandan:player/join
tag @a[tag=gd.start] remove gd.start
function guandan:system/context
scoreboard players set @s gd_round 0
scoreboard players operation @s gd_team0 = @s gd_startlevel
scoreboard players operation @s gd_team1 = @s gd_startlevel
scoreboard players operation @s gd_level = @s gd_startlevel
scoreboard players set @s gd_playteam -1
scoreboard players set @s gd_tick 0
scoreboard players set @s gd_winner -1
scoreboard players set @s gd_matchwin -1
scoreboard players set @s ct_start 1
function guandan:round/begin
function guandan:log {text:"掼蛋开局：四名真人、108张牌、对家搭档"}
''')
    put('game/bad_count','''
scoreboard players operation #table gd_ctx = @s ct_id
execute as @a[tag=ct.player] if score @s ct_id = #table gd_ctx run tellraw @s {text:"[掼蛋] 需要恰好4名玩家。",color:"yellow"}
return fail
''')
    put('game/bad_slots','tellraw @a[tag=gd.start] {text:"[掼蛋] 请先腾空快捷栏第1格与最后一格。",color:"yellow"}\nreturn fail')
    put('game/bad_sides','tellraw @a[tag=gd.start] {text:"[掼蛋] 自选搭档时，四个方向须各坐一人；相对而坐的玩家为队友。也可切换随机搭档。",color:"yellow"}\nreturn fail')
    put('player/side','''
scoreboard players operation @s gd_order = @s ct_seat
scoreboard players remove @s gd_order 1
execute if score #cap gd_ctx matches 8 run scoreboard players operation @s gd_order /= #two gd_ctx
''')
    put('game/check_sides','''
scoreboard players operation #cap gd_ctx = @s ct_capacity
scoreboard players set #two gd_ctx 2
scoreboard players set #sides_ok gd_ctx 1
execute as @a[tag=gd.start] run function guandan:player/side
scoreboard players set #side0 gd_ctx 0
scoreboard players set #side1 gd_ctx 0
scoreboard players set #side2 gd_ctx 0
scoreboard players set #side3 gd_ctx 0
execute as @a[tag=gd.start,scores={gd_order=0}] run scoreboard players add #side0 gd_ctx 1
execute as @a[tag=gd.start,scores={gd_order=1}] run scoreboard players add #side1 gd_ctx 1
execute as @a[tag=gd.start,scores={gd_order=2}] run scoreboard players add #side2 gd_ctx 1
execute as @a[tag=gd.start,scores={gd_order=3}] run scoreboard players add #side3 gd_ctx 1
execute unless score #side0 gd_ctx matches 1 run scoreboard players set #sides_ok gd_ctx 0
execute unless score #side1 gd_ctx matches 1 run scoreboard players set #sides_ok gd_ctx 0
execute unless score #side2 gd_ctx matches 1 run scoreboard players set #sides_ok gd_ctx 0
execute unless score #side3 gd_ctx matches 1 run scoreboard players set #sides_ok gd_ctx 0
''')
    put('game/random_sides','''
scoreboard players operation #cap gd_ctx = @s ct_capacity
scoreboard players set #assign gd_ctx 0
tag @a[tag=gd.assigned] remove gd.assigned
execute as @a[tag=gd.start] run ride @s dismount
function guandan:game/assign_one
function guandan:game/assign_one
function guandan:game/assign_one
function guandan:game/assign_one
function cardtable:table/ensure_seats
execute as @a[tag=gd.start] at @s run function cardtable:seat/mount
tag @a[tag=gd.assigned] remove gd.assigned
''')
    put('game/assign_one','execute as @a[tag=gd.start,tag=!gd.assigned,sort=random,limit=1] run function guandan:player/assign')
    put('player/assign','''
tag @s add gd.assigned
scoreboard players operation @s gd_order = #assign gd_ctx
scoreboard players operation @s ct_seat = #assign gd_ctx
execute if score #cap gd_ctx matches 8 run scoreboard players operation @s ct_seat *= #two gd_ctx
scoreboard players add @s ct_seat 1
scoreboard players add #assign gd_ctx 1
''')
    # random_sides needs its own constant even if the first match is random.
    put('game/random_sides',(ROOT/'game/random_sides.mcfunction').read_text(encoding='utf-8').replace('scoreboard players set #assign','scoreboard players set #two gd_ctx 2\nscoreboard players set #assign',1))
    put('player/join','''
tag @s add gd.player
scoreboard players operation @s gd_table = @s ct_id
scoreboard players operation @s gd_seat = @s ct_seat
scoreboard players operation @s gd_team = @s gd_order
scoreboard players operation @s gd_team %= #two gd_ctx
scoreboard players set @s gd_drop 0
scoreboard players operation #join_seat gd_ctx = @s gd_seat
scoreboard players operation #join_order gd_ctx = @s gd_order
scoreboard players operation #join_team gd_ctx = @s gd_team
function guandan:name/resolve
execute as @e[tag=gd.current,limit=1] at @s summon minecraft:marker run function guandan:game/part
function guandan:input/give
''')
    put('game/part','''
tag @s add gd.part
scoreboard players operation @s ct_id = #table gd_ctx
scoreboard players operation @s gd_seat = #join_seat gd_ctx
scoreboard players operation @s gd_order = #join_order gd_ctx
scoreboard players operation @s gd_team = #join_team gd_ctx
scoreboard players set @s gd_points 0
scoreboard players set @s gd_prevrank 0
scoreboard players set @s gd_rank 0
scoreboard players set @s gd_count 0
data modify entity @s data.gd_name set from storage guandan:name resolved
data modify entity @s data.last_play set value []
data modify entity @s data.last_label set value ""
''')
    put('round/begin','''
function guandan:system/context
scoreboard players add @s gd_round 1
scoreboard players set @s gd_state 1
scoreboard players set @s gd_phase 0
scoreboard players set @s gd_anim 0
scoreboard players set @s gd_timer 2
scoreboard players set @s gd_dealt 0
scoreboard players set @s gd_done 0
scoreboard players set @s gd_scored 0
scoreboard players set @s gd_lastkind 0
scoreboard players set @s gd_lastseat -1
scoreboard players set @s gd_passes 0
scoreboard players set @s gd_tribn 0
scoreboard players set @e[tag=gd.board] gd_rank 0
scoreboard players set @e[tag=gd.board] gd_count 0
scoreboard players set @e[tag=gd.board] gd_tribute 0
scoreboard players set @e[tag=gd.board] gd_return 0
scoreboard players set @e[tag=gd.board] gd_giftid -1
scoreboard players set @e[tag=gd.board] gd_returnid -1
execute as @e[tag=gd.board] run data modify entity @s data.last_play set value []
execute as @e[tag=gd.board] run data modify entity @s data.last_label set value ""
data modify entity @s data.guandan.action set value {}
data modify entity @s data.guandan.options set value []
function guandan:game/bump_epoch
function guandan:deck/build
scoreboard players operation @s gd_first = @e[tag=gd.board,sort=random,limit=1] gd_seat
scoreboard players operation #first gd_ctx = @s gd_first
execute as @e[tag=gd.board] if score @s gd_seat = #first gd_ctx run scoreboard players operation @e[tag=gd.current,limit=1] gd_dealorder = @s gd_order
function guandan:visual/refresh
function guandan:visual/shuffle
function guandan:sound/start
tellraw @a[tag=gd.audience] [{text:"[掼蛋] 第",color:"gold"},{score:{name:"@s",objective:"gd_round"}},{text:"副开始，打 "},{score:{name:"@s",objective:"gd_level"}},{text:" 级。"}]
function guandan:hud/refresh
''')
    put('deck/build','''
function guandan:cards/constants
kill @e[tag=gd.cards]
scoreboard players operation #level gd_ctx = @s gd_level
scoreboard players set #build gd_ctx 0
function guandan:deck/next
''')
    put('deck/next','''
execute summon minecraft:marker run function guandan:deck/card
scoreboard players add #build gd_ctx 1
execute if score #build gd_ctx matches ..107 run function guandan:deck/next
''')
    put('deck/card','''
tag @s add gd.card
tag @s add gd.cards
scoreboard players operation @s ct_id = #table gd_ctx
scoreboard players operation @s gd_id = #build gd_ctx
scoreboard players operation @s gd_type = #build gd_ctx
scoreboard players operation @s gd_type %= #fiftyfour gd_ctx
scoreboard players set @s gd_owner -1
scoreboard players set @s gd_sel 0
scoreboard players set @s gd_used 0
function guandan:cards/normalize
''')
    put('game/tick','''
execute if score @s gd_state matches 1 run function guandan:deal/tick
execute if score @s gd_state matches 2..3 run function guandan:clock/tick
execute if score @s gd_state matches 4..5 run function guandan:round/result_tick
scoreboard players add @s gd_tick 1
execute if score @s gd_tick matches 20.. run function guandan:game/maintenance
''')
    put('deal/tick','''
scoreboard players remove @s gd_timer 1
execute if score @s gd_timer matches 1.. run return 0
execute if score @s gd_dealt matches 108.. run return run function guandan:tribute/begin
function guandan:system/context
function guandan:cards/constants
scoreboard players operation #deal_order gd_ctx = @s gd_dealorder
execute as @e[tag=gd.board] if score @s gd_order = #deal_order gd_ctx run scoreboard players operation #deal_seat gd_ctx = @s gd_seat
tag @e[tag=gd.dealing] remove gd.dealing
tag @e[tag=gd.cards,scores={gd_owner=-1},sort=random,limit=1] add gd.dealing
scoreboard players operation @e[tag=gd.dealing,limit=1] gd_owner = #deal_seat gd_ctx
execute as @e[tag=gd.board] if score @s gd_seat = #deal_seat gd_ctx run scoreboard players add @s gd_count 1
function guandan:deal/launch
scoreboard players add @s gd_dealt 1
scoreboard players add @s gd_dealorder 3
scoreboard players operation @s gd_dealorder %= #four gd_ctx
scoreboard players set @s gd_timer 2
execute if score @s gd_dealt matches 108 run scoreboard players set @s gd_timer 8
tag @e[tag=gd.dealing] remove gd.dealing
''')
    put('deal/launch','''
execute store result storage guandan:deal seat int 1 run scoreboard players get #deal_seat gd_ctx
execute store result storage guandan:deal table int 1 run scoreboard players get @s ct_id
function cardtable:animation/deal/spawn_card
function guandan:deal/configure with storage guandan:deal
function cardtable:animation/deal/sound
function cardtable:animation/deal/launch with storage guandan:deal
''')
    put('deal/configure','''
$item replace entity @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,limit=1] contents with minecraft:paper[minecraft:item_model="card:poker/back",minecraft:item_name="掼蛋",minecraft:custom_data={guandan:{visual:1b,table:$(table)}},minecraft:max_stack_size=1]
tag @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,limit=1] add ct.visual_only
''')
    put('game/first_turn','''
scoreboard players set @s gd_state 3
scoreboard players set @s gd_phase 0
scoreboard players operation @s gd_turn = @s gd_first
scoreboard players set @s gd_lastkind 0
scoreboard players set @s gd_lastseat -1
scoreboard players set @s gd_passes 0
function guandan:game/bump_epoch
function guandan:clock/reset
function guandan:visual/refresh
function guandan:hud/refresh
function guandan:ui/refresh
''')
    put('game/validate_actor','''
scoreboard players set #ok gd_ctx 0
execute unless score @s gd_state matches 3 run return 0
execute if score @s gd_anim matches 1.. run return 0
execute unless score #actor gd_ctx = @s gd_turn run return 0
function guandan:system/context
scoreboard players set #actor_valid gd_ctx 0
execute as @e[tag=gd.board,scores={gd_rank=0,gd_count=1..27}] if score @s gd_seat = #actor gd_ctx run scoreboard players set #actor_valid gd_ctx 1
execute unless score #actor_valid gd_ctx matches 1 run return 0
scoreboard players set #ok gd_ctx 1
''')
    put('game/select_context','''
tag @e[tag=gd.selected] remove gd.selected
execute as @e[tag=gd.cards,scores={gd_sel=1}] if score @s gd_owner = #actor gd_ctx run tag @s add gd.selected
''')
    put('game/play','''
function guandan:game/validate_actor
execute unless score #ok gd_ctx matches 1 run return 0
function guandan:game/select_context
function guandan:cards/analyze
scoreboard players set #ok gd_ctx 0
execute unless score #options gd_ctx matches 1.. run return 0
execute if score #options gd_ctx matches 2.. run return 0
scoreboard players set #choice gd_ctx 0
function guandan:game/submit
''')
    put('game/submit','''
function guandan:game/validate_actor
execute unless score #ok gd_ctx matches 1 run return 0
function guandan:game/select_context
function guandan:cards/analyze
function guandan:cards/choose
execute unless score #ok gd_ctx matches 1 run return 0
function guandan:cards/compare
execute unless score #beats gd_ctx matches 1 run return run function guandan:game/reject
function guandan:game/commit
''')
    put('game/reject','scoreboard players set #ok gd_ctx 0\nreturn 0')
    put('game/commit','''
scoreboard players operation @s gd_actor = #actor gd_ctx
data modify entity @s data.guandan.action set value {cardtypes:[],ids:[]}
data modify entity @s data.guandan.action.label set from entity @s data.guandan.chosen.label
data modify entity @s data.guandan.action.suit set from entity @s data.guandan.chosen.suit
data modify entity @s data.guandan.action.point set from entity @s data.guandan.chosen.point
data modify entity @s data.guandan.action.text set value {text:""}
data modify entity @s data.guandan.action.text.text set from entity @s data.guandan.chosen.label
execute store result entity @s data.guandan.action.seat int 1 run scoreboard players get #actor gd_ctx
execute store result entity @s data.guandan.action.kind int 1 run scoreboard players get @s gd_kind
execute store result entity @s data.guandan.action.size int 1 run scoreboard players get @s gd_size
execute store result entity @s data.guandan.action.high int 1 run scoreboard players get @s gd_high
execute store result entity @s data.guandan.action.power int 1 run scoreboard players get @s gd_power
execute store result entity @s data.guandan.action.round int 1 run scoreboard players get @s gd_round
function guandan:game/commit_ordered
scoreboard players operation #played gd_ctx = @s gd_size
execute as @e[tag=gd.board] if score @s gd_seat = #actor gd_ctx run function guandan:game/commit_part
scoreboard players operation @s gd_lastseat = #actor gd_ctx
scoreboard players operation @s gd_lastkind = @s gd_kind
scoreboard players operation @s gd_lastsize = @s gd_size
scoreboard players operation @s gd_lasthi = @s gd_high
scoreboard players operation @s gd_lastpow = @s gd_power
scoreboard players set @s gd_passes 0
scoreboard players set @s gd_anim 8
function guandan:visual/play
function guandan:sound/play
execute if score @s gd_kind matches 8 run function guandan:sound/bomb
execute if score @s gd_kind matches 9..10 run function guandan:sound/straight_flush
function guandan:game/announce_play
function guandan:round/check_end
execute if score @s gd_state matches 3 run function guandan:game/next_turn
function guandan:game/bump_epoch
function guandan:hud/refresh
function guandan:ui/refresh
scoreboard players set #ok gd_ctx 1
''')
    put('game/commit_card','''
execute store result storage guandan:runtime value int 1 run scoreboard players get @s gd_type
data modify entity @e[tag=gd.current,limit=1] data.guandan.action.cardtypes append from storage guandan:runtime value
execute store result storage guandan:runtime value int 1 run scoreboard players get @s gd_id
data modify entity @e[tag=gd.current,limit=1] data.guandan.action.ids append from storage guandan:runtime value
scoreboard players set @s gd_owner -2
scoreboard players set @s gd_sel 0
scoreboard players set @s gd_used 1
''')
    put('game/commit_part','''
scoreboard players operation @s gd_count -= #played gd_ctx
data modify entity @s data.last_play set from entity @e[tag=gd.current,limit=1] data.guandan.action.cardtypes
data modify entity @s data.last_label set from entity @e[tag=gd.current,limit=1] data.guandan.action.label
execute unless score @s gd_count matches 0 run return 0
scoreboard players add @e[tag=gd.current,limit=1] gd_done 1
scoreboard players operation @s gd_rank = @e[tag=gd.current,limit=1] gd_done
tellraw @a[tag=gd.audience] [{text:"[掼蛋] ",color:"gold"},{nbt:"data.gd_name",entity:"@s",interpret:true,color:"aqua"},{text:" 出完手牌，取得第"},{score:{name:"@s",objective:"gd_rank"}},{text:"名。"}]
''')
    put('game/announce_play','''
scoreboard players operation #announce gd_ctx = @s gd_actor
execute as @e[tag=gd.board] if score @s gd_seat = #announce gd_ctx run function guandan:game/announce_part
''')
    put('game/announce_part','''
execute if entity @e[tag=gd.current,scores={gd_show=1},limit=1] run tellraw @a[tag=gd.audience] [{text:"[掼蛋] ",color:"gold"},{nbt:"data.gd_name",entity:"@s",interpret:true,color:"aqua"},{text:" 出牌："},{nbt:"data.guandan.action.text",entity:"@e[tag=gd.current,limit=1]",interpret:true},{text:"，余 "},{score:{name:"@s",objective:"gd_count"}},{text:" 张。"}]
execute unless entity @e[tag=gd.current,scores={gd_show=1},limit=1] run tellraw @a[tag=gd.audience] [{text:"[掼蛋] ",color:"gold"},{nbt:"data.gd_name",entity:"@s",interpret:true,color:"aqua"},{text:" 出牌："},{nbt:"data.guandan.action.text",entity:"@e[tag=gd.current,limit=1]",interpret:true},{text:"。"}]
''')
    put('game/pass','''
function guandan:game/validate_actor
execute unless score #ok gd_ctx matches 1 run return 0
execute if score @s gd_lastkind matches 0 run return run function guandan:game/reject
scoreboard players add @s gd_passes 1
scoreboard players set #remaining gd_ctx 0
execute as @e[tag=gd.board,scores={gd_rank=0}] run scoreboard players add #remaining gd_ctx 1
scoreboard players operation #leader gd_ctx = @s gd_lastseat
execute as @e[tag=gd.board,scores={gd_rank=0}] if score @s gd_seat = #leader gd_ctx run scoreboard players remove #remaining gd_ctx 1
function guandan:sound/pass
execute as @e[tag=gd.board] if score @s gd_seat = #actor gd_ctx run tellraw @a[tag=gd.audience] [{text:"[掼蛋] ",color:"gold"},{nbt:"data.gd_name",entity:"@s",interpret:true,color:"aqua"},{text:" 不出。",color:"gray"}]
execute if score @s gd_passes >= #remaining gd_ctx run return run function guandan:game/new_trick
function guandan:game/next_turn
function guandan:game/bump_epoch
function guandan:hud/refresh
function guandan:ui/refresh
scoreboard players set #ok gd_ctx 1
''')
    put('game/next_turn','''
scoreboard players operation #turn gd_ctx = @s gd_turn
execute as @e[tag=gd.board] if score @s gd_seat = #turn gd_ctx run scoreboard players operation #next_order gd_ctx = @s gd_order
scoreboard players set #next gd_ctx -1
function guandan:game/next_candidate
function guandan:game/next_candidate
function guandan:game/next_candidate
function guandan:game/next_candidate
execute if score #next gd_ctx matches 1..8 run scoreboard players operation @s gd_turn = #next gd_ctx
function guandan:clock/reset
function guandan:visual/refresh
''')
    put('game/next_candidate','''
execute if score #next gd_ctx matches 1..8 run return 0
scoreboard players add #next_order gd_ctx 3
scoreboard players operation #next_order gd_ctx %= #four gd_ctx
execute as @e[tag=gd.board,scores={gd_rank=0}] if score @s gd_order = #next_order gd_ctx run scoreboard players operation #next gd_ctx = @s gd_seat
''')
    put('game/new_trick','''
scoreboard players operation #leader gd_ctx = @s gd_lastseat
scoreboard players operation @s gd_turn = #leader gd_ctx
scoreboard players set #finished gd_ctx 0
execute as @e[tag=gd.board,scores={gd_rank=1..4}] if score @s gd_seat = #leader gd_ctx run function guandan:game/borrow_wind
scoreboard players set @s gd_lastkind 0
scoreboard players set @s gd_lastseat -1
scoreboard players set @s gd_passes 0
scoreboard players set @e[tag=gd.cards] gd_used 0
execute as @e[tag=gd.board] run data modify entity @s data.last_play set value []
execute as @e[tag=gd.board] run data modify entity @s data.last_label set value ""
function guandan:visual/collect
function guandan:game/bump_epoch
function guandan:clock/reset
function guandan:hud/refresh
function guandan:ui/refresh
scoreboard players set #ok gd_ctx 1
''')
    put('game/borrow_wind','''
scoreboard players operation #wind_team gd_ctx = @s gd_team
execute as @e[tag=gd.board,scores={gd_rank=0}] if score @s gd_team = #wind_team gd_ctx run scoreboard players operation @e[tag=gd.current,limit=1] gd_turn = @s gd_seat
tellraw @a[tag=gd.audience] {text:"[掼蛋] 对家接风，重新领出。",color:"aqua"}
''')
    put('clock/reset','''
scoreboard players operation @s gd_clock = @s gd_limit
scoreboard players set #twenty gd_ctx 20
scoreboard players operation @s gd_clock *= #twenty gd_ctx
''')
    put('clock/tick','''
execute if score @s gd_anim matches 1.. run return run function guandan:clock/animation
execute if score @s gd_limit matches 0 run return 0
execute if score @s gd_clock matches 1.. run scoreboard players remove @s gd_clock 1
execute if score @s gd_clock matches 0 run function guandan:clock/timeout
''')
    put('clock/animation','scoreboard players remove @s gd_anim 1')
    put('clock/timeout','''
function guandan:system/context
execute if score @s gd_state matches 2 run return run function guandan:tribute/auto
scoreboard players operation #actor gd_ctx = @s gd_turn
execute unless score @s gd_lastkind matches 0 run return run function guandan:game/pass
scoreboard players set @e[tag=gd.cards] gd_sel 0
scoreboard players set #low gd_ctx 99
execute as @e[tag=gd.cards] if score @s gd_owner = #actor gd_ctx run scoreboard players operation #low gd_ctx < @s gd_strength
tag @e[tag=gd.auto] remove gd.auto
execute as @e[tag=gd.cards] if score @s gd_owner = #actor gd_ctx if score @s gd_strength = #low gd_ctx run tag @s add gd.auto
scoreboard players set @e[tag=gd.auto,limit=1] gd_sel 1
function guandan:game/play
tag @e[tag=gd.auto] remove gd.auto
''')
    put('game/maintenance','''
scoreboard players set @s gd_tick 0
function guandan:system/context
scoreboard players set #online gd_ctx 0
execute as @a[tag=gd.audience] run scoreboard players add #online gd_ctx 1
execute unless score #online gd_ctx matches 4 run return run function guandan:game/player_left
function guandan:hud/refresh
''')
    build_tribute()
    build_round()
    put('game/abort','''
execute unless entity @s[tag=gd.controller] run return 0
function guandan:system/context
tellraw @a[tag=gd.audience] {text:"[掼蛋] 本场已中止。",color:"yellow"}
function guandan:game/cleanup
''')
    put('game/end_vote','function guandan:game/abort')
    put('game/player_left','''
function guandan:system/context
tellraw @a[tag=gd.audience] {text:"[掼蛋] 有参与者离开牌桌，本场中止。",color:"yellow"}
function guandan:game/cleanup
''')
    put('game/finish','function guandan:game/cleanup')
    put('game/cleanup','''
scoreboard players set @s gd_state 0
function guandan:game/clear
function cardtable:game/return_lobby
function guandan:game/init_table
''')
    put('game/clear','''
function guandan:system/context
scoreboard players set @s gd_state 0
scoreboard players set @s gd_phase 0
scoreboard players set @s gd_timer 0
scoreboard players set @s gd_anim 0
scoreboard players set @s gd_clock 0
function guandan:game/bump_epoch
function guandan:visual/clear
function cardtable:animation/deal/clear
execute as @a[tag=gd.player] if score @s gd_table = #table gd_ctx run function guandan:player/clear_state
execute as @e[type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{guandan:{tool:1b}}] run function guandan:player/kill_drop
execute as @e[type=minecraft:firework_rocket,tag=gd.firework] if score @s ct_id = #table gd_ctx run kill @s
kill @e[tag=gd.cards]
kill @e[tag=gd.board]
data remove entity @s data.guandan
tag @s remove gd.controller
tag @s remove gd.current
''')
    put('game/remove','function guandan:game/clear')
    put('player/kill_drop','''
execute store result score #drop_table gd_ctx run data get entity @s Item.components."minecraft:custom_data".guandan.table
execute if score #drop_table gd_ctx = #table gd_ctx run kill @s
''')
    put('player/clear_state','''
function guandan:hud/deactivate
function guandan:input/clear
function guandan:settings/clear_session
clear @s *[minecraft:custom_data~{guandan:{tool:1b}}]
execute if entity @s[tag=gd.player] run dialog clear @s
tag @s remove gd.player
tag @s remove gd.audience
tag @s remove gd.actor
scoreboard players reset @s gd_table
scoreboard players reset @s gd_seat
scoreboard players reset @s gd_team
scoreboard players reset @s gd_order
scoreboard players reset @s gd_action
scoreboard players set @s gd_drop 0
''')
    put('admin/abort','''
execute unless entity @s[type=minecraft:player] run return fail
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=gd.controller,scores={ct_game=18,ct_state=1},distance=..8,sort=nearest,limit=1] run tellraw @s {text:"[掼蛋] 同维度8格内没有进行中的掼蛋。",color:"red"}
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=gd.controller,scores={ct_game=18,ct_state=1},distance=..8,sort=nearest,limit=1] run return fail
execute as @e[type=minecraft:marker,tag=ct.controller,tag=gd.controller,scores={ct_game=18,ct_state=1},distance=..8,sort=nearest,limit=1] at @s run function guandan:game/abort
''')
    put('log','$tellraw @a[tag=ct.debug] [{text:"[掼蛋] ",color:"gold"},{text:"$(text)",color:"gray"}]')
    print('Generated Guandan18 lifecycle, deck, tribute and match progression.')


def build_tribute():
    put('tribute/begin','''
function guandan:system/context
execute if score @s gd_round matches 1 run return run function guandan:game/first_turn
scoreboard players set @s gd_state 2
scoreboard players set @s gd_phase 1
scoreboard players set @s gd_tribn 1
scoreboard players set #headteam gd_ctx -1
execute as @e[tag=gd.board,scores={gd_prevrank=1}] run scoreboard players operation #headteam gd_ctx = @s gd_team
execute as @e[tag=gd.board,scores={gd_prevrank=1}] run scoreboard players operation @e[tag=gd.current,limit=1] gd_first = @s gd_seat
execute as @e[tag=gd.board,scores={gd_prevrank=2}] if score @s gd_team = #headteam gd_ctx run scoreboard players set @e[tag=gd.current,limit=1] gd_tribn 2
scoreboard players set @e[tag=gd.board,scores={gd_prevrank=4}] gd_tribute 1
execute if score @s gd_tribn matches 2 run scoreboard players set @e[tag=gd.board,scores={gd_prevrank=3}] gd_tribute 1
scoreboard players set #bigjokers gd_ctx 0
execute as @e[tag=gd.board,scores={gd_tribute=1}] run function guandan:tribute/count_jokers
execute if score #bigjokers gd_ctx matches 2 run return run function guandan:tribute/resist
function guandan:game/bump_epoch
function guandan:clock/reset
tellraw @a[tag=gd.audience] {text:"[掼蛋] 进入贡牌阶段，请进贡手中最大的牌（红桃级牌除外）。",color:"gold"}
function guandan:visual/refresh
function guandan:hud/refresh
function guandan:ui/refresh
''')
    put('tribute/count_jokers','''
scoreboard players operation #donor gd_ctx = @s gd_seat
execute as @e[tag=gd.cards,scores={gd_type=53}] if score @s gd_owner = #donor gd_ctx run scoreboard players add #bigjokers gd_ctx 1
''')
    put('tribute/resist','''
scoreboard players set @e[tag=gd.board] gd_tribute 0
tellraw @a[tag=gd.audience] {text:"[掼蛋] 进贡方持有两个大王，抗贡；由上游领出。",color:"aqua"}
function guandan:game/first_turn
''')
    put('tribute/submit','''
scoreboard players set #ok gd_ctx 0
execute unless score @s gd_state matches 2 run return 0
execute if score @s gd_anim matches 1.. run return 0
function guandan:system/context
tag @e[tag=gd.chooser] remove gd.chooser
execute as @e[tag=gd.board] if score @s gd_seat = #actor gd_ctx run tag @s add gd.chooser
execute unless entity @e[tag=gd.chooser,limit=1] run return 0
tag @e[tag=gd.pick] remove gd.pick
execute as @e[tag=gd.cards] if score @s gd_owner = #actor gd_ctx if score @s gd_id = #card gd_ctx run tag @s add gd.pick
execute unless entity @e[tag=gd.pick,limit=1] run return 0
execute if score @s gd_phase matches 1 run function guandan:tribute/choose_gift
execute if score @s gd_phase matches 2 run function guandan:tribute/choose_return
''')
    put('tribute/choose_gift','''
execute unless entity @e[tag=gd.chooser,scores={gd_tribute=1},limit=1] run return 0
execute if entity @e[tag=gd.pick,scores={gd_wild=1},limit=1] run return 0
scoreboard players set #max gd_ctx -1
execute as @e[tag=gd.cards,scores={gd_wild=0}] if score @s gd_owner = #actor gd_ctx run scoreboard players operation #max gd_ctx > @s gd_strength
execute unless score @e[tag=gd.pick,limit=1] gd_strength = #max gd_ctx run return 0
scoreboard players operation @e[tag=gd.chooser,limit=1] gd_giftid = #card gd_ctx
scoreboard players set @e[tag=gd.chooser,limit=1] gd_tribute 2
function guandan:game/bump_epoch
execute unless entity @e[tag=gd.board,scores={gd_tribute=1}] run function guandan:tribute/gifts_ready
function guandan:hud/refresh
function guandan:ui/refresh
scoreboard players set #ok gd_ctx 1
''')
    put('tribute/gifts_ready','''
scoreboard players operation #head gd_ctx = @e[tag=gd.board,scores={gd_prevrank=1},limit=1] gd_seat
scoreboard players operation #headorder gd_ctx = @e[tag=gd.board,scores={gd_prevrank=1},limit=1] gd_order
scoreboard players operation #second gd_ctx = @e[tag=gd.board,scores={gd_prevrank=2},limit=1] gd_seat
execute as @e[tag=gd.board,scores={gd_tribute=2}] run function guandan:tribute/gift_strength
scoreboard players set #high_gift gd_ctx -1
execute as @e[tag=gd.board,scores={gd_tribute=2}] run scoreboard players operation #high_gift gd_ctx > @s gd_strength
scoreboard players set #lead gd_ctx -1
execute as @e[tag=gd.board,scores={gd_tribute=2}] if score @s gd_strength = #high_gift gd_ctx run scoreboard players operation #lead gd_ctx = @s gd_seat
# 同大时，上游的顺时针邻座进贡给上游；此处方位0..3按顺时针排列。
scoreboard players operation #clockwise gd_ctx = #headorder gd_ctx
scoreboard players add #clockwise gd_ctx 1
scoreboard players operation #clockwise gd_ctx %= #four gd_ctx
execute as @e[tag=gd.board,scores={gd_tribute=2}] if score @s gd_strength = #high_gift gd_ctx if score @s gd_order = #clockwise gd_ctx run scoreboard players operation #lead gd_ctx = @s gd_seat
scoreboard players operation @s gd_first = #lead gd_ctx
execute as @e[tag=gd.board,scores={gd_tribute=2}] run function guandan:tribute/assign_peer
data modify entity @s data.guandan.exchange set value []
execute as @e[tag=gd.board,scores={gd_tribute=2}] run function guandan:tribute/give_gift
function guandan:deck/recount
scoreboard players set @s gd_phase 2
function guandan:clock/reset
function guandan:visual/tribute
function guandan:sound/tribute
tellraw @a[tag=gd.audience] {text:"[掼蛋] 请接贡者选择一张点数不超过10的牌还回；若全手牌均大于10，须还最小牌。",color:"gold"}
''')
    put('tribute/gift_strength','''
scoreboard players operation #gift gd_ctx = @s gd_giftid
execute as @e[tag=gd.cards] if score @s gd_id = #gift gd_ctx run scoreboard players operation #value gd_ctx = @s gd_strength
scoreboard players operation @s gd_strength = #value gd_ctx
''')
    put('tribute/assign_peer','''
scoreboard players operation @s gd_peer = #second gd_ctx
execute if score @s gd_seat = #lead gd_ctx run scoreboard players operation @s gd_peer = #head gd_ctx
scoreboard players operation #donor gd_ctx = @s gd_seat
scoreboard players operation #receiver gd_ctx = @s gd_peer
execute as @e[tag=gd.board] if score @s gd_seat = #receiver gd_ctx run scoreboard players operation @s gd_peer = #donor gd_ctx
execute as @e[tag=gd.board] if score @s gd_seat = #receiver gd_ctx run scoreboard players set @s gd_return 1
''')
    put('tribute/give_gift','''
scoreboard players operation #gift gd_ctx = @s gd_giftid
scoreboard players operation #from gd_ctx = @s gd_seat
scoreboard players operation #to gd_ctx = @s gd_peer
execute as @e[tag=gd.cards] if score @s gd_id = #gift gd_ctx run function guandan:tribute/transfer
''')
    put('tribute/transfer','''
scoreboard players operation @s gd_owner = #to gd_ctx
scoreboard players set @s gd_sel 0
data modify storage guandan:runtime transfer set value {}
execute store result storage guandan:runtime transfer.from int 1 run scoreboard players get #from gd_ctx
execute store result storage guandan:runtime transfer.to int 1 run scoreboard players get #to gd_ctx
execute store result storage guandan:runtime transfer.type int 1 run scoreboard players get @s gd_type
execute store result storage guandan:runtime transfer.id int 1 run scoreboard players get @s gd_id
data modify entity @e[tag=gd.current,limit=1] data.guandan.exchange append from storage guandan:runtime transfer
''')
    put('tribute/choose_return','''
execute unless entity @e[tag=gd.chooser,scores={gd_return=1},limit=1] run return 0
scoreboard players set #small gd_ctx 0
scoreboard players set #min gd_ctx 99
execute as @e[tag=gd.cards] if score @s gd_owner = #actor gd_ctx if score @s gd_point matches 2..10 run scoreboard players set #small gd_ctx 1
execute as @e[tag=gd.cards] if score @s gd_owner = #actor gd_ctx run scoreboard players operation #min gd_ctx < @s gd_strength
execute if score #small gd_ctx matches 1 unless score @e[tag=gd.pick,limit=1] gd_point matches 2..10 run return 0
execute if score #small gd_ctx matches 0 unless score @e[tag=gd.pick,limit=1] gd_strength = #min gd_ctx run return 0
scoreboard players operation @e[tag=gd.chooser,limit=1] gd_returnid = #card gd_ctx
scoreboard players set @e[tag=gd.chooser,limit=1] gd_return 2
function guandan:game/bump_epoch
execute unless entity @e[tag=gd.board,scores={gd_return=1}] run function guandan:tribute/returns_ready
function guandan:hud/refresh
function guandan:ui/refresh
scoreboard players set #ok gd_ctx 1
''')
    put('tribute/returns_ready','''
data modify entity @s data.guandan.exchange set value []
execute as @e[tag=gd.board,scores={gd_return=2}] run function guandan:tribute/give_return
function guandan:deck/recount
function guandan:visual/tribute
function guandan:sound/tribute
scoreboard players set @e[tag=gd.board] gd_tribute 0
scoreboard players set @e[tag=gd.board] gd_return 0
scoreboard players set @s gd_anim 8
function guandan:game/first_turn
''')
    put('tribute/give_return','''
scoreboard players operation #gift gd_ctx = @s gd_returnid
scoreboard players operation #from gd_ctx = @s gd_seat
scoreboard players operation #to gd_ctx = @s gd_peer
execute as @e[tag=gd.cards] if score @s gd_id = #gift gd_ctx run function guandan:tribute/transfer
''')
    put('deck/recount','execute as @e[tag=gd.board] run function guandan:deck/count_part')
    put('deck/count_part','''
scoreboard players operation #count_seat gd_ctx = @s gd_seat
scoreboard players set #owned gd_ctx 0
execute as @e[tag=gd.cards] if score @s gd_owner = #count_seat gd_ctx run scoreboard players add #owned gd_ctx 1
scoreboard players operation @s gd_count = #owned gd_ctx
''')
    put('tribute/auto','''
scoreboard players set #actor gd_ctx -1
execute if score @s gd_phase matches 1 run scoreboard players operation #actor gd_ctx = @e[tag=gd.board,scores={gd_tribute=1},limit=1] gd_seat
execute if score @s gd_phase matches 2 run scoreboard players operation #actor gd_ctx = @e[tag=gd.board,scores={gd_return=1},limit=1] gd_seat
execute unless score #actor gd_ctx matches 1..8 run return 0
tag @e[tag=gd.auto] remove gd.auto
scoreboard players set #max gd_ctx -1
scoreboard players set #min gd_ctx 99
scoreboard players set #small gd_ctx 0
execute as @e[tag=gd.cards,scores={gd_wild=0}] if score @s gd_owner = #actor gd_ctx run scoreboard players operation #max gd_ctx > @s gd_strength
execute as @e[tag=gd.cards] if score @s gd_owner = #actor gd_ctx run scoreboard players operation #min gd_ctx < @s gd_strength
execute as @e[tag=gd.cards,scores={gd_point=2..10}] if score @s gd_owner = #actor gd_ctx run scoreboard players set #small gd_ctx 1
execute if score @s gd_phase matches 1 as @e[tag=gd.cards,scores={gd_wild=0}] if score @s gd_owner = #actor gd_ctx if score @s gd_strength = #max gd_ctx run tag @s add gd.auto
execute if score @s gd_phase matches 2 if score #small gd_ctx matches 0 as @e[tag=gd.cards] if score @s gd_owner = #actor gd_ctx if score @s gd_strength = #min gd_ctx run tag @s add gd.auto
# 还牌优先点数<=10；低点级牌虽强，仍属于合法还牌。
execute if score @s gd_phase matches 2 as @e[tag=gd.cards,scores={gd_point=2..10}] if score @s gd_owner = #actor gd_ctx run tag @s add gd.auto
scoreboard players operation #card gd_ctx = @e[tag=gd.auto,limit=1] gd_id
function guandan:tribute/submit
function guandan:clock/reset
tag @e[tag=gd.auto] remove gd.auto
''')


def build_round():
    put('round/check_end','''
execute unless score @s gd_state matches 3 run return 0
scoreboard players set #firstteam gd_ctx -1
execute as @e[tag=gd.board,scores={gd_rank=1}] run scoreboard players operation #firstteam gd_ctx = @s gd_team
scoreboard players set #double gd_ctx 0
execute as @e[tag=gd.board,scores={gd_rank=2}] if score @s gd_team = #firstteam gd_ctx run scoreboard players set #double gd_ctx 1
execute if score #double gd_ctx matches 1 run return run function guandan:round/over
execute if score @s gd_done matches 3.. run function guandan:round/over
''')
    put('round/over','''
execute unless score @s gd_state matches 3 run return 0
execute if score @s gd_scored matches 1 run return 0
function guandan:system/context
scoreboard players set @s gd_scored 1
scoreboard players set @s gd_state 4
scoreboard players set @s gd_timer 120
scoreboard players set @s gd_anim 0
scoreboard players set @s gd_clock 0
scoreboard players operation #rank gd_ctx = @s gd_done
execute as @e[tag=gd.board,scores={gd_rank=0}] run function guandan:round/assign_remaining
scoreboard players operation #winner gd_ctx = @e[tag=gd.board,scores={gd_rank=1},limit=1] gd_team
scoreboard players operation @s gd_winner = #winner gd_ctx
scoreboard players set #partner_rank gd_ctx 4
execute as @e[tag=gd.board,scores={gd_rank=2..4}] if score @s gd_team = #winner gd_ctx run scoreboard players operation #partner_rank gd_ctx = @s gd_rank
scoreboard players set @s gd_steps 5
scoreboard players operation @s gd_steps -= #partner_rank gd_ctx
scoreboard players set #oldlevel gd_ctx 2
execute if score #winner gd_ctx matches 0 run scoreboard players operation #oldlevel gd_ctx = @s gd_team0
execute if score #winner gd_ctx matches 1 run scoreboard players operation #oldlevel gd_ctx = @s gd_team1
scoreboard players set @s gd_matchwin -1
execute if score #oldlevel gd_ctx matches 14 if score @s gd_level matches 14 if score #partner_rank gd_ctx matches 2..3 run scoreboard players operation @s gd_matchwin = #winner gd_ctx
# A必打；未过A最多停在A，下一副继续打A，不做三次退2。
scoreboard players operation #newlevel gd_ctx = #oldlevel gd_ctx
scoreboard players operation #newlevel gd_ctx += @s gd_steps
execute if score #newlevel gd_ctx matches 15.. run scoreboard players set #newlevel gd_ctx 14
execute if score #winner gd_ctx matches 0 run scoreboard players operation @s gd_team0 = #newlevel gd_ctx
execute if score #winner gd_ctx matches 1 run scoreboard players operation @s gd_team1 = #newlevel gd_ctx
execute as @e[tag=gd.board] if score @s gd_team = #winner gd_ctx run scoreboard players operation @s gd_points += @e[tag=gd.current,limit=1] gd_steps
execute as @e[tag=gd.board] run scoreboard players operation @s gd_prevrank = @s gd_rank
scoreboard players operation @s gd_playteam = #winner gd_ctx
scoreboard players operation @s gd_level = #newlevel gd_ctx
function guandan:game/bump_epoch
tellraw @a[tag=gd.audience] [{text:"[掼蛋] 本副结束，第",color:"gold"},{score:{name:"@s",objective:"gd_winner"}},{text:"队升 "},{score:{name:"@s",objective:"gd_steps"}},{text:" 级；双方级数 "},{score:{name:"@s",objective:"gd_team0"}},{text:" / "},{score:{name:"@s",objective:"gd_team1"}},{text:"。"}]
function guandan:visual/upgrade
function guandan:sound/round_win
execute if score @s gd_matchwin matches 0..1 run function guandan:round/match_over
execute if score @s gd_mode matches 1 if score @s gd_round >= @s gd_rounds run function guandan:round/fixed_over
function guandan:visual/refresh
function guandan:hud/refresh
function guandan:ui/refresh
''')
    put('round/assign_remaining','scoreboard players add #rank gd_ctx 1\nscoreboard players operation @s gd_rank = #rank gd_ctx')
    put('round/fixed_over','''
execute if score @s gd_state matches 5 run return 0
scoreboard players set @s gd_matchwin 2
execute if score @s gd_team0 > @s gd_team1 run scoreboard players set @s gd_matchwin 0
execute if score @s gd_team1 > @s gd_team0 run scoreboard players set @s gd_matchwin 1
function guandan:round/match_over
''')
    put('round/match_over','''
execute if score @s gd_state matches 5 run return 0
scoreboard players set @s gd_state 5
scoreboard players set @s gd_timer 120
scoreboard players operation #match gd_ctx = @s gd_matchwin
execute if score #match gd_ctx matches 2 run tellraw @a[tag=gd.audience] {text:"[掼蛋] 固定副数结束，双方级数相同，本场平局。",color:"gold"}
execute if score #match gd_ctx matches 0..1 run tellraw @a[tag=gd.audience] [{text:"[掼蛋] 本场胜者：第",color:"gold"},{score:{name:"@s",objective:"gd_matchwin"}},{text:"队！"}]
execute as @e[tag=gd.board] if score @s gd_team = #match gd_ctx run function guandan:round/winner
function guandan:sound/end
function guandan:log {text:"掼蛋整场结束，锁定结算并等待返回大厅"}
''')
    put('round/winner','''
scoreboard players operation #winseat gd_ctx = @s gd_seat
execute as @a[tag=gd.audience] if score @s gd_seat = #winseat gd_ctx at @s run function guandan:round/firework
''')
    put('round/firework','''
tag @e[type=minecraft:firework_rocket,tag=gd.firework.new] remove gd.firework.new
execute positioned ~ ~1 ~ run function fimel_sklibs:skfirework/fx/firework {config:{life:20,shape:1,colors:{from:[I;16766720,14442467,16777215],to:[I;16777215]},n:1,trail:true,twinkle:true,tags:["gd.firework","gd.firework.new"]}}
scoreboard players operation @e[type=minecraft:firework_rocket,tag=gd.firework.new] ct_id = #table gd_ctx
tag @e[type=minecraft:firework_rocket,tag=gd.firework.new] remove gd.firework.new
''')
    put('round/result_tick','''
scoreboard players remove @s gd_timer 1
execute if score @s gd_timer matches 1.. run return 0
execute if score @s gd_state matches 5 run return run function guandan:game/cleanup
function guandan:round/begin
''')


def apply_test_bots():
    overrides = {'load': 'scoreboard objectives add gd_action trigger\nscoreboard objectives add gd_actor dummy\nscoreboard objectives add gd_anim dummy\nscoreboard objectives add gd_clock dummy\nscoreboard objectives add gd_count dummy\nscoreboard objectives add gd_ctx dummy\nscoreboard objectives add gd_dealorder dummy\nscoreboard objectives add gd_dealt dummy\nscoreboard objectives add gd_done dummy\nscoreboard objectives add gd_drop minecraft.dropped:minecraft.purple_dye\nscoreboard objectives add gd_epoch dummy\nscoreboard objectives add gd_first dummy\nscoreboard objectives add gd_firstorder dummy\nscoreboard objectives add gd_giftid dummy\nscoreboard objectives add gd_high dummy\nscoreboard objectives add gd_hud dummy\nscoreboard objectives add gd_hud_key dummy\nscoreboard objectives add gd_id dummy\nscoreboard objectives add gd_kind dummy\nscoreboard objectives add gd_lasthi dummy\nscoreboard objectives add gd_lastkind dummy\nscoreboard objectives add gd_lastpow dummy\nscoreboard objectives add gd_lastseat dummy\nscoreboard objectives add gd_lastsize dummy\nscoreboard objectives add gd_level dummy\nscoreboard objectives add gd_limit dummy\nscoreboard objectives add gd_matchwin dummy\nscoreboard objectives add gd_mode dummy\nscoreboard objectives add gd_order dummy\nscoreboard objectives add gd_owner dummy\nscoreboard objectives add gd_pair dummy\nscoreboard objectives add gd_panel dummy\nscoreboard objectives add gd_passes dummy\nscoreboard objectives add gd_peer dummy\nscoreboard objectives add gd_phase dummy\nscoreboard objectives add gd_playteam dummy\nscoreboard objectives add gd_point dummy\nscoreboard objectives add gd_points dummy\nscoreboard objectives add gd_power dummy\nscoreboard objectives add gd_prev_panel dummy\nscoreboard objectives add gd_prevrank dummy\nscoreboard objectives add gd_rank dummy\nscoreboard objectives add gd_return dummy\nscoreboard objectives add gd_returnid dummy\nscoreboard objectives add gd_round dummy\nscoreboard objectives add gd_rounds dummy\nscoreboard objectives add gd_scored dummy\nscoreboard objectives add gd_seat dummy\nscoreboard objectives add gd_seen dummy\nscoreboard objectives add gd_sel dummy\nscoreboard objectives add gd_setinput dummy\nscoreboard objectives add gd_setload dummy\nscoreboard objectives add gd_setnonce dummy\nscoreboard objectives add gd_settable dummy\nscoreboard objectives add gd_settings trigger\nscoreboard objectives add gd_show dummy\nscoreboard objectives add gd_size dummy\nscoreboard objectives add gd_startlevel dummy\nscoreboard objectives add gd_state dummy\nscoreboard objectives add gd_steps dummy\nscoreboard objectives add gd_strength dummy\nscoreboard objectives add gd_suit dummy\nscoreboard objectives add gd_table dummy\nscoreboard objectives add gd_team dummy\nscoreboard objectives add gd_team0 dummy\nscoreboard objectives add gd_team1 dummy\nscoreboard objectives add gd_tick dummy\nscoreboard objectives add gd_timer dummy\nscoreboard objectives add gd_tribn dummy\nscoreboard objectives add gd_tribute dummy\nscoreboard objectives add gd_turn dummy\nscoreboard objectives add gd_type dummy\nscoreboard objectives add gd_ui_key dummy\nscoreboard objectives add gd_ui_load dummy\nscoreboard objectives add gd_ui_tmp dummy\nscoreboard objectives add gd_uiepoch dummy\nscoreboard objectives add gd_used dummy\nscoreboard objectives add gd_wild dummy\nscoreboard objectives add gd_winner dummy\nexecute unless score #version gd_ctx matches 1.. run scoreboard players set #version gd_ctx 1\nexecute unless score #epoch_serial gd_ctx matches 10000..999999 run scoreboard players set #epoch_serial gd_ctx 10000\nscoreboard players set #four gd_ctx 4\nscoreboard players set #fiftyfour gd_ctx 54\nfunction guandan:cards/constants\nscoreboard players add #ui_load gd_ctx 1\nscoreboard players reset * gd_action\nscoreboard players reset * gd_settings\nfunction guandan:visual/load\nexecute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=18}] at @s run function guandan:system/reload\n\nscoreboard objectives add gd_humans dummy\nscoreboard objectives add gd_botclock dummy\nscoreboard objectives add gd_botepoch dummy\nscoreboard objectives add gd_best dummy\nscoreboard objectives add gd_bestchoice dummy\nscoreboard objectives add gd_botpick dummy\n', 'game/start': 'scoreboard players set @s ct_start 0\nexecute if score @s ct_state matches 1 run return fail\nexecute unless score @s ct_joined matches 1..4 run return run function guandan:game/bad_count\nexecute unless score @s ct_capacity matches 4 unless score @s ct_capacity matches 8 run return fail\nscoreboard players operation #table gd_ctx = @s ct_id\nscoreboard players set #online gd_ctx 0\nscoreboard players set #occupied gd_ctx 0\ntag @a[tag=gd.start] remove gd.start\nexecute as @a[tag=ct.player] if score @s ct_id = #table gd_ctx run tag @s add gd.start\nexecute as @a[tag=gd.start] run scoreboard players add #online gd_ctx 1\nexecute unless score #online gd_ctx matches 1..4 run return run function guandan:game/bad_count\nexecute as @a[tag=gd.start] if items entity @s hotbar.0 * run scoreboard players set #occupied gd_ctx 1\nexecute as @a[tag=gd.start] if items entity @s hotbar.8 * run scoreboard players set #occupied gd_ctx 1\nexecute if score #occupied gd_ctx matches 1 run return run function guandan:game/bad_slots\nfunction guandan:game/init_table\nexecute if score @s gd_pair matches 0 run function guandan:game/check_sides\nexecute if score @s gd_pair matches 0 unless score #sides_ok gd_ctx matches 1 run return run function guandan:game/bad_sides\nfunction guandan:game/clear\ntag @s add gd.controller\nfunction guandan:system/context\nexecute if score @s gd_pair matches 1 run function guandan:game/random_sides\nexecute as @a[tag=gd.start] run function guandan:player/join\ntag @a[tag=gd.start] remove gd.start\nfunction guandan:system/context\nscoreboard players set @s gd_humans 0\nexecute as @a[tag=gd.audience] run scoreboard players add @e[tag=gd.current,limit=1] gd_humans 1\nfunction guandan:bot/fill\nscoreboard players set @s gd_round 0\nscoreboard players operation @s gd_team0 = @s gd_startlevel\nscoreboard players operation @s gd_team1 = @s gd_startlevel\nscoreboard players operation @s gd_level = @s gd_startlevel\nscoreboard players set @s gd_playteam -1\nscoreboard players set @s gd_tick 0\nscoreboard players set @s gd_winner -1\nscoreboard players set @s gd_matchwin -1\nscoreboard players set @s ct_start 1\nfunction guandan:round/begin\nfunction guandan:log {text:"掼蛋开局：真人与测试人机共四人、108张牌、对家搭档"}\n', 'game/bad_count': 'scoreboard players operation #table gd_ctx = @s ct_id\nexecute as @a[tag=ct.player] if score @s ct_id = #table gd_ctx run tellraw @s {text:"[掼蛋] 需要1～4名真人，不足4人自动补测试人机。",color:"yellow"}\nreturn fail\n', 'game/bad_sides': 'tellraw @a[tag=gd.start] {text:"[掼蛋] 自选搭档时，四个方向须各坐一人；相对而坐的玩家为队友。也可切换随机搭档。",color:"yellow"}\nreturn fail\n', 'game/check_sides': 'scoreboard players operation #cap gd_ctx = @s ct_capacity\nscoreboard players set #two gd_ctx 2\nscoreboard players set #sides_ok gd_ctx 1\nexecute as @a[tag=gd.start] run function guandan:player/side\nscoreboard players set #side0 gd_ctx 0\nscoreboard players set #side1 gd_ctx 0\nscoreboard players set #side2 gd_ctx 0\nscoreboard players set #side3 gd_ctx 0\nexecute as @a[tag=gd.start,scores={gd_order=0}] run scoreboard players add #side0 gd_ctx 1\nexecute as @a[tag=gd.start,scores={gd_order=1}] run scoreboard players add #side1 gd_ctx 1\nexecute as @a[tag=gd.start,scores={gd_order=2}] run scoreboard players add #side2 gd_ctx 1\nexecute as @a[tag=gd.start,scores={gd_order=3}] run scoreboard players add #side3 gd_ctx 1\nexecute if score #side0 gd_ctx matches 2.. run scoreboard players set #sides_ok gd_ctx 0\nexecute if score #side1 gd_ctx matches 2.. run scoreboard players set #sides_ok gd_ctx 0\nexecute if score #side2 gd_ctx matches 2.. run scoreboard players set #sides_ok gd_ctx 0\nexecute if score #side3 gd_ctx matches 2.. run scoreboard players set #sides_ok gd_ctx 0\n', 'game/maintenance': 'scoreboard players set @s gd_tick 0\nfunction guandan:system/context\nscoreboard players set #online gd_ctx 0\nexecute as @a[tag=gd.audience] run scoreboard players add #online gd_ctx 1\nexecute unless score @s gd_humans matches 1..4 run scoreboard players set @s gd_humans 4\nexecute unless score #online gd_ctx = @s gd_humans run return run function guandan:game/player_left\nfunction guandan:hud/refresh\n', 'game/tick': 'execute if score @s gd_state matches 1 run function guandan:deal/tick\nexecute if score @s gd_state matches 2..3 run function guandan:clock/tick\nexecute if score @s gd_state matches 4..5 run function guandan:round/result_tick\nscoreboard players add @s gd_tick 1\nexecute if score @s gd_tick matches 20.. run function guandan:game/maintenance\n\nexecute if score @s gd_state matches 2..3 if score @s gd_anim matches 0 run function guandan:bot/tick\n', 'clock/tick': 'execute if score @s gd_anim matches 1.. run return run function guandan:clock/animation\nfunction guandan:system/context\nscoreboard players operation #actor gd_ctx = @s gd_turn\nscoreboard players set #clock_bot gd_ctx 0\nexecute if score @s gd_state matches 3 as @e[tag=gd.board,tag=gd.bot] if score @s gd_seat = #actor gd_ctx run scoreboard players set #clock_bot gd_ctx 1\nexecute if score #clock_bot gd_ctx matches 1 run return 0\nexecute if score @s gd_limit matches 0 run return 0\nexecute if score @s gd_clock matches 1.. run scoreboard players remove @s gd_clock 1\nexecute if score @s gd_clock matches 0 run function guandan:clock/timeout\n', 'bot/add': '$scoreboard players set #join_order gd_ctx $(order)\nscoreboard players operation #join_seat gd_ctx = #join_order gd_ctx\nexecute if score @s ct_capacity matches 8 run scoreboard players operation #join_seat gd_ctx *= #two gd_ctx\nscoreboard players add #join_seat gd_ctx 1\nscoreboard players operation #join_team gd_ctx = #join_order gd_ctx\nscoreboard players operation #join_team gd_ctx %= #two gd_ctx\n$data modify storage guandan:name resolved set value {text:"测试人机$(number)"}\nexecute at @s summon minecraft:marker run function guandan:bot/part\n', 'bot/begin': 'scoreboard players operation @s gd_botepoch = @s gd_epoch\nscoreboard players set @s gd_botclock 0\nscoreboard players set @s gd_best -1000000\nscoreboard players set @e[tag=gd.cards] gd_botpick 0\ndata modify entity @s data.guandan.bot.todo set value [{"ranks":[2]},{"ranks":[2,2]},{"ranks":[2,2,2]},{"ranks":[2,2,2,2]},{"ranks":[2,2,2,2,2]},{"ranks":[2,2,2,2,2,2]},{"ranks":[2,2,2,2,2,2,2]},{"ranks":[2,2,2,2,2,2,2,2]},{"ranks":[3]},{"ranks":[3,3]},{"ranks":[3,3,3]},{"ranks":[3,3,3,3]},{"ranks":[3,3,3,3,3]},{"ranks":[3,3,3,3,3,3]},{"ranks":[3,3,3,3,3,3,3]},{"ranks":[3,3,3,3,3,3,3,3]},{"ranks":[4]},{"ranks":[4,4]},{"ranks":[4,4,4]},{"ranks":[4,4,4,4]},{"ranks":[4,4,4,4,4]},{"ranks":[4,4,4,4,4,4]},{"ranks":[4,4,4,4,4,4,4]},{"ranks":[4,4,4,4,4,4,4,4]},{"ranks":[5]},{"ranks":[5,5]},{"ranks":[5,5,5]},{"ranks":[5,5,5,5]},{"ranks":[5,5,5,5,5]},{"ranks":[5,5,5,5,5,5]},{"ranks":[5,5,5,5,5,5,5]},{"ranks":[5,5,5,5,5,5,5,5]},{"ranks":[6]},{"ranks":[6,6]},{"ranks":[6,6,6]},{"ranks":[6,6,6,6]},{"ranks":[6,6,6,6,6]},{"ranks":[6,6,6,6,6,6]},{"ranks":[6,6,6,6,6,6,6]},{"ranks":[6,6,6,6,6,6,6,6]},{"ranks":[7]},{"ranks":[7,7]},{"ranks":[7,7,7]},{"ranks":[7,7,7,7]},{"ranks":[7,7,7,7,7]},{"ranks":[7,7,7,7,7,7]},{"ranks":[7,7,7,7,7,7,7]},{"ranks":[7,7,7,7,7,7,7,7]},{"ranks":[8]},{"ranks":[8,8]},{"ranks":[8,8,8]},{"ranks":[8,8,8,8]},{"ranks":[8,8,8,8,8]},{"ranks":[8,8,8,8,8,8]},{"ranks":[8,8,8,8,8,8,8]},{"ranks":[8,8,8,8,8,8,8,8]},{"ranks":[9]},{"ranks":[9,9]},{"ranks":[9,9,9]},{"ranks":[9,9,9,9]},{"ranks":[9,9,9,9,9]},{"ranks":[9,9,9,9,9,9]},{"ranks":[9,9,9,9,9,9,9]},{"ranks":[9,9,9,9,9,9,9,9]},{"ranks":[10]},{"ranks":[10,10]},{"ranks":[10,10,10]},{"ranks":[10,10,10,10]},{"ranks":[10,10,10,10,10]},{"ranks":[10,10,10,10,10,10]},{"ranks":[10,10,10,10,10,10,10]},{"ranks":[10,10,10,10,10,10,10,10]},{"ranks":[11]},{"ranks":[11,11]},{"ranks":[11,11,11]},{"ranks":[11,11,11,11]},{"ranks":[11,11,11,11,11]},{"ranks":[11,11,11,11,11,11]},{"ranks":[11,11,11,11,11,11,11]},{"ranks":[11,11,11,11,11,11,11,11]},{"ranks":[12]},{"ranks":[12,12]},{"ranks":[12,12,12]},{"ranks":[12,12,12,12]},{"ranks":[12,12,12,12,12]},{"ranks":[12,12,12,12,12,12]},{"ranks":[12,12,12,12,12,12,12]},{"ranks":[12,12,12,12,12,12,12,12]},{"ranks":[13]},{"ranks":[13,13]},{"ranks":[13,13,13]},{"ranks":[13,13,13,13]},{"ranks":[13,13,13,13,13]},{"ranks":[13,13,13,13,13,13]},{"ranks":[13,13,13,13,13,13,13]},{"ranks":[13,13,13,13,13,13,13,13]},{"ranks":[14]},{"ranks":[14,14]},{"ranks":[14,14,14]},{"ranks":[14,14,14,14]},{"ranks":[14,14,14,14,14]},{"ranks":[14,14,14,14,14,14]},{"ranks":[14,14,14,14,14,14,14]},{"ranks":[14,14,14,14,14,14,14,14]},{"ranks":[15]},{"ranks":[15,15]},{"ranks":[15,15,15]},{"ranks":[15,15,15,15]},{"ranks":[15,15,15,15,15]},{"ranks":[15,15,15,15,15,15]},{"ranks":[15,15,15,15,15,15,15]},{"ranks":[15,15,15,15,15,15,15,15]},{"ranks":[16]},{"ranks":[16,16]},{"ranks":[16,16,16]},{"ranks":[16,16,16,16]},{"ranks":[16,16,16,16,16]},{"ranks":[16,16,16,16,16,16]},{"ranks":[16,16,16,16,16,16,16]},{"ranks":[16,16,16,16,16,16,16,16]},{"ranks":[14,2,3,4,5]},{"ranks":[2,3,4,5,6]},{"ranks":[3,4,5,6,7]},{"ranks":[4,5,6,7,8]},{"ranks":[5,6,7,8,9]},{"ranks":[6,7,8,9,10]},{"ranks":[7,8,9,10,11]},{"ranks":[8,9,10,11,12]},{"ranks":[9,10,11,12,13]},{"ranks":[10,11,12,13,14]},{"ranks":[14,14,2,2,3,3]},{"ranks":[2,2,3,3,4,4]},{"ranks":[3,3,4,4,5,5]},{"ranks":[4,4,5,5,6,6]},{"ranks":[5,5,6,6,7,7]},{"ranks":[6,6,7,7,8,8]},{"ranks":[7,7,8,8,9,9]},{"ranks":[8,8,9,9,10,10]},{"ranks":[9,9,10,10,11,11]},{"ranks":[10,10,11,11,12,12]},{"ranks":[11,11,12,12,13,13]},{"ranks":[12,12,13,13,14,14]},{"ranks":[14,14,14,2,2,2]},{"ranks":[2,2,2,3,3,3]},{"ranks":[3,3,3,4,4,4]},{"ranks":[4,4,4,5,5,5]},{"ranks":[5,5,5,6,6,6]},{"ranks":[6,6,6,7,7,7]},{"ranks":[7,7,7,8,8,8]},{"ranks":[8,8,8,9,9,9]},{"ranks":[9,9,9,10,10,10]},{"ranks":[10,10,10,11,11,11]},{"ranks":[11,11,11,12,12,12]},{"ranks":[12,12,12,13,13,13]},{"ranks":[13,13,13,14,14,14]},{"ranks":[15,15,16,16]},{"ranks":[2,2,2,3,3]},{"ranks":[2,2,2,4,4]},{"ranks":[2,2,2,5,5]},{"ranks":[2,2,2,6,6]},{"ranks":[2,2,2,7,7]},{"ranks":[2,2,2,8,8]},{"ranks":[2,2,2,9,9]},{"ranks":[2,2,2,10,10]},{"ranks":[2,2,2,11,11]},{"ranks":[2,2,2,12,12]},{"ranks":[2,2,2,13,13]},{"ranks":[2,2,2,14,14]},{"ranks":[2,2,2,15,15]},{"ranks":[2,2,2,16,16]},{"ranks":[3,3,3,2,2]},{"ranks":[3,3,3,4,4]},{"ranks":[3,3,3,5,5]},{"ranks":[3,3,3,6,6]},{"ranks":[3,3,3,7,7]},{"ranks":[3,3,3,8,8]},{"ranks":[3,3,3,9,9]},{"ranks":[3,3,3,10,10]},{"ranks":[3,3,3,11,11]},{"ranks":[3,3,3,12,12]},{"ranks":[3,3,3,13,13]},{"ranks":[3,3,3,14,14]},{"ranks":[3,3,3,15,15]},{"ranks":[3,3,3,16,16]},{"ranks":[4,4,4,2,2]},{"ranks":[4,4,4,3,3]},{"ranks":[4,4,4,5,5]},{"ranks":[4,4,4,6,6]},{"ranks":[4,4,4,7,7]},{"ranks":[4,4,4,8,8]},{"ranks":[4,4,4,9,9]},{"ranks":[4,4,4,10,10]},{"ranks":[4,4,4,11,11]},{"ranks":[4,4,4,12,12]},{"ranks":[4,4,4,13,13]},{"ranks":[4,4,4,14,14]},{"ranks":[4,4,4,15,15]},{"ranks":[4,4,4,16,16]},{"ranks":[5,5,5,2,2]},{"ranks":[5,5,5,3,3]},{"ranks":[5,5,5,4,4]},{"ranks":[5,5,5,6,6]},{"ranks":[5,5,5,7,7]},{"ranks":[5,5,5,8,8]},{"ranks":[5,5,5,9,9]},{"ranks":[5,5,5,10,10]},{"ranks":[5,5,5,11,11]},{"ranks":[5,5,5,12,12]},{"ranks":[5,5,5,13,13]},{"ranks":[5,5,5,14,14]},{"ranks":[5,5,5,15,15]},{"ranks":[5,5,5,16,16]},{"ranks":[6,6,6,2,2]},{"ranks":[6,6,6,3,3]},{"ranks":[6,6,6,4,4]},{"ranks":[6,6,6,5,5]},{"ranks":[6,6,6,7,7]},{"ranks":[6,6,6,8,8]},{"ranks":[6,6,6,9,9]},{"ranks":[6,6,6,10,10]},{"ranks":[6,6,6,11,11]},{"ranks":[6,6,6,12,12]},{"ranks":[6,6,6,13,13]},{"ranks":[6,6,6,14,14]},{"ranks":[6,6,6,15,15]},{"ranks":[6,6,6,16,16]},{"ranks":[7,7,7,2,2]},{"ranks":[7,7,7,3,3]},{"ranks":[7,7,7,4,4]},{"ranks":[7,7,7,5,5]},{"ranks":[7,7,7,6,6]},{"ranks":[7,7,7,8,8]},{"ranks":[7,7,7,9,9]},{"ranks":[7,7,7,10,10]},{"ranks":[7,7,7,11,11]},{"ranks":[7,7,7,12,12]},{"ranks":[7,7,7,13,13]},{"ranks":[7,7,7,14,14]},{"ranks":[7,7,7,15,15]},{"ranks":[7,7,7,16,16]},{"ranks":[8,8,8,2,2]},{"ranks":[8,8,8,3,3]},{"ranks":[8,8,8,4,4]},{"ranks":[8,8,8,5,5]},{"ranks":[8,8,8,6,6]},{"ranks":[8,8,8,7,7]},{"ranks":[8,8,8,9,9]},{"ranks":[8,8,8,10,10]},{"ranks":[8,8,8,11,11]},{"ranks":[8,8,8,12,12]},{"ranks":[8,8,8,13,13]},{"ranks":[8,8,8,14,14]},{"ranks":[8,8,8,15,15]},{"ranks":[8,8,8,16,16]},{"ranks":[9,9,9,2,2]},{"ranks":[9,9,9,3,3]},{"ranks":[9,9,9,4,4]},{"ranks":[9,9,9,5,5]},{"ranks":[9,9,9,6,6]},{"ranks":[9,9,9,7,7]},{"ranks":[9,9,9,8,8]},{"ranks":[9,9,9,10,10]},{"ranks":[9,9,9,11,11]},{"ranks":[9,9,9,12,12]},{"ranks":[9,9,9,13,13]},{"ranks":[9,9,9,14,14]},{"ranks":[9,9,9,15,15]},{"ranks":[9,9,9,16,16]},{"ranks":[10,10,10,2,2]},{"ranks":[10,10,10,3,3]},{"ranks":[10,10,10,4,4]},{"ranks":[10,10,10,5,5]},{"ranks":[10,10,10,6,6]},{"ranks":[10,10,10,7,7]},{"ranks":[10,10,10,8,8]},{"ranks":[10,10,10,9,9]},{"ranks":[10,10,10,11,11]},{"ranks":[10,10,10,12,12]},{"ranks":[10,10,10,13,13]},{"ranks":[10,10,10,14,14]},{"ranks":[10,10,10,15,15]},{"ranks":[10,10,10,16,16]},{"ranks":[11,11,11,2,2]},{"ranks":[11,11,11,3,3]},{"ranks":[11,11,11,4,4]},{"ranks":[11,11,11,5,5]},{"ranks":[11,11,11,6,6]},{"ranks":[11,11,11,7,7]},{"ranks":[11,11,11,8,8]},{"ranks":[11,11,11,9,9]},{"ranks":[11,11,11,10,10]},{"ranks":[11,11,11,12,12]},{"ranks":[11,11,11,13,13]},{"ranks":[11,11,11,14,14]},{"ranks":[11,11,11,15,15]},{"ranks":[11,11,11,16,16]},{"ranks":[12,12,12,2,2]},{"ranks":[12,12,12,3,3]},{"ranks":[12,12,12,4,4]},{"ranks":[12,12,12,5,5]},{"ranks":[12,12,12,6,6]},{"ranks":[12,12,12,7,7]},{"ranks":[12,12,12,8,8]},{"ranks":[12,12,12,9,9]},{"ranks":[12,12,12,10,10]},{"ranks":[12,12,12,11,11]},{"ranks":[12,12,12,13,13]},{"ranks":[12,12,12,14,14]},{"ranks":[12,12,12,15,15]},{"ranks":[12,12,12,16,16]},{"ranks":[13,13,13,2,2]},{"ranks":[13,13,13,3,3]},{"ranks":[13,13,13,4,4]},{"ranks":[13,13,13,5,5]},{"ranks":[13,13,13,6,6]},{"ranks":[13,13,13,7,7]},{"ranks":[13,13,13,8,8]},{"ranks":[13,13,13,9,9]},{"ranks":[13,13,13,10,10]},{"ranks":[13,13,13,11,11]},{"ranks":[13,13,13,12,12]},{"ranks":[13,13,13,14,14]},{"ranks":[13,13,13,15,15]},{"ranks":[13,13,13,16,16]},{"ranks":[14,14,14,2,2]},{"ranks":[14,14,14,3,3]},{"ranks":[14,14,14,4,4]},{"ranks":[14,14,14,5,5]},{"ranks":[14,14,14,6,6]},{"ranks":[14,14,14,7,7]},{"ranks":[14,14,14,8,8]},{"ranks":[14,14,14,9,9]},{"ranks":[14,14,14,10,10]},{"ranks":[14,14,14,11,11]},{"ranks":[14,14,14,12,12]},{"ranks":[14,14,14,13,13]},{"ranks":[14,14,14,15,15]},{"ranks":[14,14,14,16,16]}]\nscoreboard players set #bot_team gd_ctx -1\nscoreboard players set #last_team gd_ctx -2\nexecute as @e[tag=gd.board] if score @s gd_seat = #actor gd_ctx run scoreboard players operation #bot_team gd_ctx = @s gd_team\nscoreboard players operation #bot_lastseat gd_ctx = @s gd_lastseat\nexecute as @e[tag=gd.board] if score @s gd_seat = #bot_lastseat gd_ctx run scoreboard players operation #last_team gd_ctx = @s gd_team\nexecute store result entity @s data.guandan.bot.partner int 1 run scoreboard players get #last_team gd_ctx\n', 'bot/evaluate': 'scoreboard players operation #utility gd_ctx = #size gd_ctx\nscoreboard players set #bot_weight gd_ctx 100\nscoreboard players operation #utility gd_ctx *= #bot_weight gd_ctx\nscoreboard players operation #utility gd_ctx -= #high gd_ctx\nexecute if score #kind gd_ctx matches 8..10 run scoreboard players remove #utility gd_ctx 2000\nscoreboard players set #bot_hand gd_ctx 0\nexecute as @e[tag=gd.board] if score @s gd_seat = #actor gd_ctx run scoreboard players operation #bot_hand gd_ctx = @s gd_count\nexecute if score #size gd_ctx = #bot_hand gd_ctx run scoreboard players add #utility gd_ctx 10000\nscoreboard players set #bot_team gd_ctx -1\nexecute as @e[tag=gd.board] if score @s gd_seat = #actor gd_ctx run scoreboard players operation #bot_team gd_ctx = @s gd_team\nexecute store result score #last_team gd_ctx run data get entity @s data.guandan.bot.partner\nexecute if score @s gd_lastkind matches 1.. if score #last_team gd_ctx = #bot_team gd_ctx unless score #size gd_ctx = #bot_hand gd_ctx run return 0\nexecute unless score #utility gd_ctx > @s gd_best run return 0\nscoreboard players operation @s gd_best = #utility gd_ctx\nscoreboard players operation @s gd_bestchoice = #choice gd_ctx\nexecute as @e[tag=gd.cards] if score @s gd_owner = #actor gd_ctx run scoreboard players operation @s gd_botpick = @s gd_sel\n', 'bot/fill': 'function guandan:system/context\nexecute unless entity @e[tag=gd.board,scores={gd_order=0}] run function guandan:bot/add {order:0,number:1}\nfunction guandan:system/context\nexecute unless entity @e[tag=gd.board,scores={gd_order=1}] run function guandan:bot/add {order:1,number:2}\nfunction guandan:system/context\nexecute unless entity @e[tag=gd.board,scores={gd_order=2}] run function guandan:bot/add {order:2,number:3}\nfunction guandan:system/context\nexecute unless entity @e[tag=gd.board,scores={gd_order=3}] run function guandan:bot/add {order:3,number:4}\nfunction guandan:system/context\n', 'bot/finish': 'execute if score @s gd_best matches -1000000 run return run function guandan:game/pass\nexecute as @e[tag=gd.cards] if score @s gd_owner = #actor gd_ctx run scoreboard players operation @s gd_sel = @s gd_botpick\nscoreboard players operation #choice gd_ctx = @s gd_bestchoice\nfunction guandan:game/submit\n', 'bot/options': 'execute unless score #bot_choice gd_ctx < #options gd_ctx run return 0\nscoreboard players operation #choice gd_ctx = #bot_choice gd_ctx\nfunction guandan:cards/choose\nexecute if score #ok gd_ctx matches 1 run function guandan:bot/evaluate\nscoreboard players add #bot_choice gd_ctx 1\nfunction guandan:bot/options\n', 'bot/part': 'function guandan:game/part\ntag @s add gd.bot\n', 'bot/select_ranks': 'execute unless data storage guandan:bot need[0] run return 0\nexecute store result score #bot_rank gd_ctx run data get storage guandan:bot need[0]\ndata remove storage guandan:bot need[0]\nscoreboard players set #bot_card gd_ctx 999\nexecute as @e[tag=gd.cards,scores={gd_sel=0}] if score @s gd_owner = #actor gd_ctx if score @s gd_point = #bot_rank gd_ctx run scoreboard players operation #bot_card gd_ctx < @s gd_id\nexecute if score #bot_card gd_ctx matches 999 if score #bot_rank gd_ctx matches 2..14 as @e[tag=gd.cards,scores={gd_sel=0,gd_wild=1}] if score @s gd_owner = #actor gd_ctx run scoreboard players operation #bot_card gd_ctx < @s gd_id\nexecute if score #bot_card gd_ctx matches 999 run scoreboard players set #bot_valid gd_ctx 0\nexecute as @e[tag=gd.cards,scores={gd_sel=0}] if score @s gd_owner = #actor gd_ctx if score @s gd_id = #bot_card gd_ctx run scoreboard players set @s gd_sel 1\nfunction guandan:bot/select_ranks\n', 'bot/step': 'data modify storage guandan:bot need set from entity @s data.guandan.bot.todo[0].ranks\ndata remove entity @s data.guandan.bot.todo[0]\nexecute as @e[tag=gd.cards] if score @s gd_owner = #actor gd_ctx run scoreboard players set @s gd_sel 0\nscoreboard players set #bot_valid gd_ctx 1\nfunction guandan:bot/select_ranks\nexecute unless score #bot_valid gd_ctx matches 1 run return 0\nfunction guandan:game/select_context\nfunction guandan:cards/analyze\nscoreboard players set #bot_choice gd_ctx 0\nfunction guandan:bot/options\n', 'bot/tick': 'function guandan:system/context\nscoreboard players add @s gd_botclock 1\nexecute if score @s gd_state matches 2 if score @s gd_botclock matches 20.. run return run function guandan:bot/tribute\nexecute unless score @s gd_state matches 3 run return 0\nscoreboard players operation #actor gd_ctx = @s gd_turn\nscoreboard players set #isbot gd_ctx 0\nexecute as @e[tag=gd.board,tag=gd.bot,scores={gd_rank=0}] if score @s gd_seat = #actor gd_ctx run scoreboard players set #isbot gd_ctx 1\nexecute unless score #isbot gd_ctx matches 1 run return 0\nexecute unless score @s gd_botepoch = @s gd_epoch run function guandan:bot/begin\nexecute unless score @s gd_botclock matches 12.. run return 0\nfunction guandan:bot/step\nexecute if data entity @s data.guandan.bot.todo[0] run function guandan:bot/step\nexecute if data entity @s data.guandan.bot.todo[0] run function guandan:bot/step\nexecute unless data entity @s data.guandan.bot.todo[0] run function guandan:bot/finish\n', 'bot/tribute': 'scoreboard players set @s gd_botclock 0\nscoreboard players set #actor gd_ctx -1\nexecute if score @s gd_phase matches 1 run scoreboard players operation #actor gd_ctx = @e[tag=gd.board,tag=gd.bot,scores={gd_tribute=1},limit=1] gd_seat\nexecute if score @s gd_phase matches 2 run scoreboard players operation #actor gd_ctx = @e[tag=gd.board,tag=gd.bot,scores={gd_return=1},limit=1] gd_seat\nexecute unless score #actor gd_ctx matches 1..8 run return 0\ntag @e[tag=gd.auto] remove gd.auto\nscoreboard players set #max gd_ctx -1\nscoreboard players set #min gd_ctx 99\nscoreboard players set #small gd_ctx 0\nexecute as @e[tag=gd.cards,scores={gd_wild=0}] if score @s gd_owner = #actor gd_ctx run scoreboard players operation #max gd_ctx > @s gd_strength\nexecute as @e[tag=gd.cards] if score @s gd_owner = #actor gd_ctx run scoreboard players operation #min gd_ctx < @s gd_strength\nexecute as @e[tag=gd.cards,scores={gd_point=2..10}] if score @s gd_owner = #actor gd_ctx run scoreboard players set #small gd_ctx 1\nexecute if score @s gd_phase matches 1 as @e[tag=gd.cards,scores={gd_wild=0}] if score @s gd_owner = #actor gd_ctx if score @s gd_strength = #max gd_ctx run tag @s add gd.auto\nexecute if score @s gd_phase matches 2 if score #small gd_ctx matches 0 as @e[tag=gd.cards] if score @s gd_owner = #actor gd_ctx if score @s gd_strength = #min gd_ctx run tag @s add gd.auto\n# 还牌优先点数<=10；低点级牌虽强，仍属于合法还牌。\nexecute if score @s gd_phase matches 2 as @e[tag=gd.cards,scores={gd_point=2..10}] if score @s gd_owner = #actor gd_ctx run tag @s add gd.auto\nscoreboard players operation #card gd_ctx = @e[tag=gd.auto,limit=1] gd_id\nfunction guandan:tribute/submit\nfunction guandan:clock/reset\ntag @e[tag=gd.auto] remove gd.auto\n'}
    for name, body in overrides.items():
        path=ROOT/(name+".mcfunction");path.parent.mkdir(parents=True,exist_ok=True);path.write_text(body,encoding="utf8")

if __name__=='__main__':
    build()
    apply_test_bots()
