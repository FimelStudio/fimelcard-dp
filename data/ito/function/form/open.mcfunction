execute unless score @e[tag=it.current,limit=1] it_input matches 1 run return 0
function ito:input/focus
execute unless entity @e[tag=it.focus,limit=1] run return 0
execute store result storage ito:form slot int 1 run scoreboard players get #slot it_ctx
execute store result storage ito:form table int 1 run scoreboard players get @s it_table
execute store result storage ito:form epoch int 1 run scoreboard players get @e[tag=it.current,limit=1] it_epoch
execute store result storage ito:form token int 1 run scoreboard players get @s it_window
execute store result storage ito:form number int 1 run scoreboard players get @e[tag=it.focus,limit=1] it_number
data modify storage ito:form dialog set value {"type":"minecraft:confirmation","title":{"text":"修改描述"},"body":[{"type":"minecraft:plain_message","contents":{"text":"自由文本提交需要OP；普通玩家请使用描述书。最多48字。"}}],"inputs":[{"type":"minecraft:text","key":"a","label":{"text":"描述"},"width":360,"max_length":48,"initial":""}],"yes":{"label":{"text":"公布描述"},"action":{"type":"minecraft:dynamic/run_command","template":""}},"no":{"label":{"text":"关闭"}},"pause":false,"after_action":"close"}
data modify storage ito:form dialog.inputs[0].initial set from entity @e[tag=it.focus,limit=1] data.description
data modify storage ito:form a set value "$(a)"
function ito:form/template with storage ito:form
function ito:form/show with storage ito:form
