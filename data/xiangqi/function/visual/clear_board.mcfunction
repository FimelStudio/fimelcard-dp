# 刷新布局不影响时钟，不删除规则棋格 marker 或其他桌的任何实体。
scoreboard players operation #vis_table xq_ctx = @s ct_id
execute as @e[tag=xq.visual,tag=!xq.clock] if score @s ct_id = #vis_table xq_ctx run kill @s
