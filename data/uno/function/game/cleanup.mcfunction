# 先锁结束，防止通用人数维护重入结束回调。
scoreboard players set @s un_state 6
function uno:system/context
function uno:visual/clear
function uno:animation/clear
kill @e[type=minecraft:marker,tag=un.cards]
execute store result storage uno:runtime cleanup.table int 1 run scoreboard players get @s ct_id
function uno:player/clear_drops with storage uno:runtime cleanup
execute as @e[tag=un.player] if score @s un_table = #table un_ctx at @s run function uno:player/clear_drops with storage uno:runtime cleanup
execute as @e[type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{uno:{tool:1b}}] run function uno:player/kill_drop
# 离开维度的玩家不参与本桌操作，但中止时仍须清掉其 UNO 专属物品。
execute as @a[tag=un.player] if score @s un_table = #table un_ctx run function uno:player/clear_state
scoreboard players set @s un_state 0
scoreboard players set @s un_pending 0
scoreboard players set @s un_timer 0
tag @s remove un.controller
tag @s remove un.current
function cardtable:game/return_lobby
