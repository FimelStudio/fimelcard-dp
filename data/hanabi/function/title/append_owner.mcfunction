# 宏参数seat是被展示手牌的座位；观察者自己的座位直接跳过。
$execute if score #title_viewer hb_ctx matches $(seat) run return 0
tag @a[tag=hb.title_owner] remove hb.title_owner
$execute as @a[tag=hb.player,scores={hb_seat=$(seat)}] if score @s hb_id = #ctx_id hb_ctx run tag @s add hb.title_owner
$execute unless entity @a[tag=hb.title_owner,scores={hb_seat=$(seat)},limit=1] run return 0

scoreboard players add #title_row hb_ctx 1
# BetterTitle 的上方锚点以负 Y 表示向屏幕下方移动。
scoreboard players set #title_y hb_ctx -18
execute if score #title_row hb_ctx matches 2 run scoreboard players set #title_y hb_ctx -80
execute if score #title_row hb_ctx matches 3 run scoreboard players set #title_y hb_ctx -142

# 玩家名也预先解析为静态文本，避免Actionbar或Dialog保留原始选择器。
$execute as @a[tag=hb.title_owner,scores={hb_seat=$(seat)},limit=1] at @s run function hanabi:name/resolve
data modify storage hanabi:title owner_name set value {text:"",color:"aqua",shadow_color:0,extra:[]}
data modify storage hanabi:title owner_name.extra append from storage hanabi:name resolved
data modify storage title:io text set from storage hanabi:title owner_name
data modify storage title:io font set value "minecraft:default_mod"
data modify storage title:io neg_font set value "minecraft:default_neg"
data modify storage title:io x set value 8.0d
execute store result storage title:io y double 1 run scoreboard players get #title_y hb_ctx
data modify storage title:io dx set value 0.0d
data modify storage title:io dy set value 0.0d
data modify storage title:io align set value "left"
data modify storage title:io origin set value "up-left"
function title:new_text

# 同一行最多五张牌；图片直接复用物品纹理，以36像素高度显示，不额外复制贴图。
$scoreboard players set #title_owner_seat hb_ctx $(seat)
data modify storage hanabi:title cards set value {text:"",shadow_color:0,extra:[]}
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=1}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #title_owner_seat hb_ctx run function hanabi:title/append_card
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=2}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #title_owner_seat hb_ctx run function hanabi:title/append_card
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=3}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #title_owner_seat hb_ctx run function hanabi:title/append_card
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=4}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #title_owner_seat hb_ctx run function hanabi:title/append_card
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=5}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #title_owner_seat hb_ctx run function hanabi:title/append_card

scoreboard players remove #title_y hb_ctx 38
data modify storage title:io text set from storage hanabi:title cards
data modify storage title:io font set value "card:hanabi_title"
data modify storage title:io neg_font set value "card:hanabi_title_neg"
data modify storage title:io x set value 8.0d
execute store result storage title:io y double 1 run scoreboard players get #title_y hb_ctx
data modify storage title:io dx set value 0.0d
data modify storage title:io dy set value 0.0d
data modify storage title:io align set value "left"
data modify storage title:io origin set value "up-left"
function title:new_text

tag @a[tag=hb.title_owner] remove hb.title_owner
