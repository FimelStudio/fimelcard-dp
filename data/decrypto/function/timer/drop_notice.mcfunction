execute on origin if score @s ct_paused matches 1 run return 0
execute store result storage decrypto:timer notice.round int 1 store result score #notice_round dc_ctx run data get entity @s Item.components."minecraft:custom_data".decrypto.round
execute on origin if entity @s[tag=dc.player,tag=ct.player] if score @s dc_id = @s ct_id run function decrypto:timer/open_notice
kill @s
