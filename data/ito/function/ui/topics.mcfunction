data modify storage ito:ui label set from entity @e[tag=it.current,limit=1] data.ito.option1.text
scoreboard players operation #button it_ctx = #base it_ctx
scoreboard players add #button it_ctx 1
function ito:ui/button
data modify storage ito:ui label set from entity @e[tag=it.current,limit=1] data.ito.option2.text
scoreboard players operation #button it_ctx = #base it_ctx
scoreboard players add #button it_ctx 2
function ito:ui/button
