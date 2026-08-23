scoreboard players operation #ctx ab_ctx = @s ab_id
execute as @a[tag=ab.target] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.target
function abraca:effect/target_left
execute as @a[tag=ab.target] if score @s ab_id = #ctx ab_ctx run scoreboard players remove @s ab_hp 1
execute as @a[tag=ab.target] if score @s ab_id = #ctx ab_ctx run tellraw @a[tag=ab.audience] [{text:'[暴风雪] ',color:'white'},{selector:'@s',color:'gold'},{text:'失去1点生命。',color:'red'}]
execute as @a[tag=ab.target] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.target
tellraw @a[tag=ab.player] [{text:'[暴风雪] ',color:'white'},{text:'左侧相邻玩家失去1点生命。',color:'gray'}]
