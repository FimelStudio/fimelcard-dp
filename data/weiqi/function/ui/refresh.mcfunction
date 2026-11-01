# 阶段推进只恢复trigger资格，不强制打断视角弹窗。
function weiqi:system/context
scoreboard players set @a[tag=go.audience] go_action 0
scoreboard players enable @a[tag=go.audience] go_action
