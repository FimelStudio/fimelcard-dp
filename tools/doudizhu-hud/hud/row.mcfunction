scoreboard players operation #hud_owner dd_ctx = @s dd_seat
scoreboard players set #hud_count dd_ctx 0
execute as @e[tag=dd.card] if score @s dd_id = #hud_table dd_ctx if score @s dd_owner = #hud_owner dd_ctx run scoreboard players add #hud_count dd_ctx 1
execute store result storage doudizhu:hud count int 1 run scoreboard players get #hud_count dd_ctx
data modify storage doudizhu:hud name set value {text:"测试人机"}
execute if entity @s[tag=dd.bot] run data modify storage doudizhu:hud name set from entity @s CustomName
execute if entity @s[type=minecraft:player] run function hanabi:name/resolve
execute if entity @s[type=minecraft:player] run data modify storage doudizhu:hud name set from storage hanabi:name resolved
function doudizhu:hud/row_text with storage doudizhu:hud
data modify storage title:io font set value "minecraft:default_mod"
data modify storage title:io neg_font set value "minecraft:default_neg"
data modify storage title:io x set value 8.0d
data modify storage title:io dx set value 0.0d
data modify storage title:io dy set value 0.0d
data modify storage title:io align set value "left"
data modify storage title:io origin set value "up-left"
function title:new_text
