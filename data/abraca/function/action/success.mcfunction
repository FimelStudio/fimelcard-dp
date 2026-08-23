# 成功石留作公开“已施放”记录，而不是删除。
scoreboard players operation #ctx ab_ctx = @s ab_id
tag @a[tag=ab.audience] remove ab.audience
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx run tag @s add ab.audience
tag @e[tag=ab.chosen,limit=1] remove ab.hand
tag @e[tag=ab.chosen,limit=1] add ab.played
clear @a[tag=ab.actor,limit=1] minecraft:paper[minecraft:custom_data~{abraca:{stone:1b}}] 1
scoreboard players operation @a[tag=ab.actor,limit=1] ab_last = #spell ab_ctx
tellraw @a[tag=ab.audience] [{text:'[出包魔法师] ',color:'dark_purple'},{selector:'@a[tag=ab.actor,limit=1]',color:'gold'},{text:'成功施放了咒语。',color:'green'}]
execute if score #spell ab_ctx matches 1 run scoreboard players add @s ab_play_1 1
execute if score #spell ab_ctx matches 2 run scoreboard players add @s ab_play_2 1
execute if score #spell ab_ctx matches 3 run scoreboard players add @s ab_play_3 1
execute if score #spell ab_ctx matches 4 run scoreboard players add @s ab_play_4 1
execute if score #spell ab_ctx matches 5 run scoreboard players add @s ab_play_5 1
execute if score #spell ab_ctx matches 6 run scoreboard players add @s ab_play_6 1
execute if score #spell ab_ctx matches 7 run scoreboard players add @s ab_play_7 1
execute if score #spell ab_ctx matches 8 run scoreboard players add @s ab_play_8 1
execute if score #spell ab_ctx matches 1 run function abraca:sound/dragon
execute if score #spell ab_ctx matches 2 run function abraca:sound/ghost
execute if score #spell ab_ctx matches 3 run function abraca:sound/dream
execute if score #spell ab_ctx matches 4 run function abraca:sound/owl
execute if score #spell ab_ctx matches 5 run function abraca:sound/storm
execute if score #spell ab_ctx matches 6 run function abraca:sound/blizzard
execute if score #spell ab_ctx matches 7 run function abraca:sound/fireball
execute if score #spell ab_ctx matches 8 run function abraca:sound/potion
execute if score #spell ab_ctx matches 1 run function abraca:effect/dragon
execute if score #spell ab_ctx matches 2 run function abraca:effect/ghost
execute if score #spell ab_ctx matches 3 run function abraca:effect/dream
execute if score #spell ab_ctx matches 4 run function abraca:effect/owl
execute if score #spell ab_ctx matches 5 run function abraca:effect/storm
execute if score #spell ab_ctx matches 6 run function abraca:effect/blizzard
execute if score #spell ab_ctx matches 7 run function abraca:effect/fireball
execute if score #spell ab_ctx matches 8 run function abraca:effect/potion
function abraca:effect/clamp_health
function abraca:hud/update
function abraca:title/update_all
tag @a[tag=ab.audience] remove ab.audience
function abraca:effect/check_knockout
execute if score @s ab_state matches 0 run return 0
function abraca:turn/continue
