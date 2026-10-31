# 输入 #seat，输出唯一 un.selected 和 #draw_idx；不足时返回 0，不递归死循环。
tag @e[tag=un.selected] remove un.selected
scoreboard players set #draw_idx un_ctx 0
execute unless entity @e[type=minecraft:marker,tag=un.cards,scores={un_owner=0}] run function uno:deck/reshuffle
execute unless entity @e[type=minecraft:marker,tag=un.cards,scores={un_owner=0}] run return fail
tag @e[type=minecraft:marker,tag=un.cards,scores={un_owner=0},sort=random,limit=1] add un.selected
scoreboard players operation @e[type=minecraft:marker,tag=un.selected,limit=1] un_owner = #seat un_ctx
scoreboard players operation #draw_idx un_ctx = @e[type=minecraft:marker,tag=un.selected,limit=1] un_idx
execute as @e[tag=un.audience] if score @s un_seat = #seat un_ctx run scoreboard players add @s un_count 1
function uno:animation/enqueue
scoreboard players set @s un_hud_dirty 1
