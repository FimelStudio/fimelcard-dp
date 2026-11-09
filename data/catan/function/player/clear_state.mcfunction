function catan:sound/stop_player
clear @s *[minecraft:custom_data~{catan:{tool:1b}}]
function catan:settings/clear_session
scoreboard players reset @s ca_action
scoreboard players reset @s ca_nonce
scoreboard players reset @s ca_drop
tag @s remove ca.player
tag @s remove ca.audience
tag @s remove ca.actor

scoreboard players reset @s ca_inv_epoch
# direct-v2
clear @s *[minecraft:custom_data~{catan:{tool:1b}}]
function catan:hud/deactivate
scoreboard players reset @s ca_depoch
