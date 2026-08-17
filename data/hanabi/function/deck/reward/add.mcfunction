# 旧路径兼容层：奖励牌已不再混入普通牌库
# 新扩展应直接调用 function hanabi:reward/deck/add {reward:100,copies:1}
$function hanabi:reward/deck/add {reward:$(reward),copies:1}
