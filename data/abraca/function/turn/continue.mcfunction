# 成功施法后允许继续；输入0结束回合。
execute as @a[tag=ab.actor,limit=1] run scoreboard players enable @s ab_action
tellraw @a[tag=ab.actor,limit=1] [{text:'[出包魔法师] ',color:'dark_purple'},{text:'可继续施法或结束回合。',color:'gray'}]
