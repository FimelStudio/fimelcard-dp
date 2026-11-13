# 切换游戏/删除牌桌专用：不重新生成预览，不更改即将选中的游戏。
function chess:settings/invalidate_table
function chess:ai/reset
data remove entity @s data.chess.review
function chess:system/context
execute as @a[tag=ch.player] if score @s ch_table = #table ch_ctx run function chess:player/clear_state
function chess:visual/clear
kill @e[type=minecraft:marker,tag=ch.board]
tag @s remove ch.controller
tag @s remove ch.current
scoreboard players set @s ch_state 0
