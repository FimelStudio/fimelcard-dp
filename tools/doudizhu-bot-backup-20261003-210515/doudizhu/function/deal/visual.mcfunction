function doudizhu:player/audience
function cardtable:animation/deal/spawn_card
item replace entity @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,limit=1] contents with minecraft:paper[minecraft:item_model="card:poker/joker",minecraft:custom_data={doudizhu:{visual:1b}}]
tag @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,limit=1] add ct.visual_only
scoreboard players set #three dd_ctx 3
scoreboard players operation #visual_index dd_ctx = @s dd_timer
scoreboard players remove #visual_index dd_ctx 12
scoreboard players operation #visual_index dd_ctx %= #three dd_ctx
scoreboard players set #visual_count dd_ctx 0
execute as @a[tag=dd.audience,scores={dd_seat=1}] run function doudizhu:deal/target
execute as @a[tag=dd.audience,scores={dd_seat=2}] run function doudizhu:deal/target
execute as @a[tag=dd.audience,scores={dd_seat=3}] run function doudizhu:deal/target
execute as @a[tag=dd.audience,scores={dd_seat=4}] run function doudizhu:deal/target
execute as @a[tag=dd.audience,scores={dd_seat=5}] run function doudizhu:deal/target
execute as @a[tag=dd.audience,scores={dd_seat=6}] run function doudizhu:deal/target
execute as @a[tag=dd.audience,scores={dd_seat=7}] run function doudizhu:deal/target
execute as @a[tag=dd.audience,scores={dd_seat=8}] run function doudizhu:deal/target
function cardtable:animation/deal/launch with storage cardtable:deal
function cardtable:animation/deal/sound
tag @a[tag=dd.audience] remove dd.audience
