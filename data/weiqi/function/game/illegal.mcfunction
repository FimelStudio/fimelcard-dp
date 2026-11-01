scoreboard players set @s go_sel -1
function weiqi:visual/select
function weiqi:sound/illegal
execute if score #error go_ctx matches 1 run tellraw @a[tag=go.actor] {"text": "[围棋] 请在棋盘交点落子。", "color": "red"}
execute if score #error go_ctx matches 2 run tellraw @a[tag=go.actor] {"text": "[围棋] 该交点已有棋子。", "color": "red"}
execute if score #error go_ctx matches 3 run tellraw @a[tag=go.actor] {"text": "[围棋] 不能自杀落子。", "color": "red"}
execute if score #error go_ctx matches 4 run tellraw @a[tag=go.actor] {"text": "[围棋] 该步会重复先前棋形，违反超级劫规则。", "color": "red"}
