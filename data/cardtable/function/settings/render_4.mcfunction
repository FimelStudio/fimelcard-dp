execute unless score @s ab_goal matches 1..32 run scoreboard players set @s ab_goal 8
scoreboard players operation #setting_current ct_ctx = @s ab_goal
data modify storage cardtable:settings field1 set value {"text":"获胜分数：","color":"gray","extra":[]}
scoreboard players set #setting_fieldbase ct_ctx 1000
scoreboard players operation #setting_fieldbase ct_ctx += #setting_base ct_ctx
data modify storage cardtable:settings field set value 1
execute store result storage cardtable:settings current int 1 run scoreboard players get #setting_current ct_ctx
scoreboard players set #setting_low ct_ctx 1
scoreboard players set #setting_high ct_ctx 32
function cardtable:settings/numeric_choice {field:1,delta:-10,label:"−10"}
function cardtable:settings/numeric_choice {field:1,delta:-1,label:"−1"}
function cardtable:settings/current with storage cardtable:settings
function cardtable:settings/numeric_choice {field:1,delta:1,label:"+1"}
function cardtable:settings/numeric_choice {field:1,delta:10,label:"+10"}
function cardtable:settings/show_4 with storage cardtable:settings
