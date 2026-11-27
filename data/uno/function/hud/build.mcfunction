# 每个计数和牌型只来自本玩家、本桌的真实 marker，绝不复用别人的列表。
execute unless entity @s[tag=un.hud_active] run function uno:hud/activate
scoreboard players operation #hud_table un_ctx = @s un_table
scoreboard players operation #hud_seat un_ctx = @s un_seat
scoreboard players operation #hud_pick un_ctx = @s un_pick
tag @e[tag=un.hudhand] remove un.hudhand
execute as @e[type=minecraft:marker,tag=un.card] if score @s ct_id = #hud_table un_ctx if score @s un_owner = #hud_seat un_ctx run tag @s add un.hudhand
data modify storage uno:hud rows set value [{cards:{text:"",shadow_color:0,extra:[]}},{cards:{text:"",shadow_color:0,extra:[]}},{cards:{text:"",shadow_color:0,extra:[]}}]
scoreboard players set #hud_col un_ctx 0
scoreboard players set #hud_row un_ctx 0
scoreboard players set #hud_types un_ctx 0
function uno:hud/cards
tag @e[tag=un.hudhand] remove un.hudhand
data modify storage fimel_title:io panel_buffer set value []
data modify storage fimel_title:io text_buffer set value []
data modify storage fimel_title:io neg_text_buffer set value []
# 正 y 向上；预留四张万能牌堆叠的高度，各行互不遮挡。
execute if score #hud_types un_ctx matches 1..18 run function uno:hud/line {row:0,y:42}
execute if score #hud_types un_ctx matches 19..36 run function uno:hud/line {row:0,y:36}
execute if score #hud_types un_ctx matches 19..36 run function uno:hud/line {row:1,y:106}
execute if score #hud_types un_ctx matches 37.. run function uno:hud/line {row:0,y:27}
execute if score #hud_types un_ctx matches 37.. run function uno:hud/line {row:1,y:78}
execute if score #hud_types un_ctx matches 37.. run function uno:hud/line {row:2,y:129}
execute if score #hud_types un_ctx matches 0 run function uno:hud/no_cards
function uno:hud/status
scoreboard players operation panel_id fbt_io = @s un_panel
function fimel_title:replace_panel
scoreboard players operation @s fbt_panel = @s un_panel
