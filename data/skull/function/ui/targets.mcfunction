execute store result storage skull:io flip.seat int 1 run scoreboard players get @s sk_lead
scoreboard players set #own sk_ctx 0
function skull:challenge/check_own with storage skull:io flip
execute if score #own sk_ctx matches 1 run return 0
execute store result storage skull:ui progress.done int 1 run scoreboard players get @s sk_flipped
execute store result storage skull:ui progress.goal int 1 run scoreboard players get @s sk_bid
function skull:ui/progress with storage skull:ui progress
execute if data entity @s data.skull.seats.s1.stack[-1] run function skull:ui/target_button {seat:1,choice:41}
execute if data entity @s data.skull.seats.s2.stack[-1] run function skull:ui/target_button {seat:2,choice:42}
execute if data entity @s data.skull.seats.s3.stack[-1] run function skull:ui/target_button {seat:3,choice:43}
execute if data entity @s data.skull.seats.s4.stack[-1] run function skull:ui/target_button {seat:4,choice:44}
