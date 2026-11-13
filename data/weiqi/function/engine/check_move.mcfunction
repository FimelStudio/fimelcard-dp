# 与正式落子执行相同规则；只保留返回分数，全部持久盘面均回滚。
scoreboard players set #commit go_ctx 0
function weiqi:engine/attempt
