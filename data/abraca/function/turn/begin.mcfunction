scoreboard players operation #ctx ab_ctx = @s ab_id
# 不能假设座位连续；2人或有人离座时必须跳过空座位。
execute as @a[tag=ab.turn] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.turn
scoreboard players set #found ab_ctx 0
function abraca:turn/scan_once
execute if score #found ab_ctx matches 0 run function abraca:turn/scan_once
execute if score #found ab_ctx matches 0 run function abraca:turn/scan_once
execute if score #found ab_ctx matches 0 run function abraca:turn/scan_once
execute unless score #found ab_ctx matches 1 run function abraca:game/abort
execute unless score #found ab_ctx matches 1 run return 0
execute as @a[tag=ab.turn] if score @s ab_id = #ctx ab_ctx run scoreboard players set @s ab_last 0
execute as @a[tag=ab.turn] if score @s ab_id = #ctx ab_ctx run scoreboard players set @s ab_action 0
execute as @a[tag=ab.turn] if score @s ab_id = #ctx ab_ctx run scoreboard players enable @s ab_action
execute as @a[tag=ab.turn] if score @s ab_id = #ctx ab_ctx run function abraca:ui/open_cast
tag @a[tag=ab.announce] remove ab.announce
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx run tag @s add ab.announce
execute as @a[tag=ab.turn] if score @s ab_id = #ctx ab_ctx run tellraw @a[tag=ab.announce] [{text:'[出包魔法师] ',color:'dark_purple'},{selector:'@s',color:'gold'},{text:' 正在施法。',color:'gray'}]
tag @a[tag=ab.announce] remove ab.announce
