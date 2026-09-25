function wenfei:log {text:"开始开局检查"}
execute unless score @s ct_joined matches 2..4 run tellraw @a[tag=ct.start_actor,limit=1] {text:"[问非所答] 需要2至4名玩家入座。",color:"red"}
execute unless score @s ct_joined matches 2..4 run function wenfei:log {text:"拒绝开局：人数不在2至4人范围内"}
execute unless score @s ct_joined matches 2..4 run return fail
scoreboard players operation #ctx wq_ctx = @s ct_id
scoreboard players set #online wq_ctx 0
scoreboard players set #blocked wq_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #ctx wq_ctx run scoreboard players add #online wq_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #ctx wq_ctx run function wenfei:game/check_hotbar
execute unless score #online wq_ctx = @s ct_joined run tellraw @a[tag=ct.start_actor,limit=1] {text:"[问非所答] 入座人数与在线人数不一致，请稍后重试。",color:"red"}
execute unless score #online wq_ctx = @s ct_joined run function wenfei:log {text:"拒绝开局：在线人数不一致"}
execute unless score #online wq_ctx = @s ct_joined run return fail
execute if score #blocked wq_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] {text:"[问非所答] 请所有玩家先腾空快捷栏。",color:"red"}
execute if score #blocked wq_ctx matches 1 run function wenfei:log {text:"拒绝开局：快捷栏未腾空"}
execute if score #blocked wq_ctx matches 1 run return fail
function wenfei:game/init_table
tag @s add wq.controller
scoreboard players operation @s wq_id = @s ct_id
scoreboard players operation @s wq_players = @s ct_joined
scoreboard players operation @s wq_total = @s wq_multi
execute if score @s wq_players matches 2 run scoreboard players operation @s wq_total = @s wq_duo
scoreboard players operation @s wq_total *= @s wq_players
scoreboard players set @s wq_round 0
data modify entity @s data.wenfei set value {}
execute as @a[tag=ct.player] if score @s ct_id = #ctx wq_ctx run function wenfei:player/init
function wenfei:player/mark_audience
scoreboard players operation @s wq_turn = @a[tag=wq.audience,sort=random,limit=1] wq_seat
execute positioned ~ ~1.4 ~ summon minecraft:text_display run function wenfei:hud/init
scoreboard players set @s ct_start 1
function wenfei:round/begin
tag @a[tag=wq.audience] remove wq.audience
