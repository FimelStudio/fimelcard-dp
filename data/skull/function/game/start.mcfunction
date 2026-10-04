function skull:log {text:"开始开局检查"}
execute unless score @s ct_joined matches 2..6 run tellraw @a[tag=ct.start_actor,limit=1] {text:"[骷髅牌] 需要2至6名玩家入座。",color:"red"}
execute unless score @s ct_joined matches 2..6 run return fail
scoreboard players operation #ctx sk_ctx = @s ct_id
scoreboard players set #online sk_ctx 0
scoreboard players set #blocked sk_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #ctx sk_ctx run scoreboard players add #online sk_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #ctx sk_ctx run function skull:game/check_hotbar
execute unless score #online sk_ctx = @s ct_joined run tellraw @a[tag=ct.start_actor,limit=1] {text:"[骷髅牌] 入座人数与在线人数不一致。",color:"red"}
execute unless score #online sk_ctx = @s ct_joined run return fail
execute if score #blocked sk_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] {text:"[骷髅牌] 请所有玩家腾空快捷栏。",color:"red"}
execute if score #blocked sk_ctx matches 1 run return fail
tag @s add sk.controller
scoreboard players operation @s sk_id = @s ct_id
scoreboard players operation @s sk_players = @s ct_joined
scoreboard players set @s sk_round 0
data modify entity @s data.skull set value {seats:{}}
execute as @a[tag=ct.player] if score @s ct_id = #ctx sk_ctx run function skull:player/init
function skull:player/audience
tag @e[tag=sk.initializing] remove sk.initializing
tag @s add sk.initializing
execute as @a[tag=sk.audience] run function skull:deck/init_player
tag @s remove sk.initializing
scoreboard players operation @s sk_first = @a[tag=sk.audience,sort=random,limit=1] sk_seat
execute positioned ~ ~1.78 ~ summon minecraft:text_display run function skull:hud/init
scoreboard players set @s ct_start 1
function skull:deal/start
tag @a[tag=sk.audience] remove sk.audience
