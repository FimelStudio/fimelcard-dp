scoreboard players set @s xq_sel -1
function xiangqi:visual/select
function xiangqi:sound/illegal
tellraw @a[tag=xq.actor] {"text": "[中国象棋] 这一步不合法，请重新选择棋子。", "color": "red"}
