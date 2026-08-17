# 当前执行者是花火玩家；权威手牌标记重新生成固定在快捷栏0至4的认知态物品
clear @s minecraft:paper[minecraft:custom_data~{hanabi:{card:1b}}]
scoreboard players operation #ctx_id hb_ctx = @s hb_id
scoreboard players operation #item_seat hb_ctx = @s hb_seat
tag @a[tag=hb.item_owner] remove hb.item_owner
tag @s add hb.item_owner

execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=1}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #item_seat hb_ctx run function hanabi:hand/write_item
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=2}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #item_seat hb_ctx run function hanabi:hand/write_item
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=3}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #item_seat hb_ctx run function hanabi:hand/write_item
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=4}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #item_seat hb_ctx run function hanabi:hand/write_item
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=5}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #item_seat hb_ctx run function hanabi:hand/write_item

tag @s remove hb.item_owner
