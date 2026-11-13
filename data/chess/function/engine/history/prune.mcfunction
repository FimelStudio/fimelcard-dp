# 动兵、吃子、失去易位权均不可逆；此前局面不可能重现，避免长局NBT无限增长。
# 走子前的完整历史已由game/snapshot保存在悔棋快照，本函数不修改该快照。
scoreboard players set #irreversible ch_ctx 0
execute if score #kind ch_ctx matches 1 run scoreboard players set #irreversible ch_ctx 1
execute unless score #captured ch_ctx matches 0 run scoreboard players set #irreversible ch_ctx 1
execute unless score #castle ch_ctx = #old_castle ch_ctx run scoreboard players set #irreversible ch_ctx 1
execute if score #irreversible ch_ctx matches 1 run data modify entity @s data.chess.history set value []
