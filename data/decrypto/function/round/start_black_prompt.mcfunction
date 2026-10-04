scoreboard players set @s dc_state 4
function decrypto:title/update_all
scoreboard players set @s dc_clue 0
scoreboard players operation #ctx dc_ctx = @s dc_id
scoreboard players operation #prompt_input dc_ctx = @s dc_input
# 保留原有私密密码聊天提示，仅发给本桌当前加密者。
tag @a[tag=dc.prompt_audience] remove dc.prompt_audience
execute as @a[tag=dc.player,scores={dc_team=2,dc_encoder=1}] if score @s dc_id = #ctx dc_ctx run tag @s add dc.prompt_audience
tellraw @a[tag=dc.prompt_audience] [{text:'[本轮密码] ',color:'gold'},{score:{name:'@s',objective:'dc_b1'}},{text:' - '},{score:{name:'@s',objective:'dc_b2'}},{text:' - '},{score:{name:'@s',objective:'dc_b3'}}]
tag @a[tag=dc.prompt_audience] remove dc.prompt_audience
execute as @a[tag=dc.player,scores={dc_team=2,dc_encoder=1}] if score @s dc_id = #ctx dc_ctx run function decrypto:prompt/give_selected
execute as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run tellraw @s [{text:'[谍报风云] ',color:'aqua'},{text:'现在由黑队加密者填写并提交三条提示。',color:'yellow'}]
