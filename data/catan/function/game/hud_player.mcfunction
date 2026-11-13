function catan:ui/guidance
execute store result storage catan:ui turn int 1 run scoreboard players get @e[tag=ca.current,limit=1] ca_turn
data modify storage catan:ui turn_name set value {text:"—",color:"gray"}
function catan:ui/turn_name with storage catan:ui
function catan:game/hud_text with storage catan:ui
