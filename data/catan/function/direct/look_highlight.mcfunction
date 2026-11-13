scoreboard players set #looking ca_ctx 0
execute if entity @e[tag=ca.current,scores={ca_state=7},limit=1] run scoreboard players set #looking ca_ctx 1
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{catan:{action:200}}] run scoreboard players set #looking ca_ctx 1
execute unless score #looking ca_ctx matches 1 run return 0
function catan:direct/look
execute unless score #look_side ca_ctx matches 1..4 run return 0
execute store result storage catan:direct target int 1 run scoreboard players get #look_side ca_ctx
function catan:direct/glow_target with storage catan:direct
