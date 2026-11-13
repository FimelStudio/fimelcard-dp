function weiqi:engine/constants
execute store result score #row go_ctx run data get storage weiqi:runtime snapshot.board[0]
execute as @e[tag=go.board,scores={go_rank=0}] run function weiqi:engine/decode_cell
execute store result score #row go_ctx run data get storage weiqi:runtime snapshot.board[1]
execute as @e[tag=go.board,scores={go_rank=1}] run function weiqi:engine/decode_cell
execute store result score #row go_ctx run data get storage weiqi:runtime snapshot.board[2]
execute as @e[tag=go.board,scores={go_rank=2}] run function weiqi:engine/decode_cell
execute store result score #row go_ctx run data get storage weiqi:runtime snapshot.board[3]
execute as @e[tag=go.board,scores={go_rank=3}] run function weiqi:engine/decode_cell
execute store result score #row go_ctx run data get storage weiqi:runtime snapshot.board[4]
execute as @e[tag=go.board,scores={go_rank=4}] run function weiqi:engine/decode_cell
execute store result score #row go_ctx run data get storage weiqi:runtime snapshot.board[5]
execute as @e[tag=go.board,scores={go_rank=5}] run function weiqi:engine/decode_cell
execute store result score #row go_ctx run data get storage weiqi:runtime snapshot.board[6]
execute as @e[tag=go.board,scores={go_rank=6}] run function weiqi:engine/decode_cell
execute store result score #row go_ctx run data get storage weiqi:runtime snapshot.board[7]
execute as @e[tag=go.board,scores={go_rank=7}] run function weiqi:engine/decode_cell
execute store result score #row go_ctx run data get storage weiqi:runtime snapshot.board[8]
execute as @e[tag=go.board,scores={go_rank=8}] run function weiqi:engine/decode_cell
execute store result score #row go_ctx run data get storage weiqi:runtime snapshot.board[9]
execute as @e[tag=go.board,scores={go_rank=9}] run function weiqi:engine/decode_cell
execute store result score #row go_ctx run data get storage weiqi:runtime snapshot.board[10]
execute as @e[tag=go.board,scores={go_rank=10}] run function weiqi:engine/decode_cell
execute store result score #row go_ctx run data get storage weiqi:runtime snapshot.board[11]
execute as @e[tag=go.board,scores={go_rank=11}] run function weiqi:engine/decode_cell
execute store result score #row go_ctx run data get storage weiqi:runtime snapshot.board[12]
execute as @e[tag=go.board,scores={go_rank=12}] run function weiqi:engine/decode_cell
execute store result score #row go_ctx run data get storage weiqi:runtime snapshot.board[13]
execute as @e[tag=go.board,scores={go_rank=13}] run function weiqi:engine/decode_cell
execute store result score #row go_ctx run data get storage weiqi:runtime snapshot.board[14]
execute as @e[tag=go.board,scores={go_rank=14}] run function weiqi:engine/decode_cell
execute store result score #row go_ctx run data get storage weiqi:runtime snapshot.board[15]
execute as @e[tag=go.board,scores={go_rank=15}] run function weiqi:engine/decode_cell
execute store result score #row go_ctx run data get storage weiqi:runtime snapshot.board[16]
execute as @e[tag=go.board,scores={go_rank=16}] run function weiqi:engine/decode_cell
execute store result score #row go_ctx run data get storage weiqi:runtime snapshot.board[17]
execute as @e[tag=go.board,scores={go_rank=17}] run function weiqi:engine/decode_cell
execute store result score #row go_ctx run data get storage weiqi:runtime snapshot.board[18]
execute as @e[tag=go.board,scores={go_rank=18}] run function weiqi:engine/decode_cell
execute store result score @s go_turn run data get storage weiqi:runtime snapshot.turn
execute store result score @s go_moves run data get storage weiqi:runtime snapshot.moves
execute store result score @s go_passes run data get storage weiqi:runtime snapshot.passes
execute store result score @s go_bcap run data get storage weiqi:runtime snapshot.bcap
execute store result score @s go_wcap run data get storage weiqi:runtime snapshot.wcap
execute store result score @s go_btime run data get storage weiqi:runtime snapshot.btime
execute store result score @s go_wtime run data get storage weiqi:runtime snapshot.wtime
data modify entity @s data.weiqi.last set from storage weiqi:runtime snapshot.last
data modify entity @s data.weiqi.position set from storage weiqi:runtime snapshot.board
scoreboard players set @e[tag=go.board] go_dead 0
scoreboard players set @s go_result 0
function weiqi:engine/group/clear
