title @s times 5 45 10
$title @s subtitle {text:"你用 ",color:"gold",extra:[$(role),{text:" 淘汰了 "},$(victim)]}
$execute if score #log_card ll_ctx matches 3 run title @s subtitle {text:"你在男爵比牌中淘汰了 ",color:"gold",extra:[$(victim)]}
title @s title {text:""}
