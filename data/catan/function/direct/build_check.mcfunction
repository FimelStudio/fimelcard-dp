function catan:direct/turn_guard
execute unless score #direct_ready ca_ctx matches 1 run return 0
execute if entity @e[tag=ca.current,scores={ca_state=1..2},limit=1] run return 1
execute if entity @e[tag=ca.current,scores={ca_state=6},limit=1] run return 1
execute if entity @e[tag=ca.current,scores={ca_state=8},limit=1] run return 1
function catan:direct/main_guard
execute unless score #direct_ready ca_ctx matches 1 run return 0
execute if score @s ca_mode matches 2 run function catan:direct/cost {label:"建造村庄",cost:[1,1,1,1,0]}
execute if score @s ca_mode matches 3 run function catan:direct/cost {label:"修建道路",cost:[1,1,0,0,0]}
execute if score @s ca_mode matches 4 run function catan:direct/cost {label:"升级城市",cost:[0,0,0,2,3]}
execute if score #direct_ready ca_ctx matches 1 run function catan:direct/build_stock
