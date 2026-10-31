# 切换游戏/删除牌桌专用：不重新生成预览，不更改即将选中的游戏。
function gomoku:settings/invalidate_table
function gomoku:ai/reset
data remove entity @s data.gomoku.review
function gomoku:system/context
execute as @a[tag=gm.player] if score @s gm_table = #table gm_ctx run function gomoku:player/clear_state
function gomoku:visual/clear
execute as @e[type=minecraft:firework_rocket,tag=gm.firework] if score @s ct_id = #table gm_ctx run kill @s
kill @e[type=minecraft:marker,tag=gm.board]
tag @s remove gm.controller
tag @s remove gm.current
scoreboard players set @s gm_state 0
