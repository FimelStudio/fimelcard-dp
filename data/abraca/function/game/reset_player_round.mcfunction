# 保留玩家的ab_score累计层数，只重置新一局需要的状态。
clear @s minecraft:paper[minecraft:custom_data~{abraca:{stone:1b}}]
function abraca:input/clear_tools
tag @s remove ab.q_input
function abraca:title/deactivate_player
tag @s remove ab.turn
tag @s remove ab.actor
tag @s remove ab.audience
tag @s remove ab.knocked
tag @s remove ab.effect_caster
tag @s remove ab.round_winner
tag @s remove ab.win_hand
scoreboard players set @s ab_hp 6
scoreboard players set @s ab_last 0
scoreboard players set @s ab_secret 0
scoreboard players set @s ab_owl 0
scoreboard players set @s ab_action 0
