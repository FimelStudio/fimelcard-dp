scoreboard players set @e[tag=dd.hand] dd_selected 0
$scoreboard players set #wing_need dd_ctx $(wings)
$scoreboard players set #wing_unit dd_ctx $(unit)
$execute if score #have3 dd_ctx matches $(copies).. run function doudizhu:bot/body_rank {rank:3,low:$(low),high:$(high),copies:$(copies)}
$execute if score #have4 dd_ctx matches $(copies).. run function doudizhu:bot/body_rank {rank:4,low:$(low),high:$(high),copies:$(copies)}
$execute if score #have5 dd_ctx matches $(copies).. run function doudizhu:bot/body_rank {rank:5,low:$(low),high:$(high),copies:$(copies)}
$execute if score #have6 dd_ctx matches $(copies).. run function doudizhu:bot/body_rank {rank:6,low:$(low),high:$(high),copies:$(copies)}
$execute if score #have7 dd_ctx matches $(copies).. run function doudizhu:bot/body_rank {rank:7,low:$(low),high:$(high),copies:$(copies)}
$execute if score #have8 dd_ctx matches $(copies).. run function doudizhu:bot/body_rank {rank:8,low:$(low),high:$(high),copies:$(copies)}
$execute if score #have9 dd_ctx matches $(copies).. run function doudizhu:bot/body_rank {rank:9,low:$(low),high:$(high),copies:$(copies)}
$execute if score #have10 dd_ctx matches $(copies).. run function doudizhu:bot/body_rank {rank:10,low:$(low),high:$(high),copies:$(copies)}
$execute if score #have11 dd_ctx matches $(copies).. run function doudizhu:bot/body_rank {rank:11,low:$(low),high:$(high),copies:$(copies)}
$execute if score #have12 dd_ctx matches $(copies).. run function doudizhu:bot/body_rank {rank:12,low:$(low),high:$(high),copies:$(copies)}
$execute if score #have13 dd_ctx matches $(copies).. run function doudizhu:bot/body_rank {rank:13,low:$(low),high:$(high),copies:$(copies)}
$execute if score #have14 dd_ctx matches $(copies).. run function doudizhu:bot/body_rank {rank:14,low:$(low),high:$(high),copies:$(copies)}
$execute if score #have15 dd_ctx matches $(copies).. run function doudizhu:bot/body_rank {rank:15,low:$(low),high:$(high),copies:$(copies)}
$execute if score #have16 dd_ctx matches $(copies).. run function doudizhu:bot/body_rank {rank:16,low:$(low),high:$(high),copies:$(copies)}
$execute if score #have17 dd_ctx matches $(copies).. run function doudizhu:bot/body_rank {rank:17,low:$(low),high:$(high),copies:$(copies)}
$execute if score #wing_need dd_ctx matches 1.. run function doudizhu:bot/wing_rank {rank:3,low:$(low),high:$(high)}
$execute if score #wing_need dd_ctx matches 1.. run function doudizhu:bot/wing_rank {rank:4,low:$(low),high:$(high)}
$execute if score #wing_need dd_ctx matches 1.. run function doudizhu:bot/wing_rank {rank:5,low:$(low),high:$(high)}
$execute if score #wing_need dd_ctx matches 1.. run function doudizhu:bot/wing_rank {rank:6,low:$(low),high:$(high)}
$execute if score #wing_need dd_ctx matches 1.. run function doudizhu:bot/wing_rank {rank:7,low:$(low),high:$(high)}
$execute if score #wing_need dd_ctx matches 1.. run function doudizhu:bot/wing_rank {rank:8,low:$(low),high:$(high)}
$execute if score #wing_need dd_ctx matches 1.. run function doudizhu:bot/wing_rank {rank:9,low:$(low),high:$(high)}
$execute if score #wing_need dd_ctx matches 1.. run function doudizhu:bot/wing_rank {rank:10,low:$(low),high:$(high)}
$execute if score #wing_need dd_ctx matches 1.. run function doudizhu:bot/wing_rank {rank:11,low:$(low),high:$(high)}
$execute if score #wing_need dd_ctx matches 1.. run function doudizhu:bot/wing_rank {rank:12,low:$(low),high:$(high)}
$execute if score #wing_need dd_ctx matches 1.. run function doudizhu:bot/wing_rank {rank:13,low:$(low),high:$(high)}
$execute if score #wing_need dd_ctx matches 1.. run function doudizhu:bot/wing_rank {rank:14,low:$(low),high:$(high)}
$execute if score #wing_need dd_ctx matches 1.. run function doudizhu:bot/wing_rank {rank:15,low:$(low),high:$(high)}
$execute if score #wing_need dd_ctx matches 1.. run function doudizhu:bot/wing_rank {rank:16,low:$(low),high:$(high)}
$execute if score #wing_need dd_ctx matches 1.. run function doudizhu:bot/wing_rank {rank:17,low:$(low),high:$(high)}
execute if score #wing_need dd_ctx matches 1.. run return 0
$execute if score #have16 dd_ctx matches 1 if score #have17 dd_ctx matches 1 if entity @e[tag=dd.hand,scores={dd_rank=16,dd_selected=1}] if entity @e[tag=dd.hand,scores={dd_rank=17,dd_selected=1}] run function doudizhu:bot/check_rocket_wing {blocked:$(no_rocket)}
execute if score #wing_need dd_ctx matches 1.. run return 0
function doudizhu:rules/classify
execute if score #type dd_ctx matches 0 run return 0
execute if score #bot_type dd_ctx matches 0 if score #type dd_ctx matches 1 run scoreboard players set #bot_found dd_ctx 1
execute if score #type dd_ctx = #bot_type dd_ctx if score #n dd_ctx = #bot_len dd_ctx if score #high dd_ctx > #bot_high dd_ctx run scoreboard players set #bot_found dd_ctx 1
execute if score #type dd_ctx matches 13 if score #bot_type dd_ctx matches 1..12 run scoreboard players set #bot_found dd_ctx 1
execute if score #type dd_ctx matches 14 if score #bot_type dd_ctx matches 1..13 run scoreboard players set #bot_found dd_ctx 1
