execute unless score @s hb_clue_max matches 1..32 run scoreboard players set @s hb_clue_max 8
scoreboard players operation #setting_current ct_ctx = @s hb_clue_max
data modify storage cardtable:settings field1 set value {"text":"提示标记上限：","color":"gray","extra":[]}
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
execute unless score @s hb_strike_max matches 1..9 run scoreboard players set @s hb_strike_max 3
scoreboard players operation #setting_current ct_ctx = @s hb_strike_max
data modify storage cardtable:settings field2 set value {"text":"允许失误次数：","color":"gray","extra":[]}
scoreboard players set #setting_fieldbase ct_ctx 2000
scoreboard players operation #setting_fieldbase ct_ctx += #setting_base ct_ctx
data modify storage cardtable:settings field set value 2
execute store result storage cardtable:settings current int 1 run scoreboard players get #setting_current ct_ctx
scoreboard players set #setting_low ct_ctx 1
scoreboard players set #setting_high ct_ctx 9
function cardtable:settings/numeric_choice {field:2,delta:-1,label:"−1"}
function cardtable:settings/current with storage cardtable:settings
function cardtable:settings/numeric_choice {field:2,delta:1,label:"+1"}
execute unless score @s hb_storm matches 0..1 run scoreboard players set @s hb_storm 0
scoreboard players operation #setting_current ct_ctx = @s hb_storm
data modify storage cardtable:settings field3 set value {"text":"彩色风暴扩展：","color":"gray","extra":[]}
scoreboard players set #setting_fieldbase ct_ctx 3000
scoreboard players operation #setting_fieldbase ct_ctx += #setting_base ct_ctx
function cardtable:settings/choice {"field":3,"value":0,"label":"关闭"}
function cardtable:settings/choice {"field":3,"value":1,"label":"开启"}
function cardtable:settings/show_3 with storage cardtable:settings
