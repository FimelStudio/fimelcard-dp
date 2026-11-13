scoreboard players operation #chair_input ct_ctx = @s ct_chair_pick
scoreboard players reset @s ct_chair_pick
execute unless entity @s[tag=ct.player] run return 0
scoreboard players operation #chair_table ct_ctx = @s ct_id
tag @e[tag=ct.chair_controller] remove ct.chair_controller
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_state=0}] if score @s ct_id = #chair_table ct_ctx run tag @s add ct.chair_controller
execute unless entity @e[tag=ct.chair_controller,limit=1] run return run function cardtable:chairs/settings/invalid
# 1只打开当前桌的实时菜单，不提交状态；真正的变更使用下面的一次性编码。
execute if score #chair_input ct_ctx matches 1 run return run function cardtable:chairs/settings/open_actor
execute unless score #chair_input ct_ctx matches 10..999999998 run return run function cardtable:chairs/settings/invalid
execute unless score @s ct_ch_load = #chair_load ct_ctx run return run function cardtable:chairs/settings/invalid
execute unless score @s ct_ch_table = @s ct_id run return run function cardtable:chairs/settings/invalid
execute unless score @s ct_ch_seat = @s ct_seat run return run function cardtable:chairs/settings/invalid
execute unless score @s ct_ch_game = @e[tag=ct.chair_controller,limit=1] ct_game run return run function cardtable:chairs/settings/invalid
execute unless score @s ct_ch_seen = @e[tag=ct.chair_controller,limit=1] ct_ch_epoch run return run function cardtable:chairs/settings/invalid
scoreboard players operation #chair_nonce ct_ctx = #chair_input ct_ctx
scoreboard players operation #chair_nonce ct_ctx /= #chair_ten ct_ctx
execute unless score #chair_nonce ct_ctx = @s ct_ch_nonce run return run function cardtable:chairs/settings/invalid
scoreboard players operation #chair_choice ct_ctx = #chair_input ct_ctx
scoreboard players operation #chair_choice ct_ctx %= #chair_ten ct_ctx
scoreboard players reset @s ct_ch_nonce
execute if score #chair_choice ct_ctx matches 0 run return run function cardtable:chairs/settings/back
execute unless score #chair_choice ct_ctx matches 1..8 run return run function cardtable:chairs/settings/invalid
tag @s add ct.chair_actor
execute as @e[tag=ct.chair_controller,limit=1] at @s run function cardtable:chairs/settings/apply
tag @s remove ct.chair_actor
tag @e[tag=ct.chair_controller] remove ct.chair_controller
