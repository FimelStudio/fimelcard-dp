function wenfei:form/authorize
execute unless score #form_ok wq_ctx matches 1 run return 0
function wenfei:form/give_tool
scoreboard players add #form_serial wq_ctx 1
scoreboard players operation @s wq_form = #form_serial wq_ctx
execute store result storage wenfei:form token int 1 run scoreboard players get @s wq_form
execute store result storage wenfei:form table int 1 run scoreboard players get @s wq_id
execute store result storage wenfei:form epoch int 1 run scoreboard players get @e[tag=wq.form_controller,limit=1] wq_epoch
execute as @e[tag=wq.form_controller,limit=1] run function wenfei:form/build
function wenfei:form/show with storage wenfei:form
tag @e[tag=wq.form_controller] remove wq.form_controller
