scoreboard players set #manual_ui av_ctx 0
scoreboard players add @s av_epoch 1
function avalon:context
dialog clear @a[tag=av.audience]
function avalon:hud/update
tag @e[tag=av.current] remove av.current
tag @s add av.current
execute as @a[tag=av.audience] run function avalon:dialog/open
tag @s remove av.current
