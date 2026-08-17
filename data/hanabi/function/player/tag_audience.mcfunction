# 临时观众标签只在同步函数链内使用，确保相邻牌桌也不会串消息或音效
tag @a[tag=hb.audience] remove hb.audience
scoreboard players operation #ctx_id hb_ctx = @s hb_id
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run tag @s add hb.audience

