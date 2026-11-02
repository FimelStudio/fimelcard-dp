execute if score @s ct_game matches 3 run function hanabi:input/restore_table
execute if score @s ct_game matches 4 as @a[tag=ab.player] if score @s ct_id = #session_table ct_ctx run function abraca:input/give_tools
execute if score @s ct_game matches 5 as @a[tag=bw.player] if score @s ct_id = #session_table ct_ctx run function bullshit:input/give_tools
execute if score @s ct_game matches 9 run function skull:ui/refresh
execute if score @s ct_game matches 10 as @a[tag=dd.player] if score @s ct_id = #session_table ct_ctx run function doudizhu:input/give
execute if score @s ct_game matches 10 run function doudizhu:system/refresh
execute if score @s ct_game matches 11 run function uno:ui/refresh
execute if score @s ct_game matches 11 as @a[tag=un.player] if score @s ct_id = #session_table ct_ctx run function uno:input/give
execute if score @s ct_game matches 11 run function uno:hud/refresh
execute if score @s ct_game matches 12 run function chess:ui/refresh
execute if score @s ct_game matches 12 as @a[tag=ch.player] if score @s ct_id = #session_table ct_ctx run function chess:input/give
execute if score @s ct_game matches 13 run function xiangqi:ui/refresh
execute if score @s ct_game matches 13 as @a[tag=xq.player] if score @s ct_id = #session_table ct_ctx run function xiangqi:input/give
execute if score @s ct_game matches 14 run function gomoku:ui/refresh
execute if score @s ct_game matches 14 as @a[tag=gm.player] if score @s ct_id = #session_table ct_ctx run function gomoku:input/give
execute if score @s ct_game matches 15 run function aeroplane_chess:ui/refresh
execute if score @s ct_game matches 15 as @a[tag=ac.player] if score @s ct_id = #session_table ct_ctx run function aeroplane_chess:input/give
execute if score @s ct_game matches 17 run function love_letter:ui/refresh
execute if score @s ct_game matches 17 as @a[tag=ll.player] if score @s ct_id = #session_table ct_ctx run function love_letter:input/give
execute if score @s ct_game matches 17 as @a[tag=ll.player] if score @s ct_id = #session_table ct_ctx run function love_letter:input/give_tools
execute if score @s ct_game matches 17 run function love_letter:hud/refresh
execute if score @s ct_game matches 18 run function guandan:ui/refresh
execute if score @s ct_game matches 18 as @a[tag=gd.player] if score @s ct_id = #session_table ct_ctx run function guandan:input/give
execute if score @s ct_game matches 18 as @a[tag=gd.player] if score @s ct_id = #session_table ct_ctx run function guandan:input/give_tools
execute if score @s ct_game matches 18 run function guandan:hud/refresh
execute if score @s ct_game matches 19 as @a[tag=it.player] if score @s ct_id = #session_table ct_ctx run function ito:input/give
execute if score @s ct_game matches 19 run function ito:hud/refresh
execute if score @s ct_game matches 20 run function weiqi:ui/refresh
execute if score @s ct_game matches 20 as @a[tag=go.player] if score @s ct_id = #session_table ct_ctx run function weiqi:input/give
execute if score @s ct_game matches 21 as @a[tag=ca.player] if score @s ct_id = #session_table ct_ctx run function catan:input/give
