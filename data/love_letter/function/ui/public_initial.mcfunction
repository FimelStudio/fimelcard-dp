$execute unless data entity @e[tag=ll.current,limit=1] data.love_letter.public[$(index)] run return 0
$execute store result score #ui_card ll_ctx run data get entity @e[tag=ll.current,limit=1] data.love_letter.public[$(index)]
function love_letter:ui/role
data modify storage love_letter:ui rows.extra append from storage love_letter:ui role
data modify storage love_letter:ui rows.extra append value {text:"  "}
