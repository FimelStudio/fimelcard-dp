execute unless score @s ct_joined matches 3..8 run tellraw @a[tag=ct.start_actor,limit=1] [{text:'[谍报风云] ',color:'aqua'},{text:'需要3至8名玩家入座。',color:'yellow'}]
execute unless score @s ct_joined matches 3..8 run return fail
# 兼容升级后尚未重新选择过游戏、也未打开设置的旧牌桌。
execute unless score @s dc_round_limit matches 1..32 run scoreboard players set @s dc_round_limit 8
execute unless score @s dc_input matches 0..1 run scoreboard players set @s dc_input 0
execute unless score @s dc_team_mode matches 0..1 run scoreboard players set @s dc_team_mode 0
scoreboard players operation #ctx dc_ctx = @s ct_id
execute if score @s dc_team_mode matches 1 if score @s ct_joined matches 4.. run function decrypto:team/validate_fixed
execute if score @s dc_team_mode matches 1 if score @s ct_joined matches 4.. unless score #fixed_valid dc_ctx matches 1 run return fail
tag @s add dc.controller
scoreboard players operation @s dc_id = @s ct_id
execute store result entity @s data.decrypto.player_count int 1 run scoreboard players get @s ct_joined
scoreboard players set @s dc_state 1
scoreboard players set @s dc_round 1
scoreboard players set @s dc_intercept 0
scoreboard players set @s dc_error 0
scoreboard players set @s dc_wi 0
scoreboard players set @s dc_bi 0
scoreboard players set @s dc_we 0
scoreboard players set @s dc_be 0
scoreboard players set @s dc_mode 4
execute if score @s ct_joined matches 3 run scoreboard players set @s dc_mode 3
function decrypto:words/draw
function decrypto:game/cleanup_drops
function decrypto:notes/init
function decrypto:marker/update
function decrypto:round/generate_code
scoreboard players operation @s dc_w1 = #code1 dc_ctx
scoreboard players operation @s dc_w2 = #code2 dc_ctx
scoreboard players operation @s dc_w3 = #code3 dc_ctx
function decrypto:round/generate_code
scoreboard players operation @s dc_b1 = #code1 dc_ctx
scoreboard players operation @s dc_b2 = #code2 dc_ctx
scoreboard players operation @s dc_b3 = #code3 dc_ctx
execute as @a[tag=ct.player] if score @s ct_id = #ctx dc_ctx run tag @s add dc.player
execute as @a[tag=dc.player] if score @s ct_id = #ctx dc_ctx run scoreboard players operation @s dc_id = @s ct_id
execute as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run scoreboard players operation @s dc_seat = @s ct_seat
function decrypto:team/assign
execute as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run scoreboard players set @s dc_encoder 0
execute as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run scoreboard players set @s dc_drop 0
execute as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run scoreboard players set @s dc_drop_book 0
execute as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run scoreboard players set @s dc_drop_guess 0
execute as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run function decrypto:input/give_notes
# 三人模式不依赖座位：随机抽一人截密，其余两人为合作队；合作队再随机一人加密。
execute if score @s dc_mode matches 3 run tag @a[tag=dc.player] remove dc.pick_pool
execute if score @s dc_mode matches 3 as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run tag @s remove dc.interceptor
execute if score @s dc_mode matches 3 as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run tag @s add dc.pick_pool
execute if score @s dc_mode matches 3 run tag @a[tag=dc.pick_pool,sort=random,limit=1] add dc.interceptor
execute if score @s dc_mode matches 3 as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run scoreboard players set @s dc_team 1
execute if score @s dc_mode matches 3 as @a[tag=dc.interceptor] if score @s dc_id = #ctx dc_ctx run scoreboard players set @s dc_team 2
execute if score @s dc_mode matches 3 as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run scoreboard players set @s dc_encoder 0
execute if score @s dc_mode matches 3 run tag @a[tag=dc.pick_pool] remove dc.pick_pool
execute if score @s dc_mode matches 3 as @a[tag=dc.player,scores={dc_team=1}] if score @s dc_id = #ctx dc_ctx run tag @s add dc.pick_pool
execute if score @s dc_mode matches 3 run tag @a[tag=dc.pick_pool,sort=random,limit=1] add dc.encoder_pick
execute if score @s dc_mode matches 3 as @a[tag=dc.encoder_pick] if score @s dc_id = #ctx dc_ctx run scoreboard players set @s dc_encoder 1
tag @a[tag=dc.pick_pool] remove dc.pick_pool
tag @a[tag=dc.encoder_pick] remove dc.encoder_pick
function decrypto:player/audience
function decrypto:team/index
function decrypto:roles/update
function decrypto:player/announce_roles
function decrypto:player/announce_public
function decrypto:hud/load_keywords
function decrypto:title/activate_all
execute if score @s dc_mode matches 3 run tellraw @a[tag=dc.audience] [{text:'[谍报风云] ',color:'aqua'},{text:'三人模式：系统已随机分配合作队与截密者。截密或合作队传讯失败累计2次，截密者获胜；第5轮结束仍未达成则合作队获胜。',color:'yellow'}]
execute if score @s dc_mode matches 4 run tellraw @a[tag=dc.audience] [{text:'[谍报风云] ',color:'aqua'},{text:'分队模式（4至8人）：本局回合上限为 ',color:'yellow'},{score:{name:'@s',objective:'dc_round_limit'},color:'gold'},{text:' 轮；任一队提前达成标记胜负条件时仍会立即结束。',color:'yellow'}]
function decrypto:round/announce_start
function decrypto:words/announce_private
function decrypto:round/start_white_prompt
scoreboard players set @s ct_start 1
