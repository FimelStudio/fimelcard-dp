tag @s add un.card
tag @s add un.cards
scoreboard players operation @s ct_id = #table un_ctx
$scoreboard players set @s un_idx $(idx)
$scoreboard players set @s un_card $(card)
$scoreboard players set @s un_color $(color)
$scoreboard players set @s un_value $(value)
scoreboard players set @s un_owner 0
scoreboard players set @s un_order 0
