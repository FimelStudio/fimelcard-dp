# 结束流程只能进入一次；通用层仍会定期复查已通过的投票。
execute unless score @s ab_state matches 1..2 run return 0
scoreboard players operation #ctx ab_ctx = @s ab_id
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx run tellraw @s [{text:'[出包魔法师] ',color:'dark_purple'},{text:'结束投票已通过。',color:'red'}]
function abraca:game/finish
