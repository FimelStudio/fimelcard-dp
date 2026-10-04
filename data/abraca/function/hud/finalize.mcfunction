# 在清理玩家前保存本桌全部玩家的最终生命。
function abraca:hud/update
execute as @e[type=minecraft:text_display,tag=ab.info] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.game_entity
execute as @e[type=minecraft:text_display,tag=ab.info] if score @s ab_id = #ctx ab_ctx run tag @s add ab.final_info
