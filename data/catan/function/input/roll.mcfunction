function catan:input/context
execute unless entity @s[tag=ca.actor] run return 0
execute unless entity @e[tag=ca.current,scores={ca_state=3},limit=1] run return run title @s actionbar {text:"此时无需掷骰；需要选择时用紫色染料按Q。",color:"yellow"}
scoreboard players operation @s ca_seen = @e[tag=ca.current,limit=1] ca_epoch
function catan:ui/simple {code:10}
