scoreboard players add @s av_leader 1
execute if score @s av_leader matches 9.. run scoreboard players set @s av_leader 1
scoreboard players operation #leader av_ctx = @s av_leader
execute as @a[tag=av.audience] if score @s av_seat = #leader av_ctx run scoreboard players set #found av_ctx 1
execute if score #found av_ctx matches 0 run function avalon:game/scan_leader
