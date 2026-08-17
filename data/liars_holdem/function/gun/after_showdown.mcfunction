function liars_holdem:util/count_alive
execute if score @s lh_alive_count matches ..1 run return run function liars_holdem:game/finish
function liars_holdem:gun/next_showdown
