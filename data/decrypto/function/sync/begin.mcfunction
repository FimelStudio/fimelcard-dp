scoreboard players set @s dc_sync 1
scoreboard players add #form_sequence dc_ctx 1
scoreboard players operation @s dc_form = #form_sequence dc_ctx
scoreboard players set @s dc_state 2
data remove entity @s data.decrypto.active_clues
data modify entity @s data.decrypto.sync set value {white:{},black:{},answers:{}}
function decrypto:player/audience
execute if score @s dc_mode matches 4 run function decrypto:round/generate_code
execute if score @s dc_mode matches 4 run scoreboard players operation @s dc_b1 = #code1 dc_ctx
execute if score @s dc_mode matches 4 run scoreboard players operation @s dc_b2 = #code2 dc_ctx
execute if score @s dc_mode matches 4 run scoreboard players operation @s dc_b3 = #code3 dc_ctx
scoreboard players operation #prompt_input dc_ctx = @s dc_input
scoreboard players operation #sync_token dc_ctx = @s dc_form
scoreboard players operation #sync_round dc_ctx = @s dc_round
execute as @a[tag=dc.audience,scores={dc_encoder=1}] run function decrypto:prompt/give_selected
function decrypto:sync/passwords
execute if score @s dc_mode matches 4 run tellraw @a[tag=dc.audience] {text:"[谍报风云] 双方加密者同时填写三条提示；双方提交后统一公开。",color:"yellow"}
execute if score @s dc_mode matches 3 run tellraw @a[tag=dc.audience] {text:"[谍报风云] 合作队加密者请填写并提交三条提示。",color:"yellow"}
function decrypto:timer/start {limit:"dc_encode_limit"}
function decrypto:hint/update
function decrypto:title/update_all
