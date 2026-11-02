scoreboard players set #rejoin_found ct_ctx 1
execute unless score @s ct_state matches 1 run return 0
execute unless score @s ct_session matches 1.. run return 0
execute if score @a[tag=ct.reconnect_actor,limit=1] ct_session = @s ct_session run scoreboard players set #rejoin_valid ct_ctx 1
# 仅允许尚未分配会话号的老版本成员加入迁移中的旧局。
execute if data entity @s data.cardtable{session_legacy:1b} unless score @a[tag=ct.reconnect_actor,limit=1] ct_session matches 1.. run function cardtable:session/legacy_member
execute unless score #rejoin_valid ct_ctx matches 1 run return 0
function cardtable:table/ensure_seats
scoreboard players operation #rejoin_session ct_ctx = @s ct_session
execute as @a[tag=ct.reconnect_actor,limit=1] run function cardtable:session/reattach_player
