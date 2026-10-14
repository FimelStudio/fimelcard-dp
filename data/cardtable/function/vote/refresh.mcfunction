# 控制器执行；人数减少后重新核对有效票，可直接结束已达到门槛的对局。
function cardtable:vote/count
execute if score #vote_players ct_ctx matches 1.. if score @s ct_votes >= #vote_need ct_ctx run return run function cardtable:vote/finish
execute store result storage cardtable:vote votes int 1 run scoreboard players get @s ct_votes
execute store result storage cardtable:vote need int 1 run scoreboard players get #vote_need ct_ctx
function cardtable:vote/update_text with storage cardtable:vote
