scoreboard players add @s bw_turn 1
execute if score @s bw_turn matches 9.. run scoreboard players set @s bw_turn 1
scoreboard players operation #seat bw_ctx = @s bw_turn
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx if score @s bw_seat = #seat bw_ctx run tag @s add bw.next_smart
execute if entity @a[tag=bw.next_smart,limit=1] run scoreboard players set #found bw_ctx 1
