$data modify storage wenfei:ui button.label set value "$(points) 分"
scoreboard players operation #value wq_ctx = #base wq_ctx
$execute store result storage wenfei:ui button.value int 1 run scoreboard players add #value wq_ctx $(choice)
function wenfei:ui/button with storage wenfei:ui button
