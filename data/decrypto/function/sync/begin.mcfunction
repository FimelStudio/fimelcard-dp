scoreboard players set @s dc_sync 1
scoreboard players add #form_sequence dc_ctx 1
scoreboard players operation @s dc_form = #form_sequence dc_ctx
scoreboard players set @s dc_state 2
data remove entity @s data.decrypto.active_clues
data modify entity @s data.decrypto.sync set value {white:{},black:{},answers:{}}
function decrypto:player/audience
function decrypto:round/generate_code
scoreboard players operation @s dc_b1 = #code1 dc_ctx
scoreboard players operation @s dc_b2 = #code2 dc_ctx
scoreboard players operation @s dc_b3 = #code3 dc_ctx
scoreboard players operation #prompt_input dc_ctx = @s dc_input
scoreboard players operation #sync_token dc_ctx = @s dc_form
scoreboard players operation #sync_round dc_ctx = @s dc_round
execute as @a[tag=dc.audience] run scoreboard players set @s dc_sd 0
execute as @a[tag=dc.audience,scores={dc_encoder=1}] run function decrypto:prompt/give_selected
function decrypto:sync/passwords
tellraw @a[tag=dc.audience] {text:"[谍报风云] 双方加密者同时填写三条提示；双方提交后统一公开。",color:"yellow"}
function decrypto:title/update_all
