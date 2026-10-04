$scoreboard players set #wing_rank dd_ctx $(rank)
$execute if score #wing_rank dd_ctx matches $(low)..$(high) run return 0
$execute if score #wing_unit dd_ctx matches 2 if score #have$(rank) dd_ctx matches 2.. run function doudizhu:bot/pair_wing {rank:$(rank)}
$execute if score #wing_unit dd_ctx matches 1 if score #wing_need dd_ctx matches 1.. as @e[tag=dd.hand,scores={dd_rank=$(rank),dd_selected=0},limit=1] run function doudizhu:bot/single_wing
$execute if score #wing_unit dd_ctx matches 1 if score #wing_need dd_ctx matches 1.. as @e[tag=dd.hand,scores={dd_rank=$(rank),dd_selected=0},limit=1] run function doudizhu:bot/single_wing
