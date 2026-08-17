# 奖励牌扩展注册API：function hanabi:reward/deck/add {reward:100,copies:1}
$scoreboard players set #reward_type hb_ctx $(reward)
$scoreboard players set #reward_copies hb_ctx $(copies)
execute unless score #reward_type hb_ctx matches 100.. run return fail
execute unless score #reward_copies hb_ctx matches 1..32 run return fail
function hanabi:reward/deck/create_copies
