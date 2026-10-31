data modify storage aeroplane_chess:settings takeoff_row set value {"text":"起飞点数\n","color":"white","extra":[]}
function aeroplane_chess:settings/choice {"key":"takeoff","value":0,"code":100,"label":"6点"}
function aeroplane_chess:settings/choice {"key":"takeoff","value":1,"code":101,"label":"5～6点"}
function aeroplane_chess:settings/choice {"key":"takeoff","value":2,"code":102,"label":"任意点数"}
data modify storage aeroplane_chess:settings extra_row set value {"text":"六点追加投骰\n","color":"white","extra":[]}
function aeroplane_chess:settings/choice {"key":"extra","value":0,"code":200,"label":"关闭"}
function aeroplane_chess:settings/choice {"key":"extra","value":1,"code":201,"label":"开启"}
data modify storage aeroplane_chess:settings triple_row set value {"text":"连续三个六\n","color":"white","extra":[]}
function aeroplane_chess:settings/choice {"key":"triple","value":0,"code":300,"label":"无处罚"}
function aeroplane_chess:settings/choice {"key":"triple","value":1,"code":301,"label":"第三次失效并结束回合"}
data modify storage aeroplane_chess:settings jump_row set value {"text":"同色跳格\n","color":"white","extra":[]}
function aeroplane_chess:settings/choice {"key":"jump","value":0,"code":400,"label":"关闭"}
function aeroplane_chess:settings/choice {"key":"jump","value":1,"code":401,"label":"开启"}
data modify storage aeroplane_chess:settings fly_row set value {"text":"航线飞跃\n","color":"white","extra":[]}
function aeroplane_chess:settings/choice {"key":"fly","value":0,"code":500,"label":"关闭"}
function aeroplane_chess:settings/choice {"key":"fly","value":1,"code":501,"label":"开启"}
data modify storage aeroplane_chess:settings finish_row set value {"text":"终点超出\n","color":"white","extra":[]}
function aeroplane_chess:settings/choice {"key":"finish","value":0,"code":600,"label":"反弹"}
function aeroplane_chess:settings/choice {"key":"finish","value":1,"code":601,"label":"无法移动"}
data modify storage aeroplane_chess:settings orient_row set value {"text":"棋盘方向\n","color":"white","extra":[]}
function aeroplane_chess:settings/choice {"key":"orient","value":0,"code":800,"label":"红方南侧"}
function aeroplane_chess:settings/choice {"key":"orient","value":1,"code":801,"label":"红方西侧"}
data modify storage aeroplane_chess:settings first_row set value {"text":"首位行动\n","color":"white","extra":[]}
function aeroplane_chess:settings/choice {"key":"first","value":0,"code":900,"label":"随机"}
function aeroplane_chess:settings/choice {"key":"first","value":1,"code":901,"label":"红"}
function aeroplane_chess:settings/choice {"key":"first","value":2,"code":902,"label":"蓝"}
function aeroplane_chess:settings/choice {"key":"first","value":3,"code":903,"label":"绿"}
function aeroplane_chess:settings/choice {"key":"first","value":4,"code":904,"label":"黄"}
data modify storage aeroplane_chess:settings speed_row set value {"text":"动画速度\n","color":"white","extra":[]}
function aeroplane_chess:settings/choice {"key":"speed","value":0,"code":1000,"label":"标准"}
function aeroplane_chess:settings/choice {"key":"speed","value":1,"code":1001,"label":"快速"}
data modify storage aeroplane_chess:settings hints_row set value {"text":"可移动飞机提示\n","color":"white","extra":[]}
function aeroplane_chess:settings/choice {"key":"hints","value":0,"code":1100,"label":"关闭"}
function aeroplane_chess:settings/choice {"key":"hints","value":1,"code":1101,"label":"开启"}
data modify storage aeroplane_chess:settings fill_row set value {"text":"电脑补位\n","color":"white","extra":[]}
function aeroplane_chess:settings/choice {"key":"fill","value":2,"code":1202,"label":"关闭"}
function aeroplane_chess:settings/choice {"key":"fill","value":0,"code":1200,"label":"单人补一位"}
function aeroplane_chess:settings/choice {"key":"fill","value":1,"code":1201,"label":"补满四方"}
data modify storage aeroplane_chess:settings ranking_row set value {"text":"结束方式\n","color":"white","extra":[]}
function aeroplane_chess:settings/choice {"key":"ranking","value":0,"code":1300,"label":"首名产生即结束"}
function aeroplane_chess:settings/choice {"key":"ranking","value":1,"code":1301,"label":"继续排名"}
data modify storage aeroplane_chess:settings assign_row set value {"text":"玩家颜色\n","color":"white","extra":[]}
function aeroplane_chess:settings/choice {"key":"assign","value":0,"code":1400,"label":"按座位选色"}
function aeroplane_chess:settings/choice {"key":"assign","value":1,"code":1401,"label":"随机分配"}
function aeroplane_chess:settings/root_show with storage aeroplane_chess:settings
