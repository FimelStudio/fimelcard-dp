# 清理旧版本中央道具；不再为比赛事件生成临时物品展示。
execute as @e[tag=ma.event_prop] if score @s ct_id = #vis_table ma_ctx run kill @s
