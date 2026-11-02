function catan:input/context
execute unless entity @s[tag=ca.actor] run return 0
execute unless score @s ca_side = @e[tag=ca.current,limit=1] ca_turn run return 0
execute unless entity @e[tag=ca.current,scores={ca_anim=0},limit=1] run return 0
execute if entity @e[tag=ca.current,scores={ca_vtimer=1..},limit=1] run return 0
scoreboard players set #aim ca_ctx 0
execute if entity @e[tag=ca.current,scores={ca_state=1..2},limit=1] run scoreboard players set #aim ca_ctx 1
execute if entity @e[tag=ca.current,scores={ca_state=4},limit=1] run scoreboard players set #aim ca_ctx 1
execute if entity @e[tag=ca.current,scores={ca_state=6},limit=1] run scoreboard players set #aim ca_ctx 1
execute if entity @e[tag=ca.current,scores={ca_state=8},limit=1] run scoreboard players set #aim ca_ctx 1
execute unless score #aim ca_ctx matches 1 run return run function catan:ui/open
execute if entity @e[tag=ca.current,scores={ca_state=1},limit=1] run scoreboard players set @s ca_mode 2
execute if entity @e[tag=ca.current,scores={ca_state=2},limit=1] run scoreboard players set @s ca_mode 3
execute if entity @e[tag=ca.current,scores={ca_state=6},limit=1] run scoreboard players set @s ca_mode 1
execute if entity @e[tag=ca.current,scores={ca_state=8},limit=1] run scoreboard players set @s ca_mode 3
execute unless score @s ca_mode matches 1..4 run return run function catan:ui/open
function catan:input/ray
execute unless score #ray_ok ca_ctx matches 1 run return 0
scoreboard players operation @s ca_pick = #target ca_ctx
execute as @e[tag=ca.current,limit=1] at @s run function catan:input/preview
function catan:ui/confirm
