data modify storage weiqi:ui black_name set value {text:"黑方"}
data modify storage weiqi:ui white_name set value {text:"白方"}
data modify storage weiqi:ui black_name set from entity @e[tag=go.current,limit=1] data.weiqi.black_name
data modify storage weiqi:ui white_name set from entity @e[tag=go.current,limit=1] data.weiqi.white_name
data modify storage weiqi:ui turn set value "黑方"
execute if entity @e[tag=go.current,scores={go_turn=-1},limit=1] run data modify storage weiqi:ui turn set value "白方"
data modify storage weiqi:ui estimate_note set value "占地尚未查看；估算未判断死活，未定空点不计入。"
data modify storage weiqi:ui area_title set value "暂计占地"
execute if entity @a[tag=go.audience,scores={go_view=1}] run data modify storage weiqi:ui estimate_note set value "当前显示保守占地估算，未判断死活；未定空点不计入，标记同步于本桌棋盘。"
execute if entity @e[tag=go.current,scores={go_state=3},limit=1] run data modify storage weiqi:ui estimate_note set value "右键棋子，整组标记死子或恢复。双方确认后结算；有分歧可继续下棋。"
execute if entity @e[tag=go.current,scores={go_state=3..5},limit=1] run data modify storage weiqi:ui area_title set value "终局面积"
execute if entity @e[tag=go.current,scores={ct_state=0},limit=1] run data modify storage weiqi:ui area_title set value "终局面积"
function weiqi:ui/value_moves
function weiqi:ui/value_bcap
function weiqi:ui/value_wcap
function weiqi:ui/value_komi
function weiqi:ui/value_barea
function weiqi:ui/value_warea
function weiqi:ui/value_bterrit
function weiqi:ui/value_wterrit
function weiqi:ui/value_neutral
function weiqi:ui/value_bscore
function weiqi:ui/value_wscore
function weiqi:ui/value_review
function weiqi:ui/half {key:"komi"}
function weiqi:ui/half {key:"bscore"}
function weiqi:ui/half {key:"wscore"}
data modify storage weiqi:ui scoreline set value {text:""}
execute if entity @a[tag=go.audience,scores={go_view=1}] run function weiqi:ui/scoreline with storage weiqi:ui
execute if entity @e[tag=go.current,scores={go_state=3..5},limit=1] run function weiqi:ui/scoreline with storage weiqi:ui
execute if entity @e[tag=go.current,scores={ct_state=0},limit=1] run function weiqi:ui/scoreline with storage weiqi:ui
