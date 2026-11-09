$data modify storage splendor:hud incoming set value $(text)
execute unless entity @s[tag=sp.hud] run function splendor:hud/activate
execute store result storage splendor:hud panel int 1 run scoreboard players get @s sp_hpanel
function splendor:hud/store_notice with storage splendor:hud
scoreboard players set @s sp_htimer 100
function splendor:hud/build
