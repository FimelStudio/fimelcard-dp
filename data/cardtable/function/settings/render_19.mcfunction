execute unless score @s it_mode matches 0..1 run scoreboard players set @s it_mode 0
scoreboard players operation #setting_current ct_ctx = @s it_mode
data modify storage cardtable:settings field1 set value {"text":"玩法模式：","color":"gray","extra":[]}
scoreboard players set #setting_fieldbase ct_ctx 1000
scoreboard players operation #setting_fieldbase ct_ctx += #setting_base ct_ctx
function cardtable:settings/choice {"field":1,"value":0,"label":"蛛丝 · 合作闯关"}
function cardtable:settings/choice {"field":1,"value":1,"label":"红线 · 配对抢分"}
execute unless score @s it_input matches 0..1 run scoreboard players set @s it_input 0
scoreboard players operation #setting_current ct_ctx = @s it_input
data modify storage cardtable:settings field2 set value {"text":"答案输入方式：","color":"gray","extra":[]}
scoreboard players set #setting_fieldbase ct_ctx 2000
scoreboard players operation #setting_fieldbase ct_ctx += #setting_base ct_ctx
function cardtable:settings/choice {"field":2,"value":0,"label":"书本"}
function cardtable:settings/choice {"field":2,"value":1,"label":"对话框（提交需 OP）"}
function cardtable:settings/show_19 with storage cardtable:settings
