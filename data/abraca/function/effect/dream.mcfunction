execute store result score #roll ab_ctx run random value 1..3
scoreboard players operation @a[tag=ab.actor,limit=1] ab_hp += #roll ab_ctx
tellraw @a[tag=ab.actor,limit=1] [{text:'[甜蜜的梦] ',color:'light_purple',bold:true},{text:'随机回复为',color:'gray'},{score:{name:'#roll',objective:'ab_ctx'},color:'gold'},{text:'点；你回复该数值的生命（最多6点）。',color:'gray'}]
