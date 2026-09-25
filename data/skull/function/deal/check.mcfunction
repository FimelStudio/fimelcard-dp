scoreboard players operation #mod sk_ctx = @s sk_deal_time
scoreboard players set #four sk_ctx 4
scoreboard players operation #mod sk_ctx %= #four sk_ctx
execute if score #mod sk_ctx matches 0 run function skull:deal/step
