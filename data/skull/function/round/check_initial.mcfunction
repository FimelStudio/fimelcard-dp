scoreboard players set #pending sk_ctx 0
execute as @a[tag=sk.audience,scores={sk_done=0}] run scoreboard players add #pending sk_ctx 1
execute if score #pending sk_ctx matches 1.. run return 0
scoreboard players set @s sk_state 2
function skull:round/epoch
function skull:round/announce_turn
function skull:ui/refresh
