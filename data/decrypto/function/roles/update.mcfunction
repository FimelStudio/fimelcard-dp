# dc_mode=4表示4至8人的双队模式，沿用原胜负及回合流程。
scoreboard players operation #ctx dc_ctx = @s dc_id
scoreboard players operation #role_round dc_ctx = @s dc_round
execute if score @s dc_mode matches 4 as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run function decrypto:roles/rotate
execute if score @s dc_mode matches 3 as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run function decrypto:roles/three
