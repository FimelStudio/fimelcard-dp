$execute if score #viewer ab_ctx matches $(seat) run return 0
tag @a[tag=ab.title_owner] remove ab.title_owner
$execute as @a[tag=ab.player,scores={ab_seat=$(seat)}] if score @s ab_id = #ctx ab_ctx run tag @s add ab.title_owner
execute unless entity @a[tag=ab.title_owner,limit=1] run return 0
scoreboard players add #row ab_ctx 1
scoreboard players set #y ab_ctx -18
execute if score #row ab_ctx matches 2 run scoreboard players set #y ab_ctx -72
execute if score #row ab_ctx matches 3 run scoreboard players set #y ab_ctx -126
execute if score #row ab_ctx matches 4 run scoreboard players set #y ab_ctx -180
execute as @a[tag=ab.title_owner,limit=1] at @s run function hanabi:name/resolve
# 昵称使用原版字体；先包一层以清除名字组件遗留的点击/阴影样式。
data modify storage abraca:title owner_name set value {text:"",color:"aqua",shadow_color:0,extra:[]}
data modify storage abraca:title owner_name.extra append from storage hanabi:name resolved
data modify storage fimel_title:io text set from storage abraca:title owner_name
data modify storage fimel_title:io font set value "minecraft:default_mod"
data modify storage fimel_title:io neg_font set value "minecraft:default_neg"
data modify storage fimel_title:io x set value 8.0d
execute store result storage fimel_title:io y double 1 run scoreboard players get #y ab_ctx
data modify storage fimel_title:io dx set value 0.0d
data modify storage fimel_title:io dy set value 0.0d
data modify storage fimel_title:io align set value "left"
data modify storage fimel_title:io origin set value "up-left"
function fimel_title:new_text
$scoreboard players set #owner ab_ctx $(seat)
# 牌面行只容纳位图字形；中文前缀会被专用字体渲染为方框。
data modify storage abraca:title cards set value {text:"",shadow_color:0,extra:[]}
execute as @e[type=minecraft:marker,tag=ab.hand] if score @s ab_id = #ctx ab_ctx if score @s ab_owner = #owner ab_ctx run function abraca:title/append_card
scoreboard players remove #y ab_ctx 38
data modify storage fimel_title:io text set from storage abraca:title cards
data modify storage fimel_title:io font set value "card:abraca_title"
data modify storage fimel_title:io neg_font set value "card:abraca_title_neg"
data modify storage fimel_title:io x set value 8.0d
execute store result storage fimel_title:io y double 1 run scoreboard players get #y ab_ctx
data modify storage fimel_title:io dx set value 0.0d
data modify storage fimel_title:io dy set value 0.0d
data modify storage fimel_title:io align set value "left"
data modify storage fimel_title:io origin set value "up-left"
function fimel_title:new_text
tag @a[tag=ab.title_owner] remove ab.title_owner
