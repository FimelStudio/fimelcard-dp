# 仅供独立 GameTest 世界使用，不加入生产 tick。
say XIANGQI_DIALOGS_BEGIN
data merge storage xiangqi:ui {"phase":"轮到红方行棋。","buttons":[{"label":{"text":"认输"},"action":{"type":"minecraft:run_command","command":"trigger xq_action set 101"}}],"code":101,"label":"认输","color":"red"}
function xiangqi:ui/show with storage xiangqi:ui
say XIANGQI_DIALOG_PANEL_COMPILED
data modify storage xiangqi:ui buttons set value []
function xiangqi:ui/show with storage xiangqi:ui
say XIANGQI_DIALOG_NOTICE_COMPILED
data modify storage xiangqi:ui buttons set value [{"label":{"text":"认输"},"action":{"type":"minecraft:run_command","command":"trigger xq_action set 101"}}]
function xiangqi:ui/button_append with storage xiangqi:ui
scoreboard players set #ui_setting_base xq_ctx 100000000
data merge storage xiangqi:settings {"board":0,"palette":0,"orient":0,"first":0,"time":10,"level":2,"hints":1,"close":100000000}
function xiangqi:settings/root
say XIANGQI_DIALOG_SETTING_DEFAULT_COMPILED
data merge storage xiangqi:settings {"board":0,"palette":0,"orient":0,"first":0,"time":0,"level":1,"hints":0,"close":100000000}
function xiangqi:settings/root
say XIANGQI_DIALOG_SETTING_MINIMUM_COMPILED
data merge storage xiangqi:settings {"board":4,"palette":3,"orient":1,"first":1,"time":30,"level":3,"hints":1,"close":100000000}
function xiangqi:settings/root
say XIANGQI_DIALOG_SETTING_MAXIMUM_COMPILED
function xiangqi:rules/show
say XIANGQI_DIALOG_RULES_COMPILED
say XIANGQI_DIALOGS_END
