tellraw @a[tag=gm.audience] {"text": "[五子棋] 人机同意和棋。", "color": "yellow"}
scoreboard players set @s gm_result 3
scoreboard players set @s gm_reason 8
function gomoku:game/finish
