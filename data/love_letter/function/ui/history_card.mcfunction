$execute unless data entity @s data.discards[$(index)] run return 0
$execute store result score #ui_card ll_ctx run data get entity @s data.discards[$(index)]
function love_letter:ui/role
data modify storage love_letter:ui rows.extra append from storage love_letter:ui role
data modify storage love_letter:ui rows.extra append value {text:"  "}
