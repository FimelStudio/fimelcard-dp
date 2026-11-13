scoreboard players set #direct_ready ca_ctx 0
execute if score @s ct_paused matches 1 run return run function catan:direct/paused_note
execute if entity @e[tag=ca.current,scores={ct_paused=1},limit=1] run return run function catan:direct/paused_note
execute unless score @s ca_side = @e[tag=ca.current,limit=1] ca_turn run return run function catan:direct/wait
execute if entity @e[tag=ca.current,scores={ca_state=11},limit=1] run return run function catan:direct/finished_note
execute if entity @e[tag=ca.current,scores={ca_anim=1..},limit=1] run return run function catan:direct/busy
execute if entity @e[tag=ca.current,scores={ca_vtimer=1..},limit=1] run return run function catan:direct/busy
execute if entity @e[tag=ca.current,scores={ca_state=10},limit=1] run return run function catan:direct/busy
scoreboard players set #direct_ready ca_ctx 1
