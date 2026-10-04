$scoreboard players set #body_rank dd_ctx $(rank)
$execute if score #body_rank dd_ctx matches $(low)..$(high) run scoreboard players set @e[tag=dd.hand,scores={dd_rank=$(rank)},limit=$(copies)] dd_selected 1
