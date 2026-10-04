tag @s add dd.card
scoreboard players operation @s dd_id = #ctx dd_ctx
$scoreboard players set @s dd_card $(id)
$scoreboard players set @s dd_rank $(rank)
scoreboard players set @s dd_owner 0
scoreboard players set @s dd_selected 0
