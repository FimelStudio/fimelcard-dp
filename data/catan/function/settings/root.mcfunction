data modify storage catan:settings layout_row set value {"text":"岛屿布局\n","color":"white","extra":[]}
function catan:settings/choice {"key":"layout","value":0,"code":100,"label":"推荐布局"}
function catan:settings/choice {"key":"layout","value":1,"code":101,"label":"随机布局"}
data modify storage catan:settings orient_row set value {"text":"棋盘方向\n","color":"white","extra":[]}
function catan:settings/choice {"key":"orient","value":0,"code":200,"label":"默认方向"}
function catan:settings/choice {"key":"orient","value":1,"code":201,"label":"旋转 90°"}
data modify storage catan:settings first_row set value {"text":"首位行动\n","color":"white","extra":[]}
function catan:settings/choice {"key":"first","value":0,"code":300,"label":"随机"}
function catan:settings/choice {"key":"first","value":1,"code":301,"label":"按座位"}
data modify storage catan:settings music_row set value {"text":"背景音乐\n","color":"white","extra":[]}
function catan:settings/choice {"key":"music","value":0,"code":400,"label":"关闭"}
function catan:settings/choice {"key":"music","value":1,"code":401,"label":"开启"}
function catan:settings/root_show with storage catan:settings
