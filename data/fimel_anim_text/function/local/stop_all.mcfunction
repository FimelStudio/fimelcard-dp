# 选中实体删除

scoreboard players operation #player.current fca_store = @s fca_player_id

execute as @e[tag=fimel.anim_text.mark,type=interaction] if score @s fca_player_id = #player.current fca_store run kill @s

# 移除标签

tag @s remove fimel.anim_text.replace.actionbar

tag @s remove fimel.anim_text.replace.title

tag @s remove fimel.anim_text.replace.subtitle

tag @s remove fimel.anim_text.local.actionbar

tag @s remove fimel.anim_text.local.title

tag @s remove fimel.anim_text.local.subtitle