execute store result storage skull:ui target.table int 1 run scoreboard players get @s sk_id
$data modify storage skull:ui target.seat set value $(seat)
scoreboard players operation #value sk_ctx = #base sk_ctx
$execute store result storage skull:ui target.value int 1 run scoreboard players add #value sk_ctx $(choice)
function skull:ui/target_label with storage skull:ui target
