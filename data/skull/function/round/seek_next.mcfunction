scoreboard players add #hops sk_ctx 1
execute if score #hops sk_ctx matches 9.. run return run function skull:game/player_left
scoreboard players add @s sk_turn 1
execute if score @s sk_turn matches 9.. run scoreboard players set @s sk_turn 1
function skull:player/audience
scoreboard players operation #turn sk_ctx = @s sk_turn
scoreboard players set #found sk_ctx 0
execute as @a[tag=sk.audience,scores={sk_pass=0}] if score @s sk_seat = #turn sk_ctx run scoreboard players set #found sk_ctx 1
execute if score #found sk_ctx matches 0 run return run function skull:round/seek_next
function skull:round/epoch
function skull:round/announce_turn
function skull:ui/refresh
