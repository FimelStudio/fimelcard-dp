# 向本桌所有玩家说明本次顺序错误时声明的咒语。
execute if score #spell ab_ctx matches 1 run tellraw @a[tag=ab.audience] [{text:'[出包魔法师] ',color:'dark_purple'},{selector:'@a[tag=ab.actor,limit=1]',color:'gold'},{text:'施放「古代巨龙」失败：咒语顺序不能倒退，失去1点生命。',color:'red'}]
execute if score #spell ab_ctx matches 2 run tellraw @a[tag=ab.audience] [{text:'[出包魔法师] ',color:'dark_purple'},{selector:'@a[tag=ab.actor,limit=1]',color:'gold'},{text:'施放「黑暗幽灵」失败：咒语顺序不能倒退，失去1点生命。',color:'red'}]
execute if score #spell ab_ctx matches 3 run tellraw @a[tag=ab.audience] [{text:'[出包魔法师] ',color:'dark_purple'},{selector:'@a[tag=ab.actor,limit=1]',color:'gold'},{text:'施放「甜蜜的梦」失败：咒语顺序不能倒退，失去1点生命。',color:'red'}]
execute if score #spell ab_ctx matches 4 run tellraw @a[tag=ab.audience] [{text:'[出包魔法师] ',color:'dark_purple'},{selector:'@a[tag=ab.actor,limit=1]',color:'gold'},{text:'施放「猫头鹰」失败：咒语顺序不能倒退，失去1点生命。',color:'red'}]
execute if score #spell ab_ctx matches 5 run tellraw @a[tag=ab.audience] [{text:'[出包魔法师] ',color:'dark_purple'},{selector:'@a[tag=ab.actor,limit=1]',color:'gold'},{text:'施放「闪电暴风雨」失败：咒语顺序不能倒退，失去1点生命。',color:'red'}]
execute if score #spell ab_ctx matches 6 run tellraw @a[tag=ab.audience] [{text:'[出包魔法师] ',color:'dark_purple'},{selector:'@a[tag=ab.actor,limit=1]',color:'gold'},{text:'施放「暴风雪」失败：咒语顺序不能倒退，失去1点生命。',color:'red'}]
execute if score #spell ab_ctx matches 7 run tellraw @a[tag=ab.audience] [{text:'[出包魔法师] ',color:'dark_purple'},{selector:'@a[tag=ab.actor,limit=1]',color:'gold'},{text:'施放「火球」失败：咒语顺序不能倒退，失去1点生命。',color:'red'}]
execute if score #spell ab_ctx matches 8 run tellraw @a[tag=ab.audience] [{text:'[出包魔法师] ',color:'dark_purple'},{selector:'@a[tag=ab.actor,limit=1]',color:'gold'},{text:'施放「魔法药水」失败：咒语顺序不能倒退，失去1点生命。',color:'red'}]
