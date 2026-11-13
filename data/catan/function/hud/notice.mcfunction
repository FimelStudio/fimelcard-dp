$data modify storage catan:hud incoming set value $(text)
function catan:hud/activate
execute store result storage catan:hud panel int 1 run scoreboard players get @s ca_hpanel
function catan:hud/store_notice with storage catan:hud
scoreboard players set @s ca_htimer 80
function catan:hud/build
