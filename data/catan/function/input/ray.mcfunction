# 同步调用内最多一个临时marker；完成后删除，不给客户端产生实体。
kill @e[type=minecraft:marker,tag=ca.ray]
scoreboard players set #ray_ok ca_ctx 0
execute at @s anchored eyes positioned ^ ^ ^ summon minecraft:marker run tag @s add ca.ray
scoreboard players set #ray_low ca_ctx 0
scoreboard players set #ray_high ca_ctx 32768
scoreboard players set #ray_mid ca_ctx 0
function catan:input/ray_probe
# 眼睛必须在棋盘上方，向下看时才允许落子。
execute if score #ray_below ca_ctx matches 1 run return run function catan:input/ray_clear
scoreboard players operation #ray_mid ca_ctx = #ray_high ca_ctx
function catan:input/ray_probe
execute unless score #ray_below ca_ctx matches 1 run return run function catan:input/ray_clear
scoreboard players set #ray_count ca_ctx 13
function catan:input/ray_bisect
scoreboard players operation #ray_mid ca_ctx = #ray_high ca_ctx
function catan:input/ray_probe
function catan:input/ray_target
function catan:input/ray_clear
