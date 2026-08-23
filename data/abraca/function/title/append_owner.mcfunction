$execute if score #viewer ab_ctx matches $(seat) run return 0
tag @a[tag=ab.title_owner] remove ab.title_owner
$execute as @a[tag=ab.player,scores={ab_seat=$(seat)}] if score @s ab_id = #ctx ab_ctx run tag @s add ab.title_owner
execute unless entity @a[tag=ab.title_owner,limit=1] run return 0
scoreboard players add #row ab_ctx 1
scoreboard players set #y ab_ctx -18
execute if score #row ab_ctx matches 2 run scoreboard players set #y ab_ctx -74
execute if score #row ab_ctx matches 3 run scoreboard players set #y ab_ctx -130
execute as @a[tag=ab.title_owner,limit=1] at @s run function hanabi:name/resolve
data modify storage title:io text set from storage hanabi:name resolved
data modify storage title:io font set value "minecraft:default_mod"
data modify storage title:io neg_font set value "minecraft:default_neg"
data modify storage title:io x set value 8.0d
execute store result storage title:io y double 1 run scoreboard players get #y ab_ctx
data modify storage title:io dx set value 0.0d
data modify storage title:io dy set value 0.0d
data modify storage title:io align set value "left"
data modify storage title:io origin set value "up-left"
function title:new_text
$scoreboard players set #owner ab_ctx $(seat)
data modify storage abraca:title cards set value {text:"真实咒语石：",color:"light_purple",extra:[]}
execute as @e[type=minecraft:marker,tag=ab.hand] if score @s ab_id = #ctx ab_ctx if score @s ab_owner = #owner ab_ctx run function abraca:title/append_card
scoreboard players remove #y ab_ctx 20
data modify storage title:io text set from storage abraca:title cards
data modify storage title:io font set value "card:abraca_title"
data modify storage title:io neg_font set value "card:abraca_title_neg"
data modify storage title:io x set value 8.0d
execute store result storage title:io y double 1 run scoreboard players get #y ab_ctx
function title:new_text
tag @a[tag=ab.title_owner] remove ab.title_owner
