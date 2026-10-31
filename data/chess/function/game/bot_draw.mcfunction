tellraw @a[tag=ch.audience] {"text": "[国际象棋] 人机同意和棋。", "color": "yellow"}
scoreboard players set @s ch_result 3
scoreboard players set @s ch_reason 8
function chess:game/finish
