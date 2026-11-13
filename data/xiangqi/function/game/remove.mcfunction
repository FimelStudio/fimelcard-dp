# 切换游戏/删除牌桌专用：不重新生成预览，不更改即将选中的游戏。
function xiangqi:settings/invalidate_table
function xiangqi:ai/reset
data remove entity @s data.xiangqi.review
function xiangqi:system/context
execute as @a[tag=xq.player] if score @s xq_table = #table xq_ctx run function xiangqi:player/clear_state
function xiangqi:visual/clear
kill @e[type=minecraft:marker,tag=xq.board]
tag @s remove xq.controller
tag @s remove xq.current
scoreboard players set @s xq_state 0
