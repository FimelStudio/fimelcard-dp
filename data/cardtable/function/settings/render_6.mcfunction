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
execute unless score @s dc_encode_limit matches 0..5 run scoreboard players set @s dc_encode_limit 0
scoreboard players operation #setting_current ct_ctx = @s dc_encode_limit
data modify storage cardtable:settings field4 set value {"text":"加密限时：","color":"gray","extra":[]}
scoreboard players set #setting_fieldbase ct_ctx 4000
scoreboard players operation #setting_fieldbase ct_ctx += #setting_base ct_ctx
function cardtable:settings/choice {"field":4,"value":0,"label":"无限制"}
function cardtable:settings/choice {"field":4,"value":1,"label":"60秒"}
function cardtable:settings/choice {"field":4,"value":2,"label":"90秒"}
function cardtable:settings/choice {"field":4,"value":3,"label":"120秒"}
function cardtable:settings/choice {"field":4,"value":4,"label":"180秒"}
function cardtable:settings/choice {"field":4,"value":5,"label":"240秒"}
execute unless score @s dc_guess_limit matches 0..5 run scoreboard players set @s dc_guess_limit 0
scoreboard players operation #setting_current ct_ctx = @s dc_guess_limit
data modify storage cardtable:settings field5 set value {"text":"拦截＋解密限时：","color":"gray","extra":[]}
scoreboard players set #setting_fieldbase ct_ctx 5000
scoreboard players operation #setting_fieldbase ct_ctx += #setting_base ct_ctx
function cardtable:settings/choice {"field":5,"value":0,"label":"无限制"}
function cardtable:settings/choice {"field":5,"value":1,"label":"60秒"}
function cardtable:settings/choice {"field":5,"value":2,"label":"90秒"}
function cardtable:settings/choice {"field":5,"value":3,"label":"120秒"}
function cardtable:settings/choice {"field":5,"value":4,"label":"180秒"}
function cardtable:settings/choice {"field":5,"value":5,"label":"240秒"}
function cardtable:settings/show_6 with storage cardtable:settings
