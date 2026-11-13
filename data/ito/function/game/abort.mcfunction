function ito:system/context
scoreboard players set @s it_state 0
execute as @a[tag=it.audience] run function ito:player/clear_state
function ito:game/remove
function cardtable:animation/deal/clear
function cardtable:game/return_lobby
