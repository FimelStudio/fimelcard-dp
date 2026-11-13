scoreboard players operation @s ct_session = #session_id ct_ctx
scoreboard players set @s ct_paused 0
scoreboard players set @s ct_rejoin 0
scoreboard players set @s ct_online 1
tag @s remove ct.rejoining
function cardtable:settings/clear_session
function cardtable:chairs/settings/clear_session
scoreboard players add @e[tag=ct.session_build,limit=1] ct_expected 1
data modify storage cardtable:session member set value {}
data modify storage cardtable:session member.uuid set from entity @s UUID
execute store result storage cardtable:session member.seat int 1 run scoreboard players get @s ct_seat
data modify entity @e[tag=ct.session_build,limit=1] data.cardtable.members append from storage cardtable:session member
