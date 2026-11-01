function guandan:visual/context
# 旧公开实体本身即动画快照，不再依赖已清空的逻辑 last_play。
execute as @e[type=minecraft:item_display,tag=gd.face,tag=!gd.fx] if score @s ct_id = #vis_table gd_ctx run function guandan:visual/collect_face
function guandan:visual/refresh
