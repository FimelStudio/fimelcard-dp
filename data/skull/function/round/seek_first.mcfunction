scoreboard players add #hops sk_ctx 1
execute if score #hops sk_ctx matches 9.. run return run function skull:game/player_left
scoreboard players add @s sk_first 1
execute if score @s sk_first matches 9.. run scoreboard players set @s sk_first 1
scoreboard players operation #first sk_ctx = @s sk_first
scoreboard players set #found sk_ctx 0
execute as @a[tag=sk.audience] if score @s sk_seat = #first sk_ctx run scoreboard players set #found sk_ctx 1
execute if score #found sk_ctx matches 0 run return run function skull:round/seek_first
function skull:round/begin
