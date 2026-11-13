execute unless score @s fc_max matches 1..999 run scoreboard players set @s fc_max 5
scoreboard players operation #setting_current ct_ctx = @s fc_max
data modify storage cardtable:settings field1 set value {"text":"比赛小局数：","color":"gray","extra":[]}
scoreboard players set #setting_fieldbase ct_ctx 1000
scoreboard players operation #setting_fieldbase ct_ctx += #setting_base ct_ctx
data modify storage cardtable:settings field set value 1
execute store result storage cardtable:settings current int 1 run scoreboard players get #setting_current ct_ctx
scoreboard players set #setting_low ct_ctx 1
scoreboard players set #setting_high ct_ctx 999
function cardtable:settings/numeric_choice {field:1,delta:-10,label:"−10"}
function cardtable:settings/numeric_choice {field:1,delta:-1,label:"−1"}
function cardtable:settings/current with storage cardtable:settings
function cardtable:settings/numeric_choice {field:1,delta:1,label:"+1"}
function cardtable:settings/numeric_choice {field:1,delta:10,label:"+10"}
execute unless score @s fc_rule matches 0..1 run scoreboard players set @s fc_rule 0
scoreboard players operation #setting_current ct_ctx = @s fc_rule
data modify storage cardtable:settings field2 set value {"text":"无效抢按立即判负：","color":"gray","extra":[]}
scoreboard players set #setting_fieldbase ct_ctx 2000
scoreboard players operation #setting_fieldbase ct_ctx += #setting_base ct_ctx
function cardtable:settings/choice {"field":2,"value":0,"label":"关闭"}
function cardtable:settings/choice {"field":2,"value":1,"label":"开启"}
function cardtable:settings/show_1 with storage cardtable:settings
