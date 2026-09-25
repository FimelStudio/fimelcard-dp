execute unless score @s wq_state matches 3 run return 0
data modify storage wenfei:panel lines set from entity @s data.wenfei.answer_lines
scoreboard players operation #ctx wq_ctx = @s wq_id
scoreboard players operation #page wq_ctx = @s wq_page
execute store result storage wenfei:panel args.table int 1 run scoreboard players get @s wq_id
execute as @a[tag=wq.player,scores={wq_guess=1}] if score @s wq_id = #ctx wq_ctx run function wenfei:title/build
