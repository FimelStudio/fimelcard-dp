tag @a[tag=av.target] remove av.target
execute as @a[tag=av.audience] if score @s av_seat = #action av_ctx run tag @s add av.target
execute unless entity @a[tag=av.target,limit=1] run return 0
scoreboard players set #toggle av_ctx 1
scoreboard players operation #toggle av_ctx -= @a[tag=av.target,limit=1] av_selected
scoreboard players operation @a[tag=av.target,limit=1] av_selected = #toggle av_ctx
function avalon:hud/update
tag @a[tag=av.target] remove av.target
