scoreboard players operation #ctx ab_ctx = @s ab_id
execute as @a[tag=ab.target] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.target
function abraca:effect/target_right
execute as @a[tag=ab.target] if score @s ab_id = #ctx ab_ctx run scoreboard players remove @s ab_hp 1
execute as @a[tag=ab.target] if score @s ab_id = #ctx ab_ctx run tellraw @a[tag=ab.audience] [{text:'[火球] ',color:'red'},{selector:'@s',color:'gold'},{text:'失去1点生命。',color:'red'}]
execute as @a[tag=ab.target] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.target
tellraw @a[tag=ab.player] [{text:'[火球] ',color:'red'},{text:'右侧相邻玩家失去1点生命。',color:'gray'}]
