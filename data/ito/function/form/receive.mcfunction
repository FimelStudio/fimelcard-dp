function ito:input/context
execute unless score #valid it_ctx matches 1 run return 0
execute unless score @e[tag=it.current,limit=1] it_input matches 1 run return 0
execute unless score @e[tag=it.current,limit=1] it_state matches 2 run return 0
execute store result score #t it_ctx run data get storage ito:form incoming.t
execute store result score #e it_ctx run data get storage ito:form incoming.e
execute store result score #n it_ctx run data get storage ito:form incoming.n
execute unless score #t it_ctx = @s it_table run return 0
execute unless score #e it_ctx = @e[tag=it.current,limit=1] it_epoch run return 0
execute unless score #n it_ctx = @s it_window run return 0
scoreboard players set #batch_bad it_ctx 0
scoreboard players set #slot it_ctx 1
function ito:form/validate {slot:1}
scoreboard players set #slot it_ctx 2
function ito:form/validate {slot:2}
scoreboard players set #slot it_ctx 3
function ito:form/validate {slot:3}
execute if score #batch_bad it_ctx matches 1 run tellraw @s {text:"每张未出数字牌都需填写1至48字，本次未保存。",color:"red"}
execute if score #batch_bad it_ctx matches 1 run return 0
scoreboard players set #slot it_ctx 1
function ito:form/save_field {slot:1}
scoreboard players set #slot it_ctx 2
function ito:form/save_field {slot:2}
scoreboard players set #slot it_ctx 3
function ito:form/save_field {slot:3}
tellraw @s {text:"[命悬一线] 本轮答案已更新，拿数字牌按Q出牌。",color:"green"}
execute as @e[tag=it.current,limit=1] at @s run function ito:hud/refresh
