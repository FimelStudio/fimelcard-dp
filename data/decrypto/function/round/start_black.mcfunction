function decrypto:round/generate_code
scoreboard players operation @s dc_b1 = #code1 dc_ctx
scoreboard players operation @s dc_b2 = #code2 dc_ctx
scoreboard players operation @s dc_b3 = #code3 dc_ctx
tellraw @a[tag=dc.player] [{text:'[谍报风云] ',color:'aqua'},{text:'白队密码已结算；现在由黑队加密者生成并提交提示。',color:'yellow'}]
function decrypto:round/start_black_prompt
