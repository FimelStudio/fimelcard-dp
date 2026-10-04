# 只根据掉落物的origin找到真正丢出者，不选最近玩家。
scoreboard players set #drop_spell ab_ctx 0
scoreboard players set #drop_table ab_ctx 0
scoreboard players set #drop_epoch ab_ctx 0
execute store result score #drop_spell ab_ctx run data get entity @s Item.components."minecraft:custom_data".abraca.spell
execute store result score #drop_table ab_ctx run data get entity @s Item.components."minecraft:custom_data".abraca.table
execute store result score #drop_epoch ab_ctx run data get entity @s Item.components."minecraft:custom_data".abraca.epoch
execute on origin if entity @s[type=minecraft:player,tag=ab.player] at @s run function abraca:input/from_player
# 无效、过期和合法输入都移除掉落工具，避免捡走、重复处理或转交。
kill @s
