function doudizhu:action/context
execute unless entity @e[tag=dd.current,limit=1] run return 0
function doudizhu:hud/view_context
execute if score #hud_viewer dd_ctx = #hud_pov dd_ctx run function doudizhu:hand/build
execute unless score #hud_viewer dd_ctx = #hud_pov dd_ctx run function doudizhu:hand/spectate
function doudizhu:hud/build
tag @e[tag=dd.hand] remove dd.hand
tag @e[tag=dd.current] remove dd.current
