# 从模板到真实身份仅发生于真实落子提交，吃掉暗子不读取其身份。
$execute if score #covered xq_ctx matches 1 run scoreboard players operation #placed xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=$(from)},limit=1] xq_hidden
