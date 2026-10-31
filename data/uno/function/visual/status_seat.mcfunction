# 座号升序；双表号核验，不使用距离或其他桌残留的临时audience标签。
$execute as @e[tag=un.player,tag=ct.player,scores={un_seat=$(seat)}] if score @s un_table = #vis_table un_ctx if score @s ct_id = #vis_table un_ctx at @s run function uno:visual/status_player
