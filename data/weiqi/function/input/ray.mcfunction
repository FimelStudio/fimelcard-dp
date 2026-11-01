# 同步调用内最多一个临时marker；完成后删除，不给客户端产生实体。
kill @e[type=minecraft:marker,tag=go.ray]
scoreboard players set #ray_ok go_ctx 0
execute at @s anchored eyes positioned ^ ^ ^ summon minecraft:marker run tag @s add go.ray
scoreboard players set #ray_low go_ctx 0
scoreboard players set #ray_high go_ctx 32768
scoreboard players set #ray_mid go_ctx 0
function weiqi:input/ray_probe
# 眼睛必须在棋盘上方，向下看时才允许落子。
execute if score #ray_below go_ctx matches 1 run return run function weiqi:input/ray_clear
scoreboard players operation #ray_mid go_ctx = #ray_high go_ctx
function weiqi:input/ray_probe
execute unless score #ray_below go_ctx matches 1 run return run function weiqi:input/ray_clear
scoreboard players set #ray_count go_ctx 13
function weiqi:input/ray_bisect
scoreboard players operation #ray_mid go_ctx = #ray_high go_ctx
function weiqi:input/ray_probe
execute at @e[type=minecraft:marker,tag=go.ray,limit=1] run function weiqi:input/ray_target
function weiqi:input/ray_clear
