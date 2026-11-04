# 最终结果或结束投票已锁定：先注销会话，再让结算动画独立走完。
execute if score @s ct_finishing matches 1 run return 0
scoreboard players set @s ct_finishing 1
function cardtable:session/end
