summon minecraft:marker ~ ~ ~ {data:{hanabi:{new_reward:1b}}}
tag @e[type=minecraft:marker,nbt={data:{hanabi:{new_reward:1b}}},distance=..0.05,sort=nearest,limit=1] add hb.new_reward
tag @e[type=minecraft:marker,tag=hb.new_reward,distance=..0.05,limit=1] add hb.reward_deck
tag @e[type=minecraft:marker,tag=hb.new_reward,distance=..0.05,limit=1] add hb.game_entity
scoreboard players operation @e[type=minecraft:marker,tag=hb.new_reward,distance=..0.05,limit=1] hb_id = @s hb_id
scoreboard players operation @e[type=minecraft:marker,tag=hb.new_reward,distance=..0.05,limit=1] hb_reward = #reward_type hb_ctx
execute as @e[type=minecraft:marker,tag=hb.new_reward,distance=..0.05,limit=1] run data remove entity @s data.hanabi
tag @e[type=minecraft:marker,tag=hb.new_reward,distance=..0.05,limit=1] remove hb.new_reward
scoreboard players add @s hb_reward_left 1
