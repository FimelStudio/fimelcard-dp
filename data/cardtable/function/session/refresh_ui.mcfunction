execute if score @s ct_game matches 3 run function hanabi:input/restore_table
execute if score @s ct_game matches 4 run function abraca:game/resume
execute if score @s ct_game matches 5 run function bullshit:game/resume
execute if score @s ct_game matches 6 run function decrypto:game/resume
execute if score @s ct_game matches 7 run function critical_point:game/resume
execute if score @s ct_game matches 9 run function skull:game/resume
execute if score @s ct_game matches 10 as @a[tag=dd.player,tag=ct.player] if score @s ct_id = #session_table ct_ctx run function doudizhu:input/give
execute if score @s ct_game matches 10 run function doudizhu:system/refresh
execute if score @s ct_game matches 11 run function uno:system/context
execute if score @s ct_game matches 11 run function uno:ui/refresh
execute if score @s ct_game matches 11 run function uno:hud/refresh
execute if score @s ct_game matches 12 run function chess:system/context
execute if score @s ct_game matches 12 run function chess:ui/refresh
execute if score @s ct_game matches 12 as @a[tag=ch.player,tag=ct.player] if score @s ct_id = #session_table ct_ctx run function chess:input/give
execute if score @s ct_game matches 13 run function xiangqi:system/context
execute if score @s ct_game matches 13 run function xiangqi:ui/refresh
execute if score @s ct_game matches 13 as @a[tag=xq.player,tag=ct.player] if score @s ct_id = #session_table ct_ctx run function xiangqi:input/give
execute if score @s ct_game matches 14 run function gomoku:system/context
execute if score @s ct_game matches 14 run function gomoku:ui/refresh
execute if score @s ct_game matches 14 as @a[tag=gm.player,tag=ct.player] if score @s ct_id = #session_table ct_ctx run function gomoku:input/give
execute if score @s ct_game matches 15 run function aeroplane_chess:system/context
execute if score @s ct_game matches 15 run function aeroplane_chess:ui/refresh
execute if score @s ct_game matches 16 run function avalon:context
execute if score @s ct_game matches 16 run function avalon:game/refresh
execute if score @s ct_game matches 17 run function love_letter:system/context
execute if score @s ct_game matches 17 run function love_letter:ui/refresh
execute if score @s ct_game matches 17 run function love_letter:hud/refresh
execute if score @s ct_game matches 18 run function guandan:system/context
execute if score @s ct_game matches 18 run function guandan:ui/refresh
execute if score @s ct_game matches 18 as @a[tag=gd.player,tag=ct.player] if score @s ct_id = #session_table ct_ctx run function guandan:input/give
execute if score @s ct_game matches 18 run function guandan:hud/refresh
execute if score @s ct_game matches 19 run function ito:system/context
execute if score @s ct_game matches 19 as @a[tag=it.player,tag=ct.player] if score @s ct_id = #session_table ct_ctx run function ito:input/give
execute if score @s ct_game matches 19 run function ito:hud/refresh
execute if score @s ct_game matches 20 run function weiqi:system/context
execute if score @s ct_game matches 20 run function weiqi:ui/refresh
execute if score @s ct_game matches 20 as @a[tag=go.player,tag=ct.player] if score @s ct_id = #session_table ct_ctx run function weiqi:input/give
execute if score @s ct_game matches 21 run function catan:system/context
execute if score @s ct_game matches 21 as @a[tag=ca.player,tag=ct.player] if score @s ct_id = #session_table ct_ctx run function catan:input/give
execute if score @s ct_game matches 22 run function splendor:system/context
execute if score @s ct_game matches 22 as @a[tag=sp.player,tag=ct.player] if score @s ct_id = #session_table ct_ctx run function splendor:input/give
execute if score @s ct_game matches 23 run function magical_athlete:system/context
execute if score @s ct_game matches 23 run function magical_athlete:ui/refresh
