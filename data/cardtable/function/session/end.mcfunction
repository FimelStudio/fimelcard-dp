# 先使会话失效；离线成员上线时只清理自己，绝不再触发旧游戏abort。
scoreboard players operation #session_table ct_ctx = @s ct_id
execute as @a[tag=ct.player] if score @s ct_id = #session_table ct_ctx run function cardtable:session/end_player
execute if score @s ct_session matches 1.. run function cardtable:session/mark_ended
scoreboard players set @s ct_session 0
scoreboard players set @s ct_expected 0
scoreboard players set @s ct_paused 0
scoreboard players set @s ct_wait 0
scoreboard players add @s ct_ch_epoch 1
data remove entity @s data.cardtable.members
data remove entity @s data.cardtable.session_legacy
execute as @e[tag=ct.part] if score @s ct_id = #session_table ct_ctx run scoreboard players set @s ct_paused 0
