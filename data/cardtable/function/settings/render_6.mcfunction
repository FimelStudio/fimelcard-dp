execute unless score @s dc_team_mode matches 0..1 run scoreboard players set @s dc_team_mode 0
scoreboard players operation #setting_current ct_ctx = @s dc_team_mode
data modify storage cardtable:settings field1 set value {"text":"组队方式：","color":"gray","extra":[]}
scoreboard players set #setting_fieldbase ct_ctx 1000
scoreboard players operation #setting_fieldbase ct_ctx += #setting_base ct_ctx
function cardtable:settings/choice {"field":1,"value":0,"label":"随机组队"}
function cardtable:settings/choice {"field":1,"value":1,"label":"按座位组队"}
execute unless score @s dc_round_limit matches 1..32 run scoreboard players set @s dc_round_limit 8
scoreboard players operation #setting_current ct_ctx = @s dc_round_limit
data modify storage cardtable:settings field2 set value {"text":"分队回合上限：","color":"gray","extra":[]}
scoreboard players set #setting_fieldbase ct_ctx 2000
scoreboard players operation #setting_fieldbase ct_ctx += #setting_base ct_ctx
data modify storage cardtable:settings field set value 2
execute store result storage cardtable:settings current int 1 run scoreboard players get #setting_current ct_ctx
scoreboard players set #setting_low ct_ctx 1
scoreboard players set #setting_high ct_ctx 32
function cardtable:settings/numeric_choice {field:2,delta:-10,label:"−10"}
function cardtable:settings/numeric_choice {field:2,delta:-1,label:"−1"}
function cardtable:settings/current with storage cardtable:settings
function cardtable:settings/numeric_choice {field:2,delta:1,label:"+1"}
function cardtable:settings/numeric_choice {field:2,delta:10,label:"+10"}
execute unless score @s dc_input matches 0..1 run scoreboard players set @s dc_input 0
scoreboard players operation #setting_current ct_ctx = @s dc_input
data modify storage cardtable:settings field3 set value {"text":"提示输入方式：","color":"gray","extra":[]}
scoreboard players set #setting_fieldbase ct_ctx 3000
scoreboard players operation #setting_fieldbase ct_ctx += #setting_base ct_ctx
function cardtable:settings/choice {"field":3,"value":0,"label":"书本"}
function cardtable:settings/choice {"field":3,"value":1,"label":"对话框（提交需 OP）"}
function cardtable:settings/show_6 with storage cardtable:settings
