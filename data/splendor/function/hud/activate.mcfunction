execute unless data storage fimel_title:io panels run function fimel_title:code/load
execute if entity @s[tag=sp.hud] run return 0
scoreboard players set @s sp_hprev 0
execute if score @s fbt_panel matches 1.. run scoreboard players operation @s sp_hprev = @s fbt_panel
function fimel_title:new_panel {id:"@s sp_hpanel"}
scoreboard players set @s sp_htimer 0
tag @s add sp.hud
