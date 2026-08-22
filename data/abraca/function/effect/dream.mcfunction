scoreboard players random #roll ab_ctx 1 3
scoreboard players operation @a[tag=ab.actor,limit=1] ab_hp += #roll ab_ctx
tellraw @a[tag=ab.actor,limit=1] [{text:'[甜蜜的梦] ',color:'light_purple'},{text:'骰子为 ',color:'gray'},{score:{name:'#roll',objective:'ab_ctx'},color:'gold'},{text:'；回复等量生命。',color:'gray'}]
