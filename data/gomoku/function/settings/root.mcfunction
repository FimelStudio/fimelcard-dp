data modify storage gomoku:settings size_row set value {"text":"棋盘大小\n","color":"white","extra":[]}
function gomoku:settings/choice {"key":"size","row":"size_row","value":13,"code":113,"label":"13×13"}
function gomoku:settings/choice {"key":"size","row":"size_row","value":15,"code":115,"label":"15×15"}
function gomoku:settings/choice {"key":"size","row":"size_row","value":19,"code":119,"label":"19×19"}
data modify storage gomoku:settings board_row set value {"text":"棋盘配色\n","color":"white","extra":[]}
function gomoku:settings/choice {"key":"board","row":"board_row","value":0,"code":200,"label":"经典"}
function gomoku:settings/choice {"key":"board","row":"board_row","value":1,"code":201,"label":"木色"}
data modify storage gomoku:settings orient_row set value {"text":"棋盘方向\n","color":"white","extra":[]}
function gomoku:settings/choice {"key":"orient","row":"orient_row","value":0,"code":400,"label":"黑方南侧"}
function gomoku:settings/choice {"key":"orient","row":"orient_row","value":1,"code":401,"label":"黑方西侧"}
data modify storage gomoku:settings first_row set value {"text":"黑白方分配\n","color":"white","extra":[]}
function gomoku:settings/choice {"key":"first","row":"first_row","value":0,"code":500,"label":"随机分配"}
function gomoku:settings/choice {"key":"first","row":"first_row","value":1,"code":501,"label":"按座位自行选边"}
data modify storage gomoku:settings time_row set value {"text":"每人计时\n","color":"white","extra":[]}
function gomoku:settings/choice {"key":"time","row":"time_row","value":0,"code":600,"label":"无限制"}
function gomoku:settings/choice {"key":"time","row":"time_row","value":5,"code":605,"label":"5分钟"}
function gomoku:settings/choice {"key":"time","row":"time_row","value":10,"code":610,"label":"10分钟"}
function gomoku:settings/choice {"key":"time","row":"time_row","value":15,"code":615,"label":"15分钟"}
function gomoku:settings/choice {"key":"time","row":"time_row","value":20,"code":620,"label":"20分钟"}
function gomoku:settings/choice {"key":"time","row":"time_row","value":25,"code":625,"label":"25分钟"}
function gomoku:settings/choice {"key":"time","row":"time_row","value":30,"code":630,"label":"30分钟"}
data modify storage gomoku:settings level_row set value {"text":"单人人机难度\n","color":"white","extra":[]}
function gomoku:settings/choice {"key":"level","row":"level_row","value":1,"code":701,"label":"简单"}
function gomoku:settings/choice {"key":"level","row":"level_row","value":2,"code":702,"label":"普通"}
function gomoku:settings/choice {"key":"level","row":"level_row","value":3,"code":703,"label":"困难"}
data modify storage gomoku:settings mark_row set value {"text":"最后一手标记\n","color":"white","extra":[]}
function gomoku:settings/choice {"key":"mark","row":"mark_row","value":0,"code":800,"label":"关闭"}
function gomoku:settings/choice {"key":"mark","row":"mark_row","value":1,"code":801,"label":"开启"}
data modify storage gomoku:settings coords_row set value {"text":"棋盘坐标\n","color":"white","extra":[]}
function gomoku:settings/choice {"key":"coords","row":"coords_row","value":0,"code":900,"label":"隐藏"}
function gomoku:settings/choice {"key":"coords","row":"coords_row","value":1,"code":901,"label":"显示"}
data modify storage gomoku:settings confirm_row set value {"text":"右键落子确认\n","color":"white","extra":[]}
function gomoku:settings/choice {"key":"confirm","row":"confirm_row","value":0,"code":1000,"label":"一次落子"}
function gomoku:settings/choice {"key":"confirm","row":"confirm_row","value":1,"code":1001,"label":"同点两次确认"}
function gomoku:settings/root_show with storage gomoku:settings
