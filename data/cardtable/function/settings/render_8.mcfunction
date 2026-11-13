execute unless score @s wq_duo matches 1..6 run scoreboard players set @s wq_duo 3
scoreboard players operation #setting_current ct_ctx = @s wq_duo
data modify storage cardtable:settings field1 set value {"text":"双人局每人猜题次数：","color":"gray","extra":[]}
scoreboard players set #setting_fieldbase ct_ctx 1000
scoreboard players operation #setting_fieldbase ct_ctx += #setting_base ct_ctx
data modify storage cardtable:settings field set value 1
execute store result storage cardtable:settings current int 1 run scoreboard players get #setting_current ct_ctx
scoreboard players set #setting_low ct_ctx 1
scoreboard players set #setting_high ct_ctx 6
function cardtable:settings/numeric_choice {field:1,delta:-1,label:"−1"}
function cardtable:settings/current with storage cardtable:settings
function cardtable:settings/numeric_choice {field:1,delta:1,label:"+1"}
execute unless score @s wq_multi matches 1..6 run scoreboard players set @s wq_multi 2
scoreboard players operation #setting_current ct_ctx = @s wq_multi
data modify storage cardtable:settings field2 set value {"text":"多人局每人猜题次数：","color":"gray","extra":[]}
scoreboard players set #setting_fieldbase ct_ctx 2000
scoreboard players operation #setting_fieldbase ct_ctx += #setting_base ct_ctx
data modify storage cardtable:settings field set value 2
execute store result storage cardtable:settings current int 1 run scoreboard players get #setting_current ct_ctx
scoreboard players set #setting_low ct_ctx 1
scoreboard players set #setting_high ct_ctx 6
function cardtable:settings/numeric_choice {field:2,delta:-1,label:"−1"}
function cardtable:settings/current with storage cardtable:settings
function cardtable:settings/numeric_choice {field:2,delta:1,label:"+1"}
execute unless score @s wq_input matches 0..1 run scoreboard players set @s wq_input 0
scoreboard players operation #setting_current ct_ctx = @s wq_input
data modify storage cardtable:settings field3 set value {"text":"答案输入方式：","color":"gray","extra":[]}
scoreboard players set #setting_fieldbase ct_ctx 3000
scoreboard players operation #setting_fieldbase ct_ctx += #setting_base ct_ctx
function cardtable:settings/choice {"field":3,"value":0,"label":"书本"}
function cardtable:settings/choice {"field":3,"value":1,"label":"对话框（提交需 OP）"}
function cardtable:settings/show_8 with storage cardtable:settings
