data modify storage chess:settings board_row set value {"text":"棋盘配色\n","color":"white","extra":[]}
function chess:settings/choice {"key":"board","row":"board_row","value":0,"code":100,"label":"经典黑白"}
function chess:settings/choice {"key":"board","row":"board_row","value":1,"code":101,"label":"清新绿"}
function chess:settings/choice {"key":"board","row":"board_row","value":2,"code":102,"label":"胡桃木"}
function chess:settings/choice {"key":"board","row":"board_row","value":3,"code":103,"label":"海洋蓝"}
function chess:settings/choice {"key":"board","row":"board_row","value":4,"code":104,"label":"薰衣草紫"}
data modify storage chess:settings palette_row set value {"text":"棋子配色\n","color":"white","extra":[]}
function chess:settings/choice {"key":"palette","row":"palette_row","value":0,"code":200,"label":"黑白"}
function chess:settings/choice {"key":"palette","row":"palette_row","value":1,"code":201,"label":"木色"}
function chess:settings/choice {"key":"palette","row":"palette_row","value":2,"code":202,"label":"冰蓝"}
function chess:settings/choice {"key":"palette","row":"palette_row","value":3,"code":203,"label":"翡翠玉"}
data modify storage chess:settings orient_row set value {"text":"棋盘方向\n","color":"white","extra":[]}
function chess:settings/choice {"key":"orient","row":"orient_row","value":0,"code":300,"label":"南北向 · 白方南侧"}
function chess:settings/choice {"key":"orient","row":"orient_row","value":1,"code":301,"label":"东西向 · 白方西侧"}
data modify storage chess:settings first_row set value {"text":"黑白方分配\n","color":"white","extra":[]}
function chess:settings/choice {"key":"first","row":"first_row","value":1,"code":401,"label":"按座位自行选边"}
function chess:settings/choice {"key":"first","row":"first_row","value":0,"code":400,"label":"随机分配黑白"}
data modify storage chess:settings time_row set value {"text":"每人计时\n","color":"white","extra":[]}
function chess:settings/choice {"key":"time","row":"time_row","value":0,"code":500,"label":"无限制"}
function chess:settings/choice {"key":"time","row":"time_row","value":5,"code":505,"label":"5分钟"}
function chess:settings/choice {"key":"time","row":"time_row","value":10,"code":510,"label":"10分钟"}
function chess:settings/choice {"key":"time","row":"time_row","value":15,"code":515,"label":"15分钟"}
function chess:settings/choice {"key":"time","row":"time_row","value":20,"code":520,"label":"20分钟"}
function chess:settings/choice {"key":"time","row":"time_row","value":25,"code":525,"label":"25分钟"}
function chess:settings/choice {"key":"time","row":"time_row","value":30,"code":530,"label":"30分钟"}
data modify storage chess:settings level_row set value {"text":"单人人机难度\n","color":"white","extra":[]}
function chess:settings/choice {"key":"level","row":"level_row","value":1,"code":601,"label":"简单"}
function chess:settings/choice {"key":"level","row":"level_row","value":2,"code":602,"label":"普通"}
function chess:settings/choice {"key":"level","row":"level_row","value":3,"code":603,"label":"困难"}
data modify storage chess:settings hints_row set value {"text":"可走格提示\n","color":"white","extra":[]}
function chess:settings/choice {"key":"hints","row":"hints_row","value":0,"code":700,"label":"关闭"}
function chess:settings/choice {"key":"hints","row":"hints_row","value":1,"code":701,"label":"开启"}
function chess:settings/root_show with storage chess:settings
