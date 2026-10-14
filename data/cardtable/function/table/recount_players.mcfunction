# 从在线玩家重新计算本桌人数，不能依赖玩家离线时无法执行的减一操作
scoreboard players operation #old_joined ct_ctx = @s ct_joined
scoreboard players operation #ctx_id ct_ctx = @s ct_id
scoreboard players set #joined ct_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #ctx_id ct_ctx run scoreboard players add #joined ct_ctx 1
scoreboard players operation @s ct_joined = #joined ct_ctx

# 仅大厅人数发生变化时重绘中央菜单
execute if score @s ct_state matches 0 unless score #old_joined ct_ctx = @s ct_joined run function cardtable:menu/render

# 游戏中同步人数门槛、有效票数与按钮文字。
execute if score @s ct_state matches 1 run function cardtable:vote/refresh
