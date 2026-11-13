scoreboard players set @s go_piece 0
scoreboard players set @s go_eff 0
scoreboard players add #captured go_ctx 1
execute store result storage weiqi:runtime captured_sq int 1 run scoreboard players get @s go_sq
data modify storage weiqi:runtime captured append from storage weiqi:runtime captured_sq
