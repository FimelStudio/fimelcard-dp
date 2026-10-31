data modify storage xiangqi:settings board_row set value {"text":"棋盘配色\n","color":"white","extra":[]}
function xiangqi:settings/choice {"key":"board","row":"board_row","value":0,"code":100,"label":"经典木色"}
function xiangqi:settings/choice {"key":"board","row":"board_row","value":1,"code":101,"label":"清新竹绿"}
function xiangqi:settings/choice {"key":"board","row":"board_row","value":2,"code":102,"label":"胡桃木"}
function xiangqi:settings/choice {"key":"board","row":"board_row","value":3,"code":103,"label":"海洋蓝"}
function xiangqi:settings/choice {"key":"board","row":"board_row","value":4,"code":104,"label":"薰衣草紫"}
data modify storage xiangqi:settings palette_row set value {"text":"棋子配色\n","color":"white","extra":[]}
function xiangqi:settings/choice {"key":"palette","row":"palette_row","value":0,"code":200,"label":"红黑"}
function xiangqi:settings/choice {"key":"palette","row":"palette_row","value":1,"code":201,"label":"木色"}
function xiangqi:settings/choice {"key":"palette","row":"palette_row","value":2,"code":202,"label":"冰蓝"}
function xiangqi:settings/choice {"key":"palette","row":"palette_row","value":3,"code":203,"label":"翡翠玉"}
data modify storage xiangqi:settings orient_row set value {"text":"棋盘方向\n","color":"white","extra":[]}
function xiangqi:settings/choice {"key":"orient","row":"orient_row","value":0,"code":300,"label":"南北向 · 红方南侧"}
function xiangqi:settings/choice {"key":"orient","row":"orient_row","value":1,"code":301,"label":"东西向 · 红方西侧"}
data modify storage xiangqi:settings first_row set value {"text":"红黑方分配\n","color":"white","extra":[]}
function xiangqi:settings/choice {"key":"first","row":"first_row","value":1,"code":401,"label":"按座位自行选边"}
function xiangqi:settings/choice {"key":"first","row":"first_row","value":0,"code":400,"label":"随机分配红黑"}
data modify storage xiangqi:settings time_row set value {"text":"每人计时\n","color":"white","extra":[]}
function xiangqi:settings/choice {"key":"time","row":"time_row","value":0,"code":500,"label":"无限制"}
function xiangqi:settings/choice {"key":"time","row":"time_row","value":5,"code":505,"label":"5分钟"}
function xiangqi:settings/choice {"key":"time","row":"time_row","value":10,"code":510,"label":"10分钟"}
function xiangqi:settings/choice {"key":"time","row":"time_row","value":15,"code":515,"label":"15分钟"}
function xiangqi:settings/choice {"key":"time","row":"time_row","value":20,"code":520,"label":"20分钟"}
function xiangqi:settings/choice {"key":"time","row":"time_row","value":25,"code":525,"label":"25分钟"}
function xiangqi:settings/choice {"key":"time","row":"time_row","value":30,"code":530,"label":"30分钟"}
data modify storage xiangqi:settings level_row set value {"text":"单人人机难度\n","color":"white","extra":[]}
function xiangqi:settings/choice {"key":"level","row":"level_row","value":1,"code":601,"label":"简单"}
function xiangqi:settings/choice {"key":"level","row":"level_row","value":2,"code":602,"label":"普通"}
function xiangqi:settings/choice {"key":"level","row":"level_row","value":3,"code":603,"label":"困难"}
data modify storage xiangqi:settings hints_row set value {"text":"可走格提示\n","color":"white","extra":[]}
function xiangqi:settings/choice {"key":"hints","row":"hints_row","value":0,"code":700,"label":"关闭"}
function xiangqi:settings/choice {"key":"hints","row":"hints_row","value":1,"code":701,"label":"开启"}
function xiangqi:settings/root_show with storage xiangqi:settings
