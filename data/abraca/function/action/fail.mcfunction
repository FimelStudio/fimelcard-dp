execute if score #spell ab_ctx matches 1 run function abraca:action/fail_dragon
execute if score #spell ab_ctx matches 1 run return 0
tellraw @a[tag=ab.actor,limit=1] [{text:'[出包魔法师] ',color:'dark_purple'},{text:'施法失败：你没有这枚咒语石，失去1点生命。',color:'red'}]
scoreboard players remove @a[tag=ab.actor,limit=1] ab_hp 1
function abraca:hud/update
function abraca:turn/end
