kill @e[type=minecraft:item,tag=dc.note_drop,limit=1]
function decrypto:input/give_notes
# 物品栏“密电记录”显示己方本局历轮已经结算的提示；左上角面板仍显示敌方笔记。
execute if score @s dc_team matches 1 run function decrypto:notes/show_own_white
execute if score @s dc_team matches 2 run function decrypto:notes/show_own_black
