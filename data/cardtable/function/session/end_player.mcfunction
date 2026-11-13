execute if score @s ct_paused matches 1 run title @s actionbar {text:""}
scoreboard players reset @s ct_session
scoreboard players set @s ct_paused 0
scoreboard players reset @s ct_rejoin
tag @s remove ct.rejoining
function cardtable:settings/clear_session
function cardtable:chairs/settings/clear_session
