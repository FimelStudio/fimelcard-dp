summon minecraft:item_display ~ ~-48 ~ {Tags:['dc.history','dc.game_entity'],item:{id:'minecraft:paper',count:1}}
tag @e[type=minecraft:item_display,tag=dc.history,distance=..50,sort=nearest,limit=1] add dc.new_history
scoreboard players operation @e[tag=dc.new_history,limit=1] dc_id = @s dc_id
data modify entity @e[tag=dc.new_history,limit=1] item.components."minecraft:custom_name" set from storage decrypto:input name
tag @e[tag=dc.new_history] remove dc.new_history
