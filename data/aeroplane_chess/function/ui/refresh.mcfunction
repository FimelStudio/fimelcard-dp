function aeroplane_chess:system/context
execute as @a[tag=ac.audience] run function aeroplane_chess:input/give
scoreboard players set @a[tag=ac.audience] ac_action 0
scoreboard players enable @a[tag=ac.audience] ac_action
function aeroplane_chess:ui/board_status
