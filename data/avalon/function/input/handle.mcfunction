scoreboard players operation #action av_ctx = @s av_action
scoreboard players reset @s av_action
scoreboard players operation #action av_ctx -= @s av_ui_base
execute unless entity @s[tag=ct.player] run return run function avalon:player/clear
execute unless score @s av_id = @s ct_id run return run function avalon:player/clear
function avalon:bind
execute unless entity @e[tag=av.current,limit=1] run return run function avalon:player/clear
execute unless score @s av_ui_epoch = @e[tag=av.current,limit=1] av_epoch run return run function avalon:input/reopen
execute unless score #action av_ctx matches 1..99 run return run function avalon:input/reopen
tag @a[tag=av.actor] remove av.actor
tag @s add av.actor
execute as @e[tag=av.current,limit=1] run function avalon:context
execute if score #action av_ctx matches 40 if score @s av_role matches 5 if score @e[tag=av.current,limit=1] av_state matches 1..3 run return run function avalon:dialog/confirm_early
execute as @e[tag=av.current,limit=1] at @s run function avalon:input/dispatch
execute if entity @s[tag=av.player] run function avalon:bind
execute if entity @s[tag=av.player] run function avalon:dialog/open
tag @s remove av.actor
tag @e[tag=av.current] remove av.current
