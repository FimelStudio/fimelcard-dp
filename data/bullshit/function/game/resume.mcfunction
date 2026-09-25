# 阅读阶段不重新抽题或提前公布身份。
execute unless score @s bw_state matches 2 run return 0
scoreboard players operation #ctx bw_ctx = @s bw_id
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run tag @s remove bw.smart
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run tag @s remove bw.honest
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run tag @s remove bw.bluffer
execute as @a[tag=bw.player,scores={bw_role=1}] if score @s bw_id = #ctx bw_ctx run tag @s add bw.smart
execute as @a[tag=bw.player,scores={bw_role=2}] if score @s bw_id = #ctx bw_ctx run tag @s add bw.honest
execute as @a[tag=bw.player,scores={bw_role=3}] if score @s bw_id = #ctx bw_ctx run tag @s add bw.bluffer
execute as @a[tag=bw.smart] if score @s bw_id = #ctx bw_ctx run function bullshit:game/resume_smart
