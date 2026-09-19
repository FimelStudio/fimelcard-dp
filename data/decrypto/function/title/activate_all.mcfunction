# 当前执行者为谍报风云控制器。
scoreboard players operation #ctx dc_ctx = @s dc_id
execute as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run function decrypto:title/activate_player
function decrypto:title/update_all
