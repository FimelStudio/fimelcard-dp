scoreboard players operation #hud_owner dd_ctx = @s dd_seat
scoreboard players set #hud_count dd_ctx 0
execute as @e[tag=dd.card] if score @s dd_id = #hud_table dd_ctx if score @s dd_owner = #hud_owner dd_ctx run scoreboard players add #hud_count dd_ctx 1
execute store result storage doudizhu:hud count int 1 run scoreboard players get #hud_count dd_ctx
data modify storage doudizhu:hud name set value {text:"测试人机"}
execute if entity @s[tag=dd.bot] run data modify storage doudizhu:hud name set from entity @s CustomName
execute if entity @s[type=minecraft:player] run function hanabi:name/resolve
execute if entity @s[type=minecraft:player] run data modify storage doudizhu:hud name set from storage hanabi:name resolved
function doudizhu:hud/row_text with storage doudizhu:hud
data modify storage fimel_title:io font set value "minecraft:default_mod"
data modify storage fimel_title:io neg_font set value "minecraft:default_neg"
data modify storage fimel_title:io x set value 8.0d
data modify storage fimel_title:io dx set value 0.0d
data modify storage fimel_title:io dy set value 0.0d
data modify storage fimel_title:io align set value "left"
data modify storage fimel_title:io origin set value "up-left"
function fimel_title:new_text

execute store result storage doudizhu:hud seat int 1 run scoreboard players get @s dd_seat
function doudizhu:hud/read_play with storage doudizhu:hud
function doudizhu:hud/play_images
