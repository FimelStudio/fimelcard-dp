data modify storage weiqi:settings size_row set value {"text":"棋盘大小\n","color":"white","extra":[]}
function weiqi:settings/choice {"key":"size","row":"size_row","value":13,"code":113,"label":"13×13"}
function weiqi:settings/choice {"key":"size","row":"size_row","value":15,"code":115,"label":"15×15"}
function weiqi:settings/choice {"key":"size","row":"size_row","value":19,"code":119,"label":"19×19"}
data modify storage weiqi:settings board_row set value {"text":"棋盘配色\n","color":"white","extra":[]}
function weiqi:settings/choice {"key":"board","row":"board_row","value":0,"code":200,"label":"经典"}
function weiqi:settings/choice {"key":"board","row":"board_row","value":1,"code":201,"label":"木色"}
data modify storage weiqi:settings orient_row set value {"text":"棋盘方向\n","color":"white","extra":[]}
function weiqi:settings/choice {"key":"orient","row":"orient_row","value":0,"code":300,"label":"黑方南侧"}
function weiqi:settings/choice {"key":"orient","row":"orient_row","value":1,"code":301,"label":"黑方西侧"}
data modify storage weiqi:settings first_row set value {"text":"黑白方分配\n","color":"white","extra":[]}
function weiqi:settings/choice {"key":"first","row":"first_row","value":1,"code":401,"label":"按座位自行选边"}
function weiqi:settings/choice {"key":"first","row":"first_row","value":0,"code":400,"label":"随机分配"}
data modify storage weiqi:settings time_row set value {"text":"每人计时\n","color":"white","extra":[]}
function weiqi:settings/choice {"key":"time","row":"time_row","value":0,"code":500,"label":"无限制"}
function weiqi:settings/choice {"key":"time","row":"time_row","value":5,"code":505,"label":"5分钟"}
function weiqi:settings/choice {"key":"time","row":"time_row","value":10,"code":510,"label":"10分钟"}
function weiqi:settings/choice {"key":"time","row":"time_row","value":15,"code":515,"label":"15分钟"}
function weiqi:settings/choice {"key":"time","row":"time_row","value":20,"code":520,"label":"20分钟"}
function weiqi:settings/choice {"key":"time","row":"time_row","value":25,"code":525,"label":"25分钟"}
function weiqi:settings/choice {"key":"time","row":"time_row","value":30,"code":530,"label":"30分钟"}
data modify storage weiqi:settings komi_row set value {"text":"白方贴目\n","color":"white","extra":[]}
function weiqi:settings/choice {"key":"komi","row":"komi_row","value":0,"code":600,"label":"不贴目"}
function weiqi:settings/choice {"key":"komi","row":"komi_row","value":11,"code":611,"label":"5½目"}
function weiqi:settings/choice {"key":"komi","row":"komi_row","value":13,"code":613,"label":"6½目"}
function weiqi:settings/choice {"key":"komi","row":"komi_row","value":15,"code":615,"label":"7½目"}
function weiqi:settings/choice {"key":"komi","row":"komi_row","value":17,"code":617,"label":"8½目"}
data modify storage weiqi:settings level_row set value {"text":"单人人机难度\n","color":"white","extra":[]}
function weiqi:settings/choice {"key":"level","row":"level_row","value":1,"code":701,"label":"简单"}
function weiqi:settings/choice {"key":"level","row":"level_row","value":2,"code":702,"label":"普通"}
function weiqi:settings/choice {"key":"level","row":"level_row","value":3,"code":703,"label":"困难"}
data modify storage weiqi:settings coords_row set value {"text":"棋盘坐标\n","color":"white","extra":[]}
function weiqi:settings/choice {"key":"coords","row":"coords_row","value":0,"code":800,"label":"隐藏"}
function weiqi:settings/choice {"key":"coords","row":"coords_row","value":1,"code":801,"label":"显示"}
data modify storage weiqi:settings mark_row set value {"text":"最后一手标记\n","color":"white","extra":[]}
function weiqi:settings/choice {"key":"mark","row":"mark_row","value":0,"code":900,"label":"关闭"}
function weiqi:settings/choice {"key":"mark","row":"mark_row","value":1,"code":901,"label":"开启"}
data modify storage weiqi:settings confirm_row set value {"text":"右键落子确认\n","color":"white","extra":[]}
function weiqi:settings/choice {"key":"confirm","row":"confirm_row","value":0,"code":1000,"label":"一次落子"}
function weiqi:settings/choice {"key":"confirm","row":"confirm_row","value":1,"code":1001,"label":"同点两次确认"}
data modify storage weiqi:settings estimate_row set value {"text":"查看占地\n","color":"white","extra":[]}
function weiqi:settings/choice {"key":"estimate","row":"estimate_row","value":0,"code":1100,"label":"关闭"}
function weiqi:settings/choice {"key":"estimate","row":"estimate_row","value":1,"code":1101,"label":"允许"}
function weiqi:settings/root_show with storage weiqi:settings
