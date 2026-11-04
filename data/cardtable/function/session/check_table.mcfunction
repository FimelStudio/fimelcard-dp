execute if score @s ct_finishing matches 1 run return 0
scoreboard players operation #session_table ct_ctx = @s ct_id
scoreboard players operation #session_id ct_ctx = @s ct_session
scoreboard players set #session_online ct_ctx 0
execute as @a[tag=ct.player,tag=!ct.rejoining] if score @s ct_id = #session_table ct_ctx if score @s ct_session = #session_id ct_ctx run scoreboard players add #session_online ct_ctx 1
scoreboard players operation #was_paused ct_ctx = @s ct_paused
scoreboard players set @s ct_paused 0
execute if score #session_online ct_ctx < @s ct_expected run scoreboard players set @s ct_paused 1
scoreboard players operation #is_paused ct_ctx = @s ct_paused
# 恢复第一刻再清一次暂停末尾输入，随后才解锁玩家。
execute if score #is_paused ct_ctx matches 0 if score #was_paused ct_ctx matches 1 run function cardtable:session/discard_paused_inputs
execute as @a[tag=ct.player] if score @s ct_id = #session_table ct_ctx run scoreboard players operation @s ct_paused = #is_paused ct_ctx
execute unless score #was_paused ct_ctx = #is_paused ct_ctx as @e[tag=ct.part] if score @s ct_id = #session_table ct_ctx run scoreboard players operation @s ct_paused = #is_paused ct_ctx
execute if score @s ct_paused matches 1 unless score #was_paused ct_ctx matches 1 run function cardtable:session/pause
execute if score @s ct_paused matches 0 if score #was_paused ct_ctx matches 1 run function cardtable:session/resume
execute if score @s ct_paused matches 1 run function cardtable:session/wait
