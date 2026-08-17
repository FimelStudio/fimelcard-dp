scoreboard players operation #ctx_id hb_ctx = @s hb_id
scoreboard players operation #stack hb_ctx = @s hb_wstack
execute as @e[type=minecraft:item_display,tag=hb.stack,scores={hb_color=1}] if score @s hb_id = #ctx_id hb_ctx run scoreboard players operation @s hb_rank = #stack hb_ctx
scoreboard players operation #stack hb_ctx = @s hb_rstack
execute as @e[type=minecraft:item_display,tag=hb.stack,scores={hb_color=2}] if score @s hb_id = #ctx_id hb_ctx run scoreboard players operation @s hb_rank = #stack hb_ctx
scoreboard players operation #stack hb_ctx = @s hb_bstack
execute as @e[type=minecraft:item_display,tag=hb.stack,scores={hb_color=3}] if score @s hb_id = #ctx_id hb_ctx run scoreboard players operation @s hb_rank = #stack hb_ctx
scoreboard players operation #stack hb_ctx = @s hb_ystack
execute as @e[type=minecraft:item_display,tag=hb.stack,scores={hb_color=4}] if score @s hb_id = #ctx_id hb_ctx run scoreboard players operation @s hb_rank = #stack hb_ctx
scoreboard players operation #stack hb_ctx = @s hb_gstack
execute as @e[type=minecraft:item_display,tag=hb.stack,scores={hb_color=5}] if score @s hb_id = #ctx_id hb_ctx run scoreboard players operation @s hb_rank = #stack hb_ctx
scoreboard players operation #stack hb_ctx = @s hb_mstack
execute as @e[type=minecraft:item_display,tag=hb.stack,scores={hb_color=6}] if score @s hb_id = #ctx_id hb_ctx run scoreboard players operation @s hb_rank = #stack hb_ctx

execute as @e[type=minecraft:item_display,tag=hb.stack] if score @s hb_id = #ctx_id hb_ctx run function hanabi:hud/update_stack
execute store result storage hanabi:hud clues int 1 run scoreboard players get @s hb_clues
execute store result storage hanabi:hud clue_max int 1 run scoreboard players get @s hb_clue_max
execute store result storage hanabi:hud strikes int 1 run scoreboard players get @s hb_strikes
execute store result storage hanabi:hud strike_max int 1 run scoreboard players get @s hb_strike_max
execute store result storage hanabi:hud deck int 1 run scoreboard players get @s hb_deck_count
execute store result storage hanabi:hud reward int 1 run scoreboard players get @s hb_reward_left
execute store result storage hanabi:hud score int 1 run scoreboard players get @s hb_score
data modify storage hanabi:hud score_max set value 25
execute if score @s hb_storm matches 1 run data modify storage hanabi:hud score_max set value 30
execute as @e[type=minecraft:text_display,tag=hb.info] if score @s hb_id = #ctx_id hb_ctx run tp @s ~ ~1.75 ~
execute as @e[type=minecraft:text_display,tag=hb.info] if score @s hb_id = #ctx_id hb_ctx run function hanabi:hud/render_info with storage hanabi:hud
