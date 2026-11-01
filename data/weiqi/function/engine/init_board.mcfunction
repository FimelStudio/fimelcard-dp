function weiqi:engine/constants
scoreboard players set @e[tag=go.board] go_piece 0
scoreboard players set @e[tag=go.board] go_dead 0
scoreboard players set @e[tag=go.board] go_owner 0
scoreboard players set @e[tag=go.board] go_eff 0
scoreboard players set @s go_turn 1
scoreboard players set @s go_moves 0
scoreboard players set @s go_passes 0
scoreboard players set @s go_bcap 0
scoreboard players set @s go_wcap 0
scoreboard players set @s go_result 0
data modify entity @s data.weiqi.history set value []
data modify entity @s data.weiqi.positions set value []
data modify entity @s data.weiqi.last set value {sq:-1,side:0,captured:[],pass:1b}
function weiqi:engine/init_weights
function weiqi:engine/encode
function weiqi:engine/snapshot
