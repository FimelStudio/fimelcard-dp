function wenfei:form/authorize
execute unless score #form_ok wq_ctx matches 1 run return 0
scoreboard players set #form_request_table wq_ctx -1
scoreboard players set #form_request_epoch wq_ctx -1
scoreboard players set #form_request_token wq_ctx -1
execute store result score #form_request_table wq_ctx run data get storage wenfei:form incoming.t
execute store result score #form_request_epoch wq_ctx run data get storage wenfei:form incoming.e
execute store result score #form_request_token wq_ctx run data get storage wenfei:form incoming.n
execute unless score @s wq_id = #form_request_table wq_ctx run return run function wenfei:form/reject
execute unless score @s wq_form = #form_request_token wq_ctx run return run function wenfei:form/reject
execute unless score @e[tag=wq.form_controller,limit=1] wq_epoch = #form_request_epoch wq_ctx run return run function wenfei:form/reject
scoreboard players set #form_length wq_ctx 0
execute store result score #form_length wq_ctx run data get storage wenfei:form incoming.a
execute unless score #form_length wq_ctx matches 1..64 run return run function wenfei:form/reject
data modify storage wenfei:io answer set value {text:""}
data modify storage wenfei:io answer.text set from storage wenfei:form incoming.a
execute store result storage wenfei:io submit.seat int 1 run scoreboard players get @s wq_seat
execute as @e[tag=wq.form_controller,limit=1] run function wenfei:input/save_answer with storage wenfei:io submit
scoreboard players set @s wq_done 1
clear @s minecraft:purple_dye[minecraft:custom_data~{wenfei:{tool:"answer_dialog"}}]
tellraw @s {text:"[问非所答] 答案已锁定，等待其他玩家。",color:"green"}
execute as @e[tag=wq.form_controller,limit=1] at @s run function wenfei:round/check_answers
tag @e[tag=wq.form_controller] remove wq.form_controller
data remove storage wenfei:form incoming
