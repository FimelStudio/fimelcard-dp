function liars_holdem:util/count_alive
execute if score @s lh_alive_count matches ..1 run return run function liars_holdem:game/finish

function liars_holdem:util/count_active
execute if score @s lh_active matches ..1 run return run function liars_holdem:round/end_single

# 恢复弃牌前阶段，并从弃牌座位之后继续寻找尚未行动者
scoreboard players operation @s lh_state = @s lh_return
scoreboard players operation @s lh_turn = @s lh_gun_seat
function liars_holdem:turn/advance
