# 仅在具体游戏开局成功、玩家换座完成后调用，真人与机器人分开计数。
scoreboard players set @s ct_finishing 0
scoreboard players add #session ct_ctx 1
scoreboard players operation @s ct_session = #session ct_ctx
function cardtable:session/mark_active
scoreboard players set @s ct_expected 0
scoreboard players set @s ct_paused 0
scoreboard players set @s ct_wait 0
scoreboard players operation #session_table ct_ctx = @s ct_id
scoreboard players operation #session_id ct_ctx = @s ct_session
data remove entity @s data.cardtable.session_legacy
data modify entity @s data.cardtable.members set value []
tag @s add ct.session_build
execute as @a[tag=ct.player] if score @s ct_id = #session_table ct_ctx run function cardtable:session/register_player
tag @s remove ct.session_build
scoreboard players add @s ct_ch_epoch 1
