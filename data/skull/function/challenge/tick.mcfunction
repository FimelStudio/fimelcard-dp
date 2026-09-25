scoreboard players remove @s sk_timer 1
execute if score @s sk_timer matches 1.. run return 0
execute store result storage skull:io flip.seat int 1 run scoreboard players get @s sk_lead
function skull:challenge/own with storage skull:io flip
