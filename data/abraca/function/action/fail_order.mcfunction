tellraw @a[tag=ab.actor,limit=1] [{text:'[出包魔法师] ',color:'dark_purple'},{text:'咒语数字不能小于本回合刚成功施放的数字：失去1点生命。',color:'red'}]
scoreboard players remove @a[tag=ab.actor,limit=1] ab_hp 1
function abraca:hud/update
function abraca:turn/end
