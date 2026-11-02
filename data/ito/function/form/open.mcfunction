function ito:input/context
execute unless score #valid it_ctx matches 1 run return 0
execute unless score @e[tag=it.current,limit=1] it_input matches 1 run return 0
execute unless score @e[tag=it.current,limit=1] it_state matches 2 run return 0
scoreboard players add #window_serial it_ctx 1
execute if score #window_serial it_ctx matches 10000001.. run scoreboard players set #window_serial it_ctx 1
scoreboard players operation @s it_window = #window_serial it_ctx
execute store result storage ito:form table int 1 run scoreboard players get @s it_table
execute store result storage ito:form epoch int 1 run scoreboard players get @e[tag=it.current,limit=1] it_epoch
execute store result storage ito:form token int 1 run scoreboard players get @s it_window
data modify storage ito:form dialog set value {type:"minecraft:confirmation",title:{text:"命悬一线 · 本轮答案",color:"gold"},body:[{type:"minecraft:plain_message",width:440,contents:{text:"本轮问题：",color:"gold",extra:[{text:""}]}},{type:"minecraft:plain_message",width:440,contents:{text:"为每张数字牌填写1至48字。提交后仍可修改；拿数字牌按Q出牌。对话框提交需要OP。",color:"gray"}}],inputs:[],yes:{label:{text:"提交全部答案"},action:{type:"minecraft:dynamic/run_command",template:""}},no:{label:{text:"关闭"}},pause:false,after_action:"close"}
data modify storage ito:form dialog.body[0].contents.extra[0].text set from entity @e[tag=it.current,limit=1] data.ito.theme.text
data modify storage ito:form a1 set value ""
data modify storage ito:form a2 set value ""
data modify storage ito:form a3 set value ""
scoreboard players set #slot it_ctx 1
function ito:form/add_input {slot:1}
scoreboard players set #slot it_ctx 2
function ito:form/add_input {slot:2}
scoreboard players set #slot it_ctx 3
function ito:form/add_input {slot:3}
execute unless data storage ito:form dialog.inputs[0] run return 0
function ito:form/template with storage ito:form
function ito:form/show with storage ito:form
