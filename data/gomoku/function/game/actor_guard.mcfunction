# 供控制器回调复用；UI有nonce校验，此处仍复核真人/桌号/身份。
function gomoku:system/context
scoreboard players set #actor_ok gm_ctx 0
execute as @e[tag=gm.actor,tag=gm.audience,limit=1] if score @s gm_table = #table gm_ctx run scoreboard players set #actor_ok gm_ctx 1
