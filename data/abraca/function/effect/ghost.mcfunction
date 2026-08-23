scoreboard players operation #ctx ab_ctx = @s ab_id
execute as @a[tag=ab.player,tag=!ab.actor] if score @s ab_id = #ctx ab_ctx run scoreboard players remove @s ab_hp 1
execute as @a[tag=ab.player,tag=!ab.actor] if score @s ab_id = #ctx ab_ctx run tellraw @a[tag=ab.audience] [{text:'[黑暗幽灵] ',color:'dark_gray'},{selector:'@s',color:'gold'},{text:'失去1点生命。',color:'red'}]
scoreboard players add @a[tag=ab.actor,limit=1] ab_hp 1
tellraw @a[tag=ab.player] [{text:'[黑暗幽灵] ',color:'dark_gray'},{text:'其他玩家失去1点生命，施法者回复1点生命。',color:'gray'}]
