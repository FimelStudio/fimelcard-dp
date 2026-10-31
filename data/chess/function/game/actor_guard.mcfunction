# 供控制器回调复用；UI有nonce校验，此处仍复核真人/桌号/身份。
function chess:system/context
scoreboard players set #actor_ok ch_ctx 0
execute as @e[tag=ch.actor,tag=ch.audience,limit=1] if score @s ch_table = #table ch_ctx run scoreboard players set #actor_ok ch_ctx 1
