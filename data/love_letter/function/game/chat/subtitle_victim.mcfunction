title @s times 5 45 10
$title @s subtitle {text:"你被 ",color:"red",extra:[$(killer),{text:" 使用的 "},$(role),{text:" 淘汰"}]}
$execute if score #log_card ll_ctx matches 3 run title @s subtitle {text:"你在与 ",color:"red",extra:[$(killer),{text:" 的男爵比牌中被淘汰"}]}
execute if score #kill_seat ll_ctx = #log_dead ll_ctx run title @s subtitle {text:"你打出或弃置公主，已出局",color:"red"}
title @s title {text:""}
