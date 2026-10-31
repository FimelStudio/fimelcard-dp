# 按实际座号和方向寻找下一名玩家，空座最多扫描八次。
scoreboard players operation #u_seek un_ctx = @s un_turn
scoreboard players operation #u_dir un_ctx = @s un_dir
scoreboard players set #u_steps un_ctx 0
function uno:round/step_loop
scoreboard players operation @s un_turn = #u_seek un_ctx
