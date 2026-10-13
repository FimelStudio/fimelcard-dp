# 选中实体删除

scoreboard players operation #player.current fca_store = @s fca_player_id

execute as @e[tag=fimel.anim_text.mark,tag=fimel.anim_text.local.title,type=interaction] if score @s fca_player_id = #player.current fca_store run kill @s