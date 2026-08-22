summon minecraft:marker ~ ~ ~ {Tags:['ab.game_entity','ab.deck']}
scoreboard players add #card ab_ctx 1
scoreboard players operation @e[type=minecraft:marker,tag=ab.deck,tag=!ab.ready,sort=nearest,limit=1] ab_id = @s ab_id
scoreboard players operation @e[type=minecraft:marker,tag=ab.deck,tag=!ab.ready,sort=nearest,limit=1] ab_card = #card ab_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ab.deck,tag=!ab.ready,sort=nearest,limit=1] ab_spell = #spell ab_ctx
tag @e[type=minecraft:marker,tag=ab.deck,tag=!ab.ready,sort=nearest,limit=1] add ab.ready
scoreboard players add @s ab_deck_count 1
