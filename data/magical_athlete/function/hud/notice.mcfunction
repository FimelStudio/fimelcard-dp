$data modify storage magical_athlete:hud incoming set value $(text)
function magical_athlete:hud/activate
execute store result storage magical_athlete:hud panel int 1 run scoreboard players get @s ma_hpanel
function magical_athlete:hud/store_notice with storage magical_athlete:hud
scoreboard players set @s ma_htimer 80
function magical_athlete:hud/build
