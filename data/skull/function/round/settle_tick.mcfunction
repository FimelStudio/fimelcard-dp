scoreboard players remove @s sk_timer 1
execute if score @s sk_timer matches 1.. run return 0
function skull:player/audience
scoreboard players operation @s sk_first = @s sk_lead
scoreboard players operation #first sk_ctx = @s sk_first
scoreboard players set #found sk_ctx 0
execute as @a[tag=sk.audience] if score @s sk_seat = #first sk_ctx run scoreboard players set #found sk_ctx 1
scoreboard players set #hops sk_ctx 0
execute if score #found sk_ctx matches 0 run return run function skull:round/seek_first
function skull:round/begin
