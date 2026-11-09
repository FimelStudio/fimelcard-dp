execute unless data storage fimel_title:io panels run function fimel_title:code/load
execute if entity @s[tag=ma.hud] run return 0
scoreboard players set @s ma_hprev 0
execute if score @s fbt_panel matches 1.. run scoreboard players operation @s ma_hprev = @s fbt_panel
function fimel_title:new_panel {id:"@s ma_hpanel"}
scoreboard players set @s ma_htimer 0
tag @s add ma.hud
