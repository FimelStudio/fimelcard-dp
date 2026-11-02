# 已由本桌状态推进或核验过的玩家入口调用；不改 actor，避免打断正在提交的出牌。
execute unless entity @s[tag=un.player,tag=ct.player,tag=un.audience] run return 0
execute unless score @s un_table = @e[tag=un.current,limit=1] ct_id run return 0
execute unless score @s ct_id = @s un_table run return 0
execute unless score @e[tag=un.current,limit=1] un_state matches 3..4 run return 0
execute if score @e[tag=un.current,limit=1] un_state matches 4 unless score @s un_seat = @e[tag=un.current,limit=1] un_challenger run return run dialog clear @s
scoreboard players operation #ui_table un_ctx = @s un_table
scoreboard players operation @s un_seen = @e[tag=un.current,limit=1] un_epoch
scoreboard players operation #ui_base un_ctx = @s un_seen
scoreboard players set #ui_1000 un_ctx 1000
scoreboard players operation #ui_base un_ctx *= #ui_1000 un_ctx
function uno:ui/status
function uno:ui/controls
execute unless data storage uno:ui controls[0] run return 0
scoreboard players operation #ui_code un_ctx = #ui_base un_ctx
scoreboard players add #ui_code un_ctx 9
execute store result storage uno:ui reopen int 1 run scoreboard players get #ui_code un_ctx
scoreboard players set @s un_action 0
scoreboard players enable @s un_action
function uno:ui/response_show with storage uno:ui
