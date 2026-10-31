# 更新可用输入，不逐刻强制弹窗。
function gomoku:system/context
scoreboard players set @a[tag=gm.audience] gm_action 0
scoreboard players enable @a[tag=gm.audience] gm_action
