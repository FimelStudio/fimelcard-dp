function decrypto:player/audience
scoreboard players add @s dc_round 1
execute if score @s dc_mode matches 3 if score @s dc_round matches 6.. run tellraw @a[tag=dc.audience] [{text:'[谍报风云] ',color:'aqua'},{text:'五轮结束，合作队获胜！',color:'gold'}]
execute if score @s dc_mode matches 3 if score @s dc_round matches 6.. run function decrypto:game/finish
execute if score @s dc_mode matches 3 if score @s dc_round matches 6.. run return 0
execute if score @s dc_mode matches 4 if score @s dc_round > @s dc_round_limit run tellraw @a[tag=dc.audience] [{text:'[谍报风云] ',color:'aqua'},{text:'已完成设定的 ',color:'yellow'},{score:{name:'@s',objective:'dc_round_limit'},color:'gold'},{text:' 轮，回合数耗尽，本局结束。',color:'yellow'}]
execute if score @s dc_mode matches 4 if score @s dc_round > @s dc_round_limit run function decrypto:game/finish
execute if score @s dc_mode matches 4 if score @s dc_round > @s dc_round_limit run return 0
# 整局沿用开局词条和累计电报记录；回合间只生成新数字密码。
function decrypto:round/announce_start
function decrypto:words/announce_private
scoreboard players set @s dc_state 1
scoreboard players set @s dc_pos 1
scoreboard players set @s dc_clue 0
scoreboard players operation #ctx dc_ctx = @s dc_id
# 三人模式中合作队两人每轮交换加密/解密，截密者身份保持不变。
execute if score @s dc_mode matches 3 as @a[tag=dc.player,scores={dc_team=1}] if score @s dc_id = #ctx dc_ctx run function decrypto:player/toggle_encoder
function decrypto:roles/update
function decrypto:player/announce_roles
function decrypto:player/announce_public
function decrypto:round/generate_code
scoreboard players operation @s dc_w1 = #code1 dc_ctx
scoreboard players operation @s dc_w2 = #code2 dc_ctx
scoreboard players operation @s dc_w3 = #code3 dc_ctx
function decrypto:round/start_white_prompt
