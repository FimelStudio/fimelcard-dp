from build_ito import *

def build():
 objectives='ctx state round life timer pulse epoch seat table order count number owner slot used vote window win_epoch form panel previous setnonce'.split()
 put('load','\n'.join('scoreboard objectives add it_'+x+' dummy' for x in objectives)+'''
scoreboard objectives add it_action trigger
scoreboard players add #epoch it_ctx 100
scoreboard players set #hundred it_ctx 100
scoreboard players set #four it_ctx 4
function ito:themes/load
execute in minecraft:overworld as @e[type=minecraft:marker,tag=it.controller] at @s run function ito:system/reload
execute in minecraft:the_nether as @e[type=minecraft:marker,tag=it.controller] at @s run function ito:system/reload
execute in minecraft:the_end as @e[type=minecraft:marker,tag=it.controller] at @s run function ito:system/reload
''')
 put('tick','''execute as @a[tag=it.player,scores={it_action=1..}] at @s run function ito:input/submit
execute in minecraft:overworld run function ito:system/tick_dimension
execute in minecraft:the_nether run function ito:system/tick_dimension
execute in minecraft:the_end run function ito:system/tick_dimension
''')
 put('system/tick_dimension','''execute as @e[type=minecraft:item,nbt={Item:{components:{"minecraft:custom_data":{ito:{tool:1b}}}}}] at @s run function ito:input/drop
execute as @e[type=minecraft:marker,tag=it.controller,scores={it_state=1..4}] at @s run function ito:game/tick
''')
 put('system/context','''scoreboard players operation #table it_ctx = @s ct_id
tag @e[tag=it.current] remove it.current
tag @e[tag=it.cards] remove it.cards
tag @e[tag=it.parts] remove it.parts
tag @a[tag=it.audience] remove it.audience
tag @s add it.current
execute as @e[type=minecraft:marker,tag=it.card] if score @s ct_id = #table it_ctx run tag @s add it.cards
execute as @e[type=minecraft:marker,tag=it.part] if score @s ct_id = #table it_ctx run tag @s add it.parts
execute as @a[tag=it.player,tag=ct.player] if score @s it_table = #table it_ctx if score @s ct_id = #table it_ctx run tag @s add it.audience
''')
 put('system/reload','''execute unless score @s ct_game matches 19 run return run function ito:game/abort
execute unless score @s ct_state matches 1 run return run function ito:game/remove
function ito:system/context
function ito:game/epoch
execute as @a[tag=it.audience] run scoreboard players set @s it_action 0
execute as @a[tag=it.audience] run scoreboard players enable @s it_action
execute as @a[tag=it.audience] run dialog clear @s
function ito:hud/refresh
function ito:visual/refresh
''')
 put('game/epoch','''scoreboard players add #epoch it_ctx 1
scoreboard players operation @s it_epoch = #epoch it_ctx
''')
 put('game/init_table','# 蛛丝固定采用原版三关规则；不改活跃对局。\nreturn 1')
 put('game/start','''scoreboard players set @s ct_start 0
execute if score @s ct_state matches 1 run return fail
execute unless score @s ct_joined matches 2..8 run return run function ito:game/bad_start
execute if score @s ct_joined > @s ct_capacity run return run function ito:game/bad_start
scoreboard players operation #table it_ctx = @s ct_id
tag @a[tag=it.joining] remove it.joining
execute as @a[tag=ct.player] if score @s ct_id = #table it_ctx run tag @s add it.joining
scoreboard players set #online it_ctx 0
scoreboard players set #occupied it_ctx 0
execute as @a[tag=it.joining] run scoreboard players add #online it_ctx 1
execute unless score #online it_ctx = @s ct_joined run return run function ito:game/bad_start
execute as @a[tag=it.joining] if items entity @s hotbar.0 * run scoreboard players set #occupied it_ctx 1
execute as @a[tag=it.joining] if items entity @s hotbar.1 * run scoreboard players set #occupied it_ctx 1
execute as @a[tag=it.joining] if items entity @s hotbar.2 * run scoreboard players set #occupied it_ctx 1
execute as @a[tag=it.joining] if items entity @s hotbar.8 * run scoreboard players set #occupied it_ctx 1
execute if score #occupied it_ctx matches 1 run return run function ito:game/bad_slots
function ito:game/remove
tag @s add it.controller
scoreboard players operation @s it_count = #online it_ctx
scoreboard players set @s it_round 1
scoreboard players set @s it_life 3
scoreboard players set @s it_pulse 0
scoreboard players set @s it_timer 0
scoreboard players set #join_order it_ctx 0
'''+'\n'.join(f'execute as @a[tag=it.joining,scores={{ct_seat={s}}}] run function ito:player/join' for s in range(1,9))+'''
tag @a[tag=it.joining] remove it.joining
function ito:system/context
scoreboard players set @s ct_start 1
function ito:round/begin
function ito:log {text:"蛛丝开局，三关1/2/3张，共享3点生命"}
''')
 put('game/bad_start',say('需要2–8名在线玩家，人数不能超过牌桌座位数。','red','@a[tag=ct.player]')+'\ntag @a[tag=it.joining] remove it.joining\nreturn fail')
 put('game/bad_slots',say('请参与者腾空快捷栏第1、2、3、9格，再开始。','red','@a[tag=it.joining]')+'\ntag @a[tag=it.joining] remove it.joining\nreturn fail')
 put('player/join','''tag @s add it.player
scoreboard players operation @s it_table = @s ct_id
scoreboard players operation @s it_seat = @s ct_seat
scoreboard players operation @s it_order = #join_order it_ctx
scoreboard players add #join_order it_ctx 1
scoreboard players set @s it_action 0
scoreboard players enable @s it_action
scoreboard players set @s it_vote 0
scoreboard players operation #join_seat it_ctx = @s it_seat
scoreboard players operation #order it_ctx = @s it_order
function ito:name/resolve
execute as @e[type=minecraft:marker,tag=ct.controller] if score @s ct_id = #table it_ctx at @s summon minecraft:marker run function ito:player/part
function ito:hud/activate
''')
 put('player/part','''tag @s add it.part
scoreboard players operation @s ct_id = #table it_ctx
scoreboard players operation @s it_seat = #join_seat it_ctx
scoreboard players operation @s it_order = #order it_ctx
data modify entity @s data.name set from storage ito:name resolved
''')
 source=(P/'data/guandan/function/name/resolve.mcfunction').read_text(encoding='utf8').replace('guandan:','ito:').replace('gd.name_resolver','it.name_resolver')
 put('name/resolve',source)
 loot=P/'data/ito/loot_table/player_name.json';loot.parent.mkdir(parents=True,exist_ok=True);loot.write_bytes((P/'data/guandan/loot_table/player_name.json').read_bytes())
 put('game/tick','''scoreboard players add @s it_pulse 1
execute if score @s it_state matches 3..4 run scoreboard players remove @s it_timer 1
execute if score @s it_state matches 3 if score @s it_timer matches ..0 run function ito:round/next
execute if score @s it_state matches 4 if score @s it_timer matches ..0 run return run function ito:game/abort
execute if score @s it_pulse matches 20.. run function ito:game/maintenance
''')
 put('game/maintenance','''scoreboard players set @s it_pulse 0
function ito:system/context
scoreboard players set #online it_ctx 0
execute as @a[tag=it.audience] run scoreboard players add #online it_ctx 1
execute unless score #online it_ctx = @s it_count run return run function ito:game/player_left
function ito:hud/refresh
''')
 put('game/player_left',say('有人离桌或离线，本场已结束。','red')+'\nfunction ito:game/abort')
 put('game/end_vote','function ito:system/context\n'+say('结束投票通过，本场已中止。')+'\nfunction ito:game/abort')
 put('game/abort','''function ito:system/context
scoreboard players set @s it_state 0
execute as @a[tag=it.audience] run function ito:player/clear_state
function ito:game/remove
function cardtable:animation/deal/clear
function cardtable:game/return_lobby
''')
 put('game/remove','''scoreboard players operation #table it_ctx = @s ct_id
execute as @e[tag=it.card] if score @s ct_id = #table it_ctx run kill @s
execute as @e[tag=it.part] if score @s ct_id = #table it_ctx run kill @s
execute as @e[tag=it.visual] if score @s ct_id = #table it_ctx run kill @s
execute store result storage ito:input table int 1 run scoreboard players get @s ct_id
function ito:input/clear_drops with storage ito:input
tag @s remove it.controller
data remove entity @s data.ito
scoreboard players reset @s it_state
''')
 put('input/clear_drops','$kill @e[type=minecraft:item,nbt={Item:{components:{"minecraft:custom_data":{ito:{tool:1b,table:$(table)}}}}}]')
 put('player/clear_state','''function ito:hud/deactivate
clear @s *[minecraft:custom_data~{ito:{tool:1b}}]
dialog clear @s
tag @s remove it.player
tag @s remove it.audience
scoreboard players reset @s it_table
scoreboard players reset @s it_seat
scoreboard players reset @s it_action
scoreboard players reset @s it_window
scoreboard players reset @s it_form
''')
 put('round/begin','''function ito:system/context
function ito:game/epoch
scoreboard players set @s it_state 1
execute as @e[tag=it.cards] run kill @s
execute as @e[tag=it.visual] if score @s ct_id = #table it_ctx run kill @s
execute as @a[tag=it.audience] run clear @s *[minecraft:custom_data~{ito:{tool:1b}}]
execute as @a[tag=it.audience] run scoreboard players set @s it_vote 0
execute as @a[tag=it.audience] run dialog clear @s
data modify entity @s data.ito.history set value []
scoreboard players set #build it_ctx 1
function ito:deck/create
function ito:system/context
execute as @a[tag=it.audience] run function ito:deal/player
execute if score @s it_round matches 3 run function ito:round/reference
function ito:themes/draw
function ito:system/context
execute as @a[tag=it.audience] run function ito:input/give
execute as @a[tag=it.audience] run function ito:ui/open
function ito:visual/refresh
function ito:hud/refresh
''')
 put('deck/create','''execute summon minecraft:marker run function ito:deck/card
scoreboard players add #build it_ctx 1
execute if score #build it_ctx matches ..100 run function ito:deck/create
''')
 put('deck/card','''tag @s add it.card
scoreboard players operation @s ct_id = #table it_ctx
scoreboard players operation @s it_number = #build it_ctx
scoreboard players set @s it_owner -1
scoreboard players set @s it_used 0
scoreboard players set @s it_slot 0
data modify entity @s data.description set value ""
''')
 put('deal/player','''scoreboard players operation #deal_owner it_ctx = @s it_seat
scoreboard players set #deal_slot it_ctx 1
function ito:deal/one
execute if score @e[tag=it.current,limit=1] it_round matches 2.. run function ito:deal/one
execute if score @e[tag=it.current,limit=1] it_round matches 3 run function ito:deal/one
''')
 put('deal/one','''tag @e[tag=it.dealing] remove it.dealing
tag @e[tag=it.cards,scores={it_owner=-1},sort=random,limit=1] add it.dealing
scoreboard players operation @e[tag=it.dealing,limit=1] it_owner = #deal_owner it_ctx
scoreboard players operation @e[tag=it.dealing,limit=1] it_slot = #deal_slot it_ctx
scoreboard players add #deal_slot it_ctx 1
tag @e[tag=it.dealing] remove it.dealing
''')
 put('round/reference','''tag @e[tag=it.cards,scores={it_owner=-1},sort=random,limit=1] add it.reference
scoreboard players set @e[tag=it.cards,tag=it.reference] it_used 4
scoreboard players set @e[tag=it.cards,tag=it.reference] it_owner -4
execute store result entity @s data.ito.reference int 1 run scoreboard players get @e[tag=it.cards,tag=it.reference,limit=1] it_number
''')
 put('round/next','''execute if score @s it_count matches 3.. if score @s it_life matches ..2 run scoreboard players add @s it_life 1
scoreboard players add @s it_round 1
function ito:round/begin
''')
 put('game/play','''execute unless score @s it_state matches 2 run return 0
scoreboard players set #missing it_ctx 0
execute as @e[tag=it.cards,scores={it_owner=1..8,it_used=0},nbt={data:{description:""}}] run scoreboard players add #missing it_ctx 1
execute if score #missing it_ctx matches 1.. run tellraw @a[tag=it.actor] {text:"请先让所有人描述每张手牌，再讨论出牌顺序。",color:"yellow"}
execute if score #missing it_ctx matches 1.. run return 0
tag @e[tag=it.selected] remove it.selected
execute as @e[tag=it.cards,scores={it_used=0}] if score @s it_owner = #actor it_ctx if score @s it_slot = #slot it_ctx run tag @s add it.selected
execute unless entity @e[tag=it.selected,limit=1] run return 0
scoreboard players operation #played it_ctx = @e[tag=it.selected,limit=1] it_number
scoreboard players set #penalty it_ctx 0
execute as @e[tag=it.cards,scores={it_owner=1..8,it_used=0}] if score @s it_number < #played it_ctx run function ito:game/skip
scoreboard players operation @s it_life -= #penalty it_ctx
execute if score @s it_life matches ..0 run scoreboard players set @s it_life 0
execute as @e[tag=it.selected,limit=1] run function ito:game/reveal
execute if score #penalty it_ctx matches 1.. run tellraw @a[tag=it.audience] [{text:"[命悬一线] 等一下！跳过 ",color:"red"},{score:{name:"#penalty",objective:"it_ctx"}},{text:" 张更小的牌，扣除同等生命。"}]
execute as @a[tag=it.audience] run function ito:input/clear_spent_books
scoreboard players set #remaining it_ctx 0
execute as @e[tag=it.cards,scores={it_owner=1..8,it_used=0}] run scoreboard players add #remaining it_ctx 1
execute if score @s it_life matches 0 run return run function ito:game/lose
execute if score #remaining it_ctx matches 0 if score @s it_round matches 3 run return run function ito:game/win
execute if score #remaining it_ctx matches 0 run function ito:round/clear
function ito:visual/refresh
function ito:hud/refresh
''')
 put('game/skip','''scoreboard players set @s it_used 3
scoreboard players add #penalty it_ctx 1
function ito:game/history
''')
 put('game/reveal','''scoreboard players set @s it_used 2
function ito:game/history
tellraw @a[tag=it.audience] [{text:"[命悬一线] 翻开：",color:"gold"},{score:{name:"@s",objective:"it_number"}}]
''')
 put('game/history','''execute store result storage ito:runtime history.number int 1 run scoreboard players get @s it_number
execute store result storage ito:runtime history.seat int 1 run scoreboard players get @s it_owner
execute store result storage ito:runtime history.used int 1 run scoreboard players get @s it_used
data modify entity @e[tag=it.current,limit=1] data.ito.history append from storage ito:runtime history
''')
 put('round/clear','''scoreboard players set @s it_state 3
scoreboard players set @s it_timer 60
'''+say('本关通过！3秒后进入下一关。','green'))
 put('game/win',say('三关全部通过，蛛丝没有断！全员胜利！','green')+'\nfunction ito:game/finish')
 put('game/lose',say('生命归零，蛛丝断了，本场全员失败。','red')+'\nfunction ito:game/finish')
 put('game/finish','''scoreboard players set @s it_state 4
scoreboard players set @s it_timer 100
execute as @a[tag=it.audience] run clear @s *[minecraft:custom_data~{ito:{tool:1b}}]
execute as @a[tag=it.audience] run dialog clear @s
function ito:visual/refresh
function ito:hud/refresh
''')
 put('admin/abort','''execute unless entity @e[type=minecraft:marker,tag=it.controller,distance=..8] run return fail
execute as @e[type=minecraft:marker,tag=it.controller,distance=..8,sort=nearest,limit=1] at @s run function ito:game/abort
''')
 put('log','$tellraw @a[tag=ct.debug] {text:"[命悬一线] $(text)",color:"gray"}')
if __name__=='__main__':build()
