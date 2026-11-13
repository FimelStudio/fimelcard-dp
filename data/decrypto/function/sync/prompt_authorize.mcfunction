function decrypto:sync/bind
scoreboard players set #form_ok dc_ctx 0
tag @e[tag=dc.form_controller] remove dc.form_controller
execute unless score #sync_ok dc_ctx matches 1 run return 0
execute unless score @s dc_encoder matches 1 run return 0
execute unless entity @e[tag=dc.sync_controller,scores={dc_state=2,dc_input=1},limit=1] run return 0
execute if score @s dc_team matches 1 if data entity @e[tag=dc.sync_controller,limit=1] data.decrypto.sync.white.clues run return 0
execute if score @s dc_team matches 2 if data entity @e[tag=dc.sync_controller,limit=1] data.decrypto.sync.black.clues run return 0
scoreboard players operation #sync_team dc_ctx = @s dc_team
tag @e[tag=dc.sync_controller,limit=1] add dc.form_controller
scoreboard players set #form_ok dc_ctx 1
