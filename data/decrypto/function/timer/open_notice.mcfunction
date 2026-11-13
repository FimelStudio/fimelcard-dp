function decrypto:sync/bind
execute unless score #sync_ok dc_ctx matches 1 run return 0
execute if score @e[tag=dc.sync_controller,limit=1] dc_state matches 5 if score @e[tag=dc.sync_controller,limit=1] dc_round = #notice_round dc_ctx run function decrypto:timer/show_notice with storage decrypto:timer notice
