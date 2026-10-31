execute unless score @s ct_capacity matches 8 run return fail
execute unless score @s ct_joined matches 5..8 run return run tellraw @a[tag=ct.start_actor,limit=1] {text:"阿瓦隆需要5～8人入座。",color:"red"}
scoreboard players operation #table av_ctx = @s ct_id
scoreboard players set #blocked av_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #table av_ctx if items entity @s hotbar.8 * run scoreboard players set #blocked av_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table av_ctx if items entity @s hotbar.7 * run scoreboard players set #blocked av_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table av_ctx if items entity @s hotbar.0 * run scoreboard players set #blocked av_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table av_ctx if items entity @s hotbar.1 * run scoreboard players set #blocked av_ctx 1
execute if score #blocked av_ctx matches 1 run return run tellraw @a[tag=ct.start_actor,limit=1] {text:"请所有玩家清空快捷栏第1、2、8、9格，用于表决染料、身份牌和操作入口。",color:"yellow"}
tag @s add av.controller
scoreboard players operation @s av_id = @s ct_id
scoreboard players operation @s av_players = @s ct_joined
scoreboard players set @s av_round 1
scoreboard players set @s av_good 0
scoreboard players set @s av_evil 0
scoreboard players set @s av_reject 0
scoreboard players set @s av_epoch 0
scoreboard players set @s av_clock 0
execute as @a[tag=ct.player] if score @s ct_id = #table av_ctx run function avalon:player/init
function avalon:context
scoreboard players set @a[tag=av.audience] av_role 3
scoreboard players set @a[tag=av.audience,scores={av_role=3},sort=random,limit=1] av_role 1
scoreboard players set @a[tag=av.audience,scores={av_role=3},sort=random,limit=1] av_role 2
scoreboard players set @a[tag=av.audience,scores={av_role=3},sort=random,limit=1] av_role 4
scoreboard players set @a[tag=av.audience,scores={av_role=3},sort=random,limit=1] av_role 5
execute if score @s av_players matches 7 run scoreboard players set @a[tag=av.audience,scores={av_role=3},sort=random,limit=1] av_role 6
execute if score @s av_players matches 8 run scoreboard players set @a[tag=av.audience,scores={av_role=3},sort=random,limit=1] av_role 7
scoreboard players operation @s av_leader = @a[tag=av.audience,sort=random,limit=1] av_seat
execute as @a[tag=av.audience] run function avalon:player/tools
scoreboard players set @s ct_start 1
data modify entity @s data.avalon.results set value []
function avalon:game/team
