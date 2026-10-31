# 更新可用输入，不逐刻强制弹窗。
function xiangqi:system/context
scoreboard players set @a[tag=xq.audience] xq_action 0
scoreboard players enable @a[tag=xq.audience] xq_action
