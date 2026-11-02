execute unless score @s dd_max matches 1..32 run scoreboard players set @s dd_max 1
scoreboard players operation #setting_current ct_ctx = @s dd_max
data modify storage cardtable:settings field1 set value {"text":"比赛局数：","color":"gray","extra":[]}
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
execute unless score @s dd_audio matches 0..1 run scoreboard players set @s dd_audio 1
scoreboard players operation #setting_current ct_ctx = @s dd_audio
data modify storage cardtable:settings field2 set value {"text":"游戏音乐：","color":"gray","extra":[]}
scoreboard players set #setting_fieldbase ct_ctx 2000
scoreboard players operation #setting_fieldbase ct_ctx += #setting_base ct_ctx
function cardtable:settings/choice {"field":2,"value":0,"label":"关闭"}
function cardtable:settings/choice {"field":2,"value":1,"label":"开启"}
execute unless score @s dd_bidmode matches 0..2 run scoreboard players set @s dd_bidmode 0
scoreboard players operation #setting_current ct_ctx = @s dd_bidmode
data modify storage cardtable:settings field3 set value {"text":"叫地主模式：","color":"gray","extra":[]}
scoreboard players set #setting_fieldbase ct_ctx 3000
scoreboard players operation #setting_fieldbase ct_ctx += #setting_base ct_ctx
function cardtable:settings/choice {"field":3,"value":0,"label":"叫分制"}
function cardtable:settings/choice {"field":3,"value":1,"label":"叫抢制"}
function cardtable:settings/choice {"field":3,"value":2,"label":"手速制"}
execute unless score @s dd_counts matches 0..1 run scoreboard players set @s dd_counts 1
scoreboard players operation #setting_current ct_ctx = @s dd_counts
data modify storage cardtable:settings field4 set value {"text":"显示剩余牌数：","color":"gray","extra":[]}
scoreboard players set #setting_fieldbase ct_ctx 4000
scoreboard players operation #setting_fieldbase ct_ctx += #setting_base ct_ctx
function cardtable:settings/choice {"field":4,"value":0,"label":"隐藏"}
function cardtable:settings/choice {"field":4,"value":1,"label":"显示"}
execute unless score @s dd_counter matches 0..1 run scoreboard players set @s dd_counter 0
scoreboard players operation #setting_current ct_ctx = @s dd_counter
data modify storage cardtable:settings field5 set value {"text":"记牌器：","color":"gray","extra":[]}
scoreboard players set #setting_fieldbase ct_ctx 5000
scoreboard players operation #setting_fieldbase ct_ctx += #setting_base ct_ctx
function cardtable:settings/choice {"field":5,"value":0,"label":"关闭"}
function cardtable:settings/choice {"field":5,"value":1,"label":"开启"}
execute unless score @s dd_noshuffle matches 0..1 run scoreboard players set @s dd_noshuffle 0
scoreboard players operation #setting_current ct_ctx = @s dd_noshuffle
data modify storage cardtable:settings field6 set value {"text":"洗牌模式：","color":"gray","extra":[]}
scoreboard players set #setting_fieldbase ct_ctx 6000
scoreboard players operation #setting_fieldbase ct_ctx += #setting_base ct_ctx
function cardtable:settings/choice {"field":6,"value":0,"label":"正常洗牌"}
function cardtable:settings/choice {"field":6,"value":1,"label":"不洗牌（多炸弹）"}
function cardtable:settings/show_10 with storage cardtable:settings
