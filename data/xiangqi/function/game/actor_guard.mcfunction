# 供控制器回调复用；UI有nonce校验，此处仍复核真人/桌号/身份。
function xiangqi:system/context
scoreboard players set #actor_ok xq_ctx 0
execute as @e[tag=xq.actor,tag=xq.audience,limit=1] if score @s xq_table = #table xq_ctx run scoreboard players set #actor_ok xq_ctx 1
