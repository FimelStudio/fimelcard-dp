scoreboard players set @s wq_rank 1
scoreboard players operation #score wq_ctx = @s wq_score
scoreboard players set #rank wq_ctx 1
execute as @a[tag=wq.audience] if score @s wq_score > #score wq_ctx run scoreboard players add #rank wq_ctx 1
scoreboard players operation @s wq_rank = #rank wq_ctx
tellraw @a[tag=wq.audience] [{text:"第 "},{score:{name:"@s",objective:"wq_rank"}},{text:" 名 · "},{selector:"@s"},{text:"："},{score:{name:"@s",objective:"wq_score"}},{text:" 分"}]
