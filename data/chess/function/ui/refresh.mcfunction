# 更新可用输入，不逐刻强制弹窗。
function chess:system/context
scoreboard players set @a[tag=ch.audience] ch_action 0
scoreboard players enable @a[tag=ch.audience] ch_action
