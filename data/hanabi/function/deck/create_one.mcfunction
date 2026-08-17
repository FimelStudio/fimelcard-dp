scoreboard players add #deck_card hb_ctx 1
summon minecraft:marker ~ ~ ~ {data:{hanabi:{new_deck:1b}}}
tag @e[type=minecraft:marker,nbt={data:{hanabi:{new_deck:1b}}},distance=..0.05,sort=nearest,limit=1] add hb.new_deck
tag @e[type=minecraft:marker,tag=hb.new_deck,distance=..0.05,limit=1] add hb.deck
tag @e[type=minecraft:marker,tag=hb.new_deck,distance=..0.05,limit=1] add hb.game_entity
scoreboard players operation @e[type=minecraft:marker,tag=hb.new_deck,distance=..0.05,limit=1] hb_id = @s hb_id
scoreboard players operation @e[type=minecraft:marker,tag=hb.new_deck,distance=..0.05,limit=1] hb_card = #deck_card hb_ctx
scoreboard players operation @e[type=minecraft:marker,tag=hb.new_deck,distance=..0.05,limit=1] hb_color = #deck_color hb_ctx
scoreboard players operation @e[type=minecraft:marker,tag=hb.new_deck,distance=..0.05,limit=1] hb_rank = #deck_rank hb_ctx
scoreboard players operation @e[type=minecraft:marker,tag=hb.new_deck,distance=..0.05,limit=1] hb_reward = #deck_reward hb_ctx
scoreboard players set @e[type=minecraft:marker,tag=hb.new_deck,distance=..0.05,limit=1] hb_seat 0
scoreboard players set @e[type=minecraft:marker,tag=hb.new_deck,distance=..0.05,limit=1] hb_slot 0
scoreboard players set @e[type=minecraft:marker,tag=hb.new_deck,distance=..0.05,limit=1] hb_known_c 0
scoreboard players set @e[type=minecraft:marker,tag=hb.new_deck,distance=..0.05,limit=1] hb_known_n 0
scoreboard players set @e[type=minecraft:marker,tag=hb.new_deck,distance=..0.05,limit=1] hb_discard_order 0
execute as @e[type=minecraft:marker,tag=hb.new_deck,distance=..0.05,limit=1] run data remove entity @s data.hanabi
tag @e[type=minecraft:marker,tag=hb.new_deck,distance=..0.05,limit=1] remove hb.new_deck
