# 桌角入口允许附近玩家旁观弃牌堆，桌号已由点击实体写入#ctx_id
dialog clear @s
function hanabi:dialog/discard/build
function hanabi:dialog/discard/show_public with storage hanabi:dialog
