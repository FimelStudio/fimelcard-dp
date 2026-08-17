scoreboard players operation #ctx_id lh_ctx = @s lh_id
scoreboard players set #active lh_ctx 0
execute as @a[tag=lh.player,scores={lh_alive=1,lh_fold=0}] if score @s lh_id = #ctx_id lh_ctx run scoreboard players add #active lh_ctx 1
scoreboard players operation @s lh_active = #active lh_ctx
