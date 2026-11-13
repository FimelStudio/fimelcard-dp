execute unless score @s sp_select_kind matches 4 run function splendor:direct/reset
scoreboard players set @s sp_select_kind 4
function splendor:direct/hand
execute if score @s sp_target matches 0 if score @s sp_pick0 matches 1.. run scoreboard players remove @s sp_pick0 1
execute if score @s sp_target matches 1 if score @s sp_pick1 matches 1.. run scoreboard players remove @s sp_pick1 1
execute if score @s sp_target matches 2 if score @s sp_pick2 matches 1.. run scoreboard players remove @s sp_pick2 1
execute if score @s sp_target matches 3 if score @s sp_pick3 matches 1.. run scoreboard players remove @s sp_pick3 1
execute if score @s sp_target matches 4 if score @s sp_pick4 matches 1.. run scoreboard players remove @s sp_pick4 1
execute if score @s sp_target matches 5 if score @s sp_pick5 matches 1.. run scoreboard players remove @s sp_pick5 1
execute as @e[tag=sp.current,limit=1] at @s run function splendor:visual/selection
function splendor:hud/notice {"text":{"text":"已取消这颗宝石的选择。","color":"yellow"}}
