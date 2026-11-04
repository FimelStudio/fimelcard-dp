# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function catan:input/context
execute unless entity @s[tag=ca.actor] run return 0
execute unless score @s ca_side = @e[tag=ca.current,limit=1] ca_turn run return run function catan:input/wait_note
execute unless entity @e[tag=ca.current,scores={ca_anim=0},limit=1] run return run function catan:input/wait_note
execute if entity @e[tag=ca.current,scores={ca_vtimer=1..},limit=1] run return run function catan:input/wait_note
scoreboard players set @s ca_mode 0
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{catan:{build:2}}] run scoreboard players set @s ca_mode 2
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{catan:{build:3}}] run scoreboard players set @s ca_mode 3
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{catan:{build:4}}] run scoreboard players set @s ca_mode 4
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
execute unless score @s ca_mode matches 1..4 run return run title @s actionbar {text:"手持村庄、道路或城市，再右键桌面建造",color:"yellow"}
function catan:input/ray
execute unless score #ray_ok ca_ctx matches 1 run return run function catan:input/miss_note
scoreboard players operation @s ca_pick = #target ca_ctx
execute as @e[tag=ca.current,limit=1] at @s run function catan:input/preview
scoreboard players operation @s ca_seen = @e[tag=ca.current,limit=1] ca_epoch
function catan:ui/place
