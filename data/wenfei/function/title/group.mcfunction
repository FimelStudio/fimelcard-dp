$execute unless data storage wenfei:panel lines.s$(seat) run return 0
$data modify storage wenfei:panel rows set from storage wenfei:panel lines.s$(seat)
execute store result score #rows wq_ctx run data get storage wenfei:panel rows
scoreboard players add #rows wq_ctx 1
scoreboard players set #two wq_ctx 2
scoreboard players operation #rows wq_ctx /= #two wq_ctx
execute if score #rows wq_ctx matches 0 run scoreboard players set #rows wq_ctx 1
scoreboard players operation #local_page wq_ctx = #page wq_ctx
scoreboard players operation #local_page wq_ctx %= #rows wq_ctx
scoreboard players operation #local_page wq_ctx *= #two wq_ctx
execute store result storage wenfei:panel args.first int 1 run scoreboard players get #local_page wq_ctx
execute store result storage wenfei:panel args.second int 1 run scoreboard players add #local_page wq_ctx 1
$data modify storage wenfei:panel args.seat set value $(seat)
execute store result storage wenfei:panel args.y int 1 run scoreboard players get #y wq_ctx
function wenfei:title/rows with storage wenfei:panel args
scoreboard players remove #y wq_ctx 34
