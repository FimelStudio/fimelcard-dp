execute unless data entity @s data.chess.ai_undo run tellraw @a[tag=ch.actor] {"text": "[国际象棋] 你还没有可撤回的走子。", "color": "red"}
execute unless data entity @s data.chess.ai_undo run return 0
data modify entity @s data.chess.undo set from entity @s data.chess.ai_undo
function chess:game/restore_undo
