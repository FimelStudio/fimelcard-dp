scoreboard players operation #ctx ab_ctx = @s ab_id
execute as @a[tag=ab.hit] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.hit
execute as @a[tag=ab.target] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.target
function abraca:effect/target_right
execute as @a[tag=ab.target] if score @s ab_id = #ctx ab_ctx run scoreboard players remove @s ab_hp 1
execute as @a[tag=ab.target] if score @s ab_id = #ctx ab_ctx run tag @s add ab.hit
execute as @a[tag=ab.target] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.target
function abraca:effect/target_left
execute as @a[tag=ab.target,tag=!ab.hit] if score @s ab_id = #ctx ab_ctx run scoreboard players remove @s ab_hp 1
execute as @a[tag=ab.target] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.target
execute as @a[tag=ab.hit] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.hit
tellraw @a[tag=ab.player] [{text:'[闪电暴风雨] ',color:'aqua'},{text:'左右相邻玩家各失去1点生命。',color:'gray'}]
