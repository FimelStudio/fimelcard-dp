# 状态推进后仅更新可用输入，不逐刻向全桌强制弹窗。
function uno:system/context
scoreboard players set @a[tag=un.audience] un_pick -1
scoreboard players set @a[tag=un.audience] un_colorpick -1
scoreboard players set @a[tag=un.audience] un_action 0
scoreboard players enable @a[tag=un.audience] un_action
