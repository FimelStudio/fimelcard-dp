function decrypto:player/audience
execute if score @s dc_state matches 2 run clear @a[tag=dc.audience] minecraft:purple_dye[minecraft:custom_data~{decrypto:{tool:'timeout'}}]
tag @e[tag=dc.sync_controller] remove dc.sync_controller
tag @s add dc.sync_controller
scoreboard players operation #prompt_input dc_ctx = @s dc_input
execute if score @s dc_state matches 2 unless data entity @s data.decrypto.sync.white.clues as @a[tag=dc.audience,scores={dc_team=1,dc_encoder=1}] run function decrypto:sync/restore_prompt
execute if score @s dc_state matches 2 unless data entity @s data.decrypto.sync.black.clues as @a[tag=dc.audience,scores={dc_team=2,dc_encoder=1}] run function decrypto:sync/restore_prompt
# 旧版单方超时曾取消双方拦截，重载时只恢复已有提示的密码的拦截。
execute if score @s dc_state matches 5 if score @s dc_round matches 2.. if data entity @s data.decrypto.sync.white.clues if data entity @s data.decrypto.sync.answers{p5:[-1,-1,-1]} run data remove entity @s data.decrypto.sync.answers.p5
execute if score @s dc_state matches 5 if score @s dc_round matches 2.. if score @s dc_mode matches 4 if data entity @s data.decrypto.sync.black.clues if data entity @s data.decrypto.sync.answers{p7:[-1,-1,-1]} run data remove entity @s data.decrypto.sync.answers.p7
execute if score @s dc_state matches 5 as @a[tag=dc.audience] run function decrypto:sync/give_guess
function decrypto:title/update_all
