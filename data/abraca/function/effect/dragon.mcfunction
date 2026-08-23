execute store result score #roll ab_ctx run random value 1..3
scoreboard players operation #ctx ab_ctx = @s ab_id
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx run tellraw @s [{text:'[古代巨龙·施法成功] ',color:'red',bold:true},{text:'随机伤害为 ',color:'gray'},{score:{name:'#roll',objective:'ab_ctx'},color:'gold'},{text:' 点；除施法者外的所有玩家各失去该数值的生命。',color:'gray'}]
execute as @a[tag=ab.player,tag=!ab.actor] if score @s ab_id = #ctx ab_ctx run scoreboard players operation @s ab_hp -= #roll ab_ctx
execute as @a[tag=ab.player,tag=!ab.actor] if score @s ab_id = #ctx ab_ctx run tellraw @a[tag=ab.audience] [{text:'[古代巨龙] ',color:'red'},{selector:'@s',color:'gold'},{text:'受到 ',color:'gray'},{score:{name:'#roll',objective:'ab_ctx'},color:'gold'},{text:' 点伤害。',color:'red'}]
