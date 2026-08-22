# 基础版轮次结算：任一生命归零即结束；存活者各前进1层。
scoreboard players operation #ctx ab_ctx = @s ab_id
tellraw @a[tag=ab.player] [{text:'[出包魔法师] ',color:'dark_purple'},{text:'本轮结束；存活者前进1层。',color:'yellow'}]
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx if score @s ab_hp matches 1.. run scoreboard players add @s ab_score 1
function abraca:game/finish
