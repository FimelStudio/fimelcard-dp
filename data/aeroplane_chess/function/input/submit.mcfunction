scoreboard players operation @s ac_ui_tmp = @s ac_action
scoreboard players set @s ac_action 0
scoreboard players enable @s ac_action
function aeroplane_chess:input/context
execute unless entity @s[tag=ac.actor] run return run function aeroplane_chess:input/invalid
execute unless score @s ac_ui_load = #ui_load ac_ctx run return run function aeroplane_chess:input/invalid
scoreboard players operation #ui_epoch ac_ctx = @s ac_ui_tmp
scoreboard players operation #ui_epoch ac_ctx /= #hundred ac_ctx
execute unless score #ui_epoch ac_ctx = @s ac_seen run return run function aeroplane_chess:input/invalid
execute unless score #ui_epoch ac_ctx = @e[tag=ac.current,limit=1] ac_epoch run return run function aeroplane_chess:input/invalid
scoreboard players operation #ui_action ac_ctx = @s ac_ui_tmp
scoreboard players operation #ui_action ac_ctx %= #hundred ac_ctx
execute unless score #ui_action ac_ctx matches 1..8 run return run function aeroplane_chess:input/invalid
execute if score #ui_action ac_ctx matches 1 as @e[tag=ac.current,limit=1] at @s run function aeroplane_chess:game/roll
execute if score #ui_action ac_ctx matches 2..5 run function aeroplane_chess:input/submit_plane
execute if score #ui_action ac_ctx matches 6 run function aeroplane_chess:ui/resign
execute if score #ui_action ac_ctx matches 7 as @e[tag=ac.current,limit=1] at @s run function aeroplane_chess:game/resign
execute if score #ui_action ac_ctx matches 8 run function aeroplane_chess:ui/quick
