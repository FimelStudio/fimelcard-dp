# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function catan:input/context
execute unless entity @s[tag=ca.actor] run return 0
execute if entity @e[tag=ca.current,scores={ca_state=7},limit=1] run return run function catan:direct/steal_look
execute unless score @s ca_side = @e[tag=ca.current,limit=1] ca_turn run return run function catan:direct/wait
execute if entity @e[tag=ca.current,scores={ca_anim=1..},limit=1] run return run function catan:direct/busy
execute if entity @e[tag=ca.current,scores={ca_vtimer=1..},limit=1] run return run function catan:direct/busy
execute unless entity @s[tag=ca.q_aim] run scoreboard players set @s ca_mode 0
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{catan:{build:2}}] run scoreboard players set @s ca_mode 2
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{catan:{build:3}}] run scoreboard players set @s ca_mode 3
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{catan:{build:4}}] run scoreboard players set @s ca_mode 4
execute if entity @e[tag=ca.current,scores={ca_state=1},limit=1] run scoreboard players set @s ca_mode 2
execute if entity @e[tag=ca.current,scores={ca_state=2},limit=1] run scoreboard players set @s ca_mode 3
execute if entity @e[tag=ca.current,scores={ca_state=6},limit=1] run scoreboard players set @s ca_mode 1
execute if entity @e[tag=ca.current,scores={ca_state=8},limit=1] run scoreboard players set @s ca_mode 3
execute unless score @s ca_mode matches 1..4 run return run function catan:direct/aim_note
function catan:input/ray
execute unless score #ray_ok ca_ctx matches 1 run return run function catan:input/miss_note
scoreboard players operation @s ca_pick = #target ca_ctx
scoreboard players operation #code ca_ctx = #target ca_ctx
scoreboard players add #code ca_ctx 1000
execute if score @s ca_confirm = #code ca_ctx if score @s ca_cmode = @s ca_mode if score @s ca_cepoch = @e[tag=ca.current,limit=1] ca_epoch run return run function catan:direct/place
scoreboard players operation @s ca_confirm = #code ca_ctx
scoreboard players operation @s ca_cmode = @s ca_mode
scoreboard players operation @s ca_cepoch = @e[tag=ca.current,limit=1] ca_epoch
execute as @e[tag=ca.current,limit=1] at @s run function catan:input/preview
function catan:hud/notice {"text":{"text":"已预览位置：再次右键或按Q确认，左键取消。","color":"aqua"}}
