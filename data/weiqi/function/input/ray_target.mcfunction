# 本桌marker已定位到交点。最近交点即方格分区，无需扫描361个命中区。
# 这里只按本桌上下文查询，不能点到相邻牌桌。
scoreboard players set #to go_ctx -1
execute if entity @e[type=minecraft:marker,tag=go.board,distance=..0.26,limit=1] run scoreboard players operation #to go_ctx = @e[type=minecraft:marker,tag=go.board,sort=nearest,limit=1] go_sq
execute if score #to go_ctx matches 0..360 run scoreboard players set #ray_ok go_ctx 1
