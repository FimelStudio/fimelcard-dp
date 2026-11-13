scoreboard players set #human_side go_ctx 1
execute if score @s go_first matches 0 store result score #human_side go_ctx run random value 0..1
execute if score #human_side go_ctx matches 0 run scoreboard players set #human_side go_ctx -1
execute if score @s go_first matches 1 run scoreboard players operation #human_side go_ctx = @a[tag=go.audience,limit=1] go_weight
scoreboard players operation @a[tag=go.audience,limit=1] go_side = #human_side go_ctx
scoreboard players operation @s go_bot = #human_side go_ctx
scoreboard players operation @s go_bot *= #minus go_ctx
