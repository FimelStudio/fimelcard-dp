# 座号最小的玩家与其对座组成橙队。
function doudizhu:team/fixed_span
scoreboard players set #orange_seat dd_ctx 9
execute as @e[tag=dd.actors] run scoreboard players operation #orange_seat dd_ctx < @s dd_seat
scoreboard players operation #orange_opposite dd_ctx = #orange_seat dd_ctx
scoreboard players operation #orange_opposite dd_ctx += #seat_span dd_ctx
execute as @e[tag=dd.actors] if score @s dd_seat = #orange_seat dd_ctx run scoreboard players set @s dd_team 1
execute as @e[tag=dd.actors] if score @s dd_seat = #orange_opposite dd_ctx run scoreboard players set @s dd_team 1
