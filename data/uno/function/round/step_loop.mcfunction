scoreboard players operation #u_seek un_ctx += #u_dir un_ctx
execute if score #u_seek un_ctx matches 9.. run scoreboard players set #u_seek un_ctx 1
execute if score #u_seek un_ctx matches ..0 run scoreboard players set #u_seek un_ctx 8
scoreboard players add #u_steps un_ctx 1
scoreboard players set #u_found un_ctx 0
execute as @e[tag=un.audience] if score @s un_seat = #u_seek un_ctx run scoreboard players set #u_found un_ctx 1
execute if score #u_found un_ctx matches 0 if score #u_steps un_ctx matches ..7 run function uno:round/step_loop
