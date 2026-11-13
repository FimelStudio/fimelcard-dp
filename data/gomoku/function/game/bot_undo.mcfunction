execute unless data entity @s data.gomoku.ai_undo run tellraw @a[tag=gm.actor] {"text": "[五子棋] 你还没有可撤回的落子。", "color": "black"}
execute unless data entity @s data.gomoku.ai_undo run return 0
data modify entity @s data.gomoku.undo set from entity @s data.gomoku.ai_undo
function gomoku:game/restore_undo
