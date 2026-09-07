# 成功石留作公开“已施放”记录，而不是删除。
scoreboard players operation #ctx ab_ctx = @s ab_id
execute as @a[tag=ab.audience] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.audience
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx run tag @s add ab.audience
tag @e[tag=ab.chosen,limit=1] remove ab.hand
tag @e[tag=ab.chosen,limit=1] add ab.played
clear @a[tag=ab.actor,limit=1] minecraft:paper[minecraft:custom_data~{abraca:{stone:1b}}] 1
scoreboard players operation @a[tag=ab.actor,limit=1] ab_last = #spell ab_ctx
execute store result storage abraca:debug id int 1 run scoreboard players get @s ab_id
execute store result storage abraca:debug seat int 1 run scoreboard players get @a[tag=ab.actor,limit=1] ab_seat
execute store result storage abraca:debug spell int 1 run scoreboard players get #spell ab_ctx
function abraca:debug/log_success with storage abraca:debug
tellraw @a[tag=ab.audience] [{text:'[出包魔法师] ',color:'dark_purple'},{selector:'@a[tag=ab.actor,limit=1]',color:'gold'},{text:'成功施放了咒语。',color:'green'}]
execute if score #spell ab_ctx matches 1 run scoreboard players add @s ab_play_1 1
execute if score #spell ab_ctx matches 2 run scoreboard players add @s ab_play_2 1
execute if score #spell ab_ctx matches 3 run scoreboard players add @s ab_play_3 1
execute if score #spell ab_ctx matches 4 run scoreboard players add @s ab_play_4 1
# 猫头鹰次数必须记在本桌当前施法者身上，不能被其他牌桌或残留actor标签截走。
execute if score #spell ab_ctx matches 4 as @a[tag=ab.actor] if score @s ab_id = #ctx ab_ctx run scoreboard players add @s ab_owl 1
execute if score #spell ab_ctx matches 4 as @a[tag=ab.actor] if score @s ab_id = #ctx ab_ctx run tellraw @s [{text:'[猫头鹰] ',color:'gold'},{text:'本局猫头鹰奖励已记录；若结算时存活，将额外前进1层。',color:'green'}]
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
# 成功施法时在施法者位置播放对应粒子；失败路径不会进入这里。
execute if score #spell ab_ctx matches 1 run function abraca:particle/dragon
execute if score #spell ab_ctx matches 2 run function abraca:particle/ghost
execute if score #spell ab_ctx matches 3 run function abraca:particle/dream
execute if score #spell ab_ctx matches 4 run function abraca:particle/owl
execute if score #spell ab_ctx matches 5 run function abraca:particle/storm
execute if score #spell ab_ctx matches 6 run function abraca:particle/blizzard
execute if score #spell ab_ctx matches 7 run function abraca:particle/fireball
execute if score #spell ab_ctx matches 8 run function abraca:particle/potion
# 此标签只在本次成功施法的伤害结算期间存在，用于识别“击倒其他玩家”的胜者。
execute as @a[tag=ab.effect_caster] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.effect_caster
tag @a[tag=ab.actor,limit=1] add ab.effect_caster
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
execute as @a[tag=ab.audience] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.audience
# 手中最后一枚咒语石成功打出时，该玩家立即以“打空手牌”获胜。
function abraca:game/check_empty_hand
execute unless score @s ab_state matches 2 run return 0
function abraca:effect/check_knockout
execute as @a[tag=ab.effect_caster] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.effect_caster
execute unless score @s ab_state matches 2 run return 0
function abraca:turn/continue
