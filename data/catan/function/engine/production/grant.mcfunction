scoreboard players set #total ca_ctx 0
scoreboard players set #receivers ca_ctx 0
$scoreboard players operation #total ca_ctx += #need1_$(resource) ca_ctx
$execute if score #need1_$(resource) ca_ctx matches 1.. run scoreboard players add #receivers ca_ctx 1
$scoreboard players operation #total ca_ctx += #need2_$(resource) ca_ctx
$execute if score #need2_$(resource) ca_ctx matches 1.. run scoreboard players add #receivers ca_ctx 1
$scoreboard players operation #total ca_ctx += #need3_$(resource) ca_ctx
$execute if score #need3_$(resource) ca_ctx matches 1.. run scoreboard players add #receivers ca_ctx 1
$scoreboard players operation #total ca_ctx += #need4_$(resource) ca_ctx
$execute if score #need4_$(resource) ca_ctx matches 1.. run scoreboard players add #receivers ca_ctx 1
$scoreboard players set #grant1_$(resource) ca_ctx 0
$execute if score #bank$(resource) ca_ctx >= #total ca_ctx run scoreboard players operation #grant1_$(resource) ca_ctx = #need1_$(resource) ca_ctx
$execute if score #bank$(resource) ca_ctx < #total ca_ctx if score #receivers ca_ctx matches 1 if score #need1_$(resource) ca_ctx matches 1.. run scoreboard players operation #grant1_$(resource) ca_ctx = #bank$(resource) ca_ctx
$scoreboard players set #grant2_$(resource) ca_ctx 0
$execute if score #bank$(resource) ca_ctx >= #total ca_ctx run scoreboard players operation #grant2_$(resource) ca_ctx = #need2_$(resource) ca_ctx
$execute if score #bank$(resource) ca_ctx < #total ca_ctx if score #receivers ca_ctx matches 1 if score #need2_$(resource) ca_ctx matches 1.. run scoreboard players operation #grant2_$(resource) ca_ctx = #bank$(resource) ca_ctx
$scoreboard players set #grant3_$(resource) ca_ctx 0
$execute if score #bank$(resource) ca_ctx >= #total ca_ctx run scoreboard players operation #grant3_$(resource) ca_ctx = #need3_$(resource) ca_ctx
$execute if score #bank$(resource) ca_ctx < #total ca_ctx if score #receivers ca_ctx matches 1 if score #need3_$(resource) ca_ctx matches 1.. run scoreboard players operation #grant3_$(resource) ca_ctx = #bank$(resource) ca_ctx
$scoreboard players set #grant4_$(resource) ca_ctx 0
$execute if score #bank$(resource) ca_ctx >= #total ca_ctx run scoreboard players operation #grant4_$(resource) ca_ctx = #need4_$(resource) ca_ctx
$execute if score #bank$(resource) ca_ctx < #total ca_ctx if score #receivers ca_ctx matches 1 if score #need4_$(resource) ca_ctx matches 1.. run scoreboard players operation #grant4_$(resource) ca_ctx = #bank$(resource) ca_ctx
