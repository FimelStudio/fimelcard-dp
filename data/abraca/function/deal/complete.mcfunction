scoreboard players set @s ab_state 2
scoreboard players set @s ab_phase 0
scoreboard players set @s ab_timer 0
function abraca:hud/spawn
function abraca:hud/update
function abraca:title/update_all
execute if score @s ab_round matches 1 run tellraw @a[tag=ab.player] [{text:'[出包魔法师] ',color:'dark_purple'},{text:'起始咒语石发放完成，游戏开始！',color:'gold'}]
execute if score @s ab_round matches 2.. run tellraw @a[tag=ab.player] [{text:'[出包魔法师] ',color:'dark_purple'},{text:'新一局咒语石发放完成！',color:'gold'}]
function abraca:turn/begin
