data modify storage magical_athlete:settings draft_row set value {"text":"角色分队：","color":"gray","extra":[]}
function magical_athlete:settings/choice {"key":"draft","value":0,"code":100,"label":"轮流选角"}
function magical_athlete:settings/choice {"key":"draft","value":1,"code":101,"label":"随机分队"}
data modify storage magical_athlete:settings track_row set value {"text":"比赛跑道：","color":"gray","extra":[]}
function magical_athlete:settings/choice {"key":"track","value":0,"code":200,"label":"普通／狂野交替"}
function magical_athlete:settings/choice {"key":"track","value":1,"code":201,"label":"全部普通"}
function magical_athlete:settings/choice {"key":"track","value":2,"code":202,"label":"全部狂野"}
data modify storage magical_athlete:settings music_row set value {"text":"背景音乐：","color":"gray","extra":[]}
function magical_athlete:settings/choice {"key":"music","value":0,"code":300,"label":"关闭"}
function magical_athlete:settings/choice {"key":"music","value":1,"code":301,"label":"开启"}
data modify storage magical_athlete:settings speed_row set value {"text":"动画速度：","color":"gray","extra":[]}
function magical_athlete:settings/choice {"key":"speed","value":0,"code":400,"label":"标准"}
function magical_athlete:settings/choice {"key":"speed","value":1,"code":401,"label":"快速"}
data modify storage magical_athlete:settings orient_row set value {"text":"棋盘方向：","color":"gray","extra":[]}
function magical_athlete:settings/choice {"key":"orient","value":0,"code":500,"label":"纵向"}
function magical_athlete:settings/choice {"key":"orient","value":1,"code":501,"label":"横向"}
function magical_athlete:settings/root_show with storage magical_athlete:settings
