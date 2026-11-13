# history[0] 是开局状态；pass 也有快照，故回退时两张表始终等长。
data modify storage weiqi:runtime snapshot set value {board:[],turn:1,moves:0,passes:0,bcap:0,wcap:0,btime:0,wtime:0,last:{}}
data modify storage weiqi:runtime snapshot.board set from storage weiqi:runtime position.board
data modify storage weiqi:runtime snapshot.last set from entity @s data.weiqi.last
execute store result storage weiqi:runtime snapshot.turn int 1 run scoreboard players get @s go_turn
execute store result storage weiqi:runtime snapshot.moves int 1 run scoreboard players get @s go_moves
execute store result storage weiqi:runtime snapshot.passes int 1 run scoreboard players get @s go_passes
execute store result storage weiqi:runtime snapshot.bcap int 1 run scoreboard players get @s go_bcap
execute store result storage weiqi:runtime snapshot.wcap int 1 run scoreboard players get @s go_wcap
execute store result storage weiqi:runtime snapshot.btime int 1 run scoreboard players get @s go_btime
execute store result storage weiqi:runtime snapshot.wtime int 1 run scoreboard players get @s go_wtime
data modify entity @s data.weiqi.history append from storage weiqi:runtime snapshot
data modify entity @s data.weiqi.positions append from storage weiqi:runtime position
data modify entity @s data.weiqi.position set from storage weiqi:runtime position.board
