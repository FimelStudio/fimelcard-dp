scoreboard players random #roll ab_ctx 1 3
tellraw @a[tag=ab.player] [{text:'[古代巨龙] ',color:'red'},{text:'骰子为 ',color:'gray'},{score:{name:'#roll',objective:'ab_ctx'},color:'gold'},{text:'；其他玩家失去等量生命。',color:'gray'}]
scoreboard players operation #ctx ab_ctx = @s ab_id
execute as @a[tag=ab.player,tag=!ab.actor] if score @s ab_id = #ctx ab_ctx run scoreboard players operation @s ab_hp -= #roll ab_ctx
