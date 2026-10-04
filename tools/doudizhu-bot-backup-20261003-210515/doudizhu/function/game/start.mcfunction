function doudizhu:log {text:"开始检查三人斗地主开局条件"}
execute unless score @s ct_joined matches 3 run tellraw @a[tag=ct.start_actor,limit=1] {text:"斗地主需要恰好3人入座。",color:"red"}
execute unless score @s ct_joined matches 3 run return fail
scoreboard players operation #ctx dd_ctx = @s ct_id
scoreboard players set #online dd_ctx 0
scoreboard players set #blocked dd_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #ctx dd_ctx run scoreboard players add #online dd_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #ctx dd_ctx if items entity @s hotbar.8 * run scoreboard players set #blocked dd_ctx 1
execute unless score #online dd_ctx matches 3 run return fail
execute if score #blocked dd_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] {text:"请三位玩家腾空快捷栏第9格，用于打开手牌。",color:"red"}
execute if score #blocked dd_ctx matches 1 run return fail
tag @s add dd.controller
scoreboard players operation @s dd_id = @s ct_id
data modify entity @s data.doudizhu set value {}
execute as @a[tag=ct.player] if score @s ct_id = #ctx dd_ctx run function doudizhu:player/init
scoreboard players set @s ct_start 1
function doudizhu:deal/start
