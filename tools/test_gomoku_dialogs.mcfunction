# 仅供独立 GameTest 世界使用，不加入生产 tick。
say GOMOKU_DIALOGS_BEGIN
data merge storage gomoku:ui {"phase":"轮到黑方行棋。","buttons":[{"label":{"text":"认输"},"action":{"type":"minecraft:run_command","command":"trigger gm_action set 101"}}],"code":101,"label":"认输","color":"black"}
function gomoku:ui/show with storage gomoku:ui
say GOMOKU_DIALOG_PANEL_COMPILED
data modify storage gomoku:ui buttons set value []
function gomoku:ui/show with storage gomoku:ui
say GOMOKU_DIALOG_NOTICE_COMPILED
data modify storage gomoku:ui buttons set value [{"label":{"text":"认输"},"action":{"type":"minecraft:run_command","command":"trigger gm_action set 101"}}]
function gomoku:ui/button_append with storage gomoku:ui
scoreboard players set #ui_setting_base gm_ctx 100000000
data merge storage gomoku:settings {"size":15,"board":0,"palette":0,"orient":0,"first":0,"time":10,"level":2,"mark":1,"coords":1,"confirm":0,"close":100000000}
function gomoku:settings/root
say GOMOKU_DIALOG_SETTING_DEFAULT_COMPILED
data merge storage gomoku:settings {"size":13,"board":0,"palette":0,"orient":0,"first":0,"time":0,"level":1,"mark":0,"coords":0,"confirm":0,"close":100000000}
function gomoku:settings/root
say GOMOKU_DIALOG_SETTING_MINIMUM_COMPILED
data merge storage gomoku:settings {"size":19,"board":1,"palette":0,"orient":1,"first":1,"time":30,"level":3,"mark":1,"coords":1,"confirm":1,"close":100000000}
function gomoku:settings/root
say GOMOKU_DIALOG_SETTING_MAXIMUM_COMPILED
data merge storage gomoku:coordinates {nonce:1000,size:19,row:"$(row)",col:"$(col)"}
function gomoku:ui/coordinates_show with storage gomoku:coordinates
function gomoku:rules/show
say GOMOKU_DIALOG_RULES_COMPILED
say GOMOKU_DIALOGS_END
