# uninstall-guard: begin (tools/build_uninstall.py)
execute if data storage cardtable:uninstall active run return 0
execute unless score #version ct_ctx matches 1.. run return 0
# uninstall-guard: end
scoreboard players add #player.count fca_store 1

scoreboard players operation @s fca_player_id = #player.count fca_store
