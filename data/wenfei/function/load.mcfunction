scoreboard objectives add wq_ctx dummy
execute unless score #version wq_ctx matches 1.. run function wenfei:system/install
execute unless score #serial wq_ctx matches 0.. run scoreboard players set #serial wq_ctx 0
scoreboard players set #hundred wq_ctx 100
scoreboard players set #ten wq_ctx 10
function wenfei:deck/catalog
execute unless score #version wq_ctx matches 2.. run function wenfei:title/upgrade
execute if score #version wq_ctx matches 2 run function wenfei:system/upgrade_v3
execute unless data storage fimel_title:io panels run function fimel_title:code/load
# 只清理旧版本的提示工具；重载自动补发当前提示和剩余评分物品。
clear @a *[minecraft:custom_data~{wenfei:{tool:"menu"}}]
execute as @e[type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{wenfei:{tool:"menu"}}] run kill @s
execute as @e[type=minecraft:marker,tag=wq.controller,scores={wq_state=1..3}] at @s run function wenfei:title/resume
