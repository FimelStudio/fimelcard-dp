execute unless data entity @s data.xiangqi.ai_undo run tellraw @a[tag=xq.actor] {"text": "[中国象棋] 你还没有可撤回的走子。", "color": "red"}
execute unless data entity @s data.xiangqi.ai_undo run return 0
data modify entity @s data.xiangqi.undo set from entity @s data.xiangqi.ai_undo
function xiangqi:game/restore_undo
