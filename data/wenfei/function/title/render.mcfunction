execute unless score @s wq_state matches 3 run return 0
data modify storage wenfei:panel lines set from entity @s data.wenfei.answer_lines
scoreboard players operation #ctx wq_ctx = @s wq_id
# 回答人数每四人一页；轮完人数页后再推进长答案的文本页。
scoreboard players operation #batches wq_ctx = @s wq_players
scoreboard players add #batches wq_ctx 2
scoreboard players set #four wq_ctx 4
scoreboard players operation #batches wq_ctx /= #four wq_ctx
scoreboard players operation #batch wq_ctx = @s wq_page
scoreboard players operation #batch wq_ctx %= #batches wq_ctx
scoreboard players operation #page wq_ctx = @s wq_page
scoreboard players operation #page wq_ctx /= #batches wq_ctx
execute store result storage wenfei:panel args.table int 1 run scoreboard players get @s wq_id
execute as @a[tag=wq.player,scores={wq_guess=1}] if score @s wq_id = #ctx wq_ctx run function wenfei:title/build
