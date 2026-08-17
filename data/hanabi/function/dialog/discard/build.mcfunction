# 按hb_discard_order从小到大扫描，确保从左到右、从上到下保持真实弃牌先后
data modify storage hanabi:dialog discard_view set value {text:"",font:"card:hanabi_ui",shadow_color:0,extra:[]}
scoreboard players set #discard_added hb_ctx 0
scoreboard players set #discard_scan hb_ctx 1
scoreboard players set #discard_max hb_ctx 0
execute as @e[type=minecraft:marker,tag=hb.controller] if score @s hb_id = #ctx_id hb_ctx run scoreboard players operation #discard_max hb_ctx = @s hb_discard_count
execute if score #discard_max hb_ctx matches 1.. run function hanabi:dialog/discard/scan
execute if score #discard_added hb_ctx matches 0 run data modify storage hanabi:dialog discard_view.extra append value {text:"弃牌堆目前为空。",font:"minecraft:default",color:"gray"}
# 最后一行后补足图片向下伸出的高度，避免Dialog按普通文字行高裁掉牌面下半部分
execute if score #discard_added hb_ctx matches 1.. run data modify storage hanabi:dialog discard_view.extra append value {text:"\n\n\n\n\n\n\n\n",font:"minecraft:default"}
