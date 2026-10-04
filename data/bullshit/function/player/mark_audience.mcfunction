# 调用者是本桌控制器或玩家；同步函数链用完即移除临时标签。
scoreboard players operation #ctx bw_ctx = @s bw_id
tag @a[tag=bw.audience] remove bw.audience
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run tag @s add bw.audience
