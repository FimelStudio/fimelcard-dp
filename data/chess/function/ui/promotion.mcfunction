function chess:input/context
execute unless entity @s[tag=ch.actor] run return 0
execute unless entity @e[tag=ch.current,scores={ch_state=3},limit=1] run return 0
execute unless score @s ch_side = @e[tag=ch.current,limit=1] ch_turn run return 0
function chess:ui/begin
function chess:ui/button {code:10,label:"升变为后",color:"gold"}
function chess:ui/button {code:11,label:"升变为车",color:"white"}
function chess:ui/button {code:12,label:"升变为象",color:"white"}
function chess:ui/button {code:13,label:"升变为马",color:"white"}
function chess:ui/button {code:9,label:"认输",color:"red"}
function chess:ui/promotion_show with storage chess:ui
tag @a[tag=ch.actor] remove ch.actor
