execute unless entity @e[tag=gd.current,scores={gd_state=2..3,gd_anim=0},limit=1] run return run function guandan:input/invalid
execute unless entity @e[tag=gd.me,scores={gd_rank=0},limit=1] run return run function guandan:input/invalid
scoreboard players operation #ui_id gd_ctx = #ui_action gd_ctx
scoreboard players remove #ui_id gd_ctx 100
tag @e[tag=gd.clicked] remove gd.clicked
execute as @e[tag=gd.cards] if score @s gd_owner = #ui_seat gd_ctx if score @s gd_id = #ui_id gd_ctx run tag @s add gd.clicked
execute unless entity @e[tag=gd.clicked,limit=1] run return run function guandan:input/invalid
execute if entity @e[tag=gd.clicked,scores={gd_sel=1},limit=1] run return run function guandan:input/unselect_one
execute if entity @e[tag=gd.current,scores={gd_state=2},limit=1] run function guandan:input/clear_selected
scoreboard players set @e[tag=gd.clicked,limit=1] gd_sel 1
tag @e[tag=gd.clicked,limit=1] add gd.selected
tag @e[tag=gd.clicked] remove gd.clicked
function guandan:ui/open
