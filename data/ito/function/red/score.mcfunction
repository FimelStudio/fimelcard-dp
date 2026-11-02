scoreboard players operation #sum it_ctx = @s it_sum
scoreboard players set #better it_ctx 0
execute as @a[tag=it.audience,scores={it_sum=1..99}] if score @s it_sum > #sum it_ctx run scoreboard players add #better it_ctx 1
execute if score #better it_ctx matches 0 run scoreboard players add @s it_total 2
execute if score #better it_ctx matches 2 run scoreboard players add @s it_total 1
