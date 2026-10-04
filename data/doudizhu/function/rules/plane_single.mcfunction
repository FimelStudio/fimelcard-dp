# 翅膀允许成对，但不允许同时带大小王；主体必须恰好三个。
execute if score #r16 dd_ctx matches 1 if score #r17 dd_ctx matches 1 run return 0
$scoreboard players set #body_low dd_ctx $(start)
$scoreboard players set #body_high dd_ctx $(end)
function doudizhu:rules/check_wings
execute if score #bad_wing dd_ctx matches 1 run return 0
$function doudizhu:rules/accept {type:9,high:$(high)}
