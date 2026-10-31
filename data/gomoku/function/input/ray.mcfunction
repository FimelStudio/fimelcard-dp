# 同步调用内最多一个临时marker；完成后删除，不给客户端产生实体。
kill @e[type=minecraft:marker,tag=gm.ray]
scoreboard players set #ray_ok gm_ctx 0
execute at @s anchored eyes positioned ^ ^ ^ summon minecraft:marker run tag @s add gm.ray
scoreboard players set #ray_low gm_ctx 0
scoreboard players set #ray_high gm_ctx 32768
scoreboard players set #ray_mid gm_ctx 0
function gomoku:input/ray_probe
# 眼睛必须在棋盘上方，向下看时才允许落子。
execute if score #ray_below gm_ctx matches 1 run return run function gomoku:input/ray_clear
scoreboard players operation #ray_mid gm_ctx = #ray_high gm_ctx
function gomoku:input/ray_probe
execute unless score #ray_below gm_ctx matches 1 run return run function gomoku:input/ray_clear
scoreboard players set #ray_count gm_ctx 13
function gomoku:input/ray_bisect
scoreboard players operation #ray_mid gm_ctx = #ray_high gm_ctx
function gomoku:input/ray_probe
execute at @e[type=minecraft:marker,tag=gm.ray,limit=1] run function gomoku:input/ray_target
function gomoku:input/ray_clear
