# 仅供独立 GameTest 世界使用，不加入生产 tick。
say CHESS_DIALOGS_BEGIN
data merge storage chess:ui {"phase":"轮到白方行棋。","buttons":[{"label":{"text":"认输"},"action":{"type":"minecraft:run_command","command":"trigger ch_action set 101"}}],"code":101,"label":"认输","color":"red"}
function chess:ui/show with storage chess:ui
say CHESS_DIALOG_PANEL_COMPILED
data modify storage chess:ui buttons set value []
function chess:ui/show with storage chess:ui
say CHESS_DIALOG_NOTICE_COMPILED
data modify storage chess:ui buttons set value [{"label":{"text":"认输"},"action":{"type":"minecraft:run_command","command":"trigger ch_action set 101"}}]
function chess:ui/promotion_show with storage chess:ui
say CHESS_DIALOG_PROMOTION_COMPILED
function chess:ui/button_append with storage chess:ui
scoreboard players set #ui_setting_base ch_ctx 100000000
data merge storage chess:settings {"board":0,"palette":0,"orient":0,"first":0,"time":10,"level":2,"hints":1,"close":100000000}
function chess:settings/root
say CHESS_DIALOG_SETTING_DEFAULT_COMPILED
data merge storage chess:settings {"board":0,"palette":0,"orient":0,"first":0,"time":0,"level":1,"hints":0,"close":100000000}
function chess:settings/root
say CHESS_DIALOG_SETTING_MINIMUM_COMPILED
data merge storage chess:settings {"board":4,"palette":3,"orient":1,"first":1,"time":30,"level":3,"hints":1,"close":100000000}
function chess:settings/root
say CHESS_DIALOG_SETTING_MAXIMUM_COMPILED
function chess:rules/show
say CHESS_DIALOG_RULES_COMPILED
say CHESS_DIALOGS_END
