scoreboard players set @s ch_sel -1
function chess:visual/select
function chess:sound/illegal
tellraw @a[tag=ch.actor] {"text": "[国际象棋] 这一步不合法，请重新选择棋子。", "color": "red"}
