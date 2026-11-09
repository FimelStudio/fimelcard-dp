function magical_athlete:system/context
function magical_athlete:feedback/reset
scoreboard players set @s ma_finish 0
scoreboard players set @s ma_anim 0
data remove entity @s data.magical_athlete.visual_queue
function magical_athlete:sound/stop
function magical_athlete:visual/clear
execute as @e[tag=ma.firework] if score @s ct_id = #table ma_ctx run kill @s
execute as @a[tag=ma.audience] run function magical_athlete:player/clear_state
function magical_athlete:settings/invalidate_table
function cardtable:animation/deal/clear
function cardtable:game/return_lobby
