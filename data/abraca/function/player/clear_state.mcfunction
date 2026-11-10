clear @s minecraft:paper[minecraft:custom_data~{abraca:{stone:1b}}]
function abraca:input/clear_tools
tag @s remove ab.q_input
function abraca:title/deactivate_player
tag @s remove ab.player
tag @s remove ab.turn
tag @s remove ab.actor
tag @s remove ab.audience
tag @s remove ab.knocked
tag @s remove ab.effect_caster
tag @s remove ab.round_winner
tag @s remove ab.win_hand
scoreboard players reset @s ab_id
scoreboard players reset @s ab_hp
scoreboard players reset @s ab_score
scoreboard players reset @s ab_last
scoreboard players reset @s ab_seat
scoreboard players reset @s ab_secret
scoreboard players reset @s ab_owl
scoreboard players reset @s ab_action
