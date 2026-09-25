scoreboard players operation #value sk_ctx = #base sk_ctx
$execute store result storage skull:ui button.value int 1 run scoreboard players add #value sk_ctx $(choice)
$data modify storage skull:ui button.label set value "$(label)"
function skull:ui/append_button with storage skull:ui button
