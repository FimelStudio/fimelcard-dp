scoreboard players add @s go_moves 1
scoreboard players set @s go_passes 0
execute if score #side go_ctx matches 1 run scoreboard players operation @s go_bcap += #captured go_ctx
execute if score #side go_ctx matches -1 run scoreboard players operation @s go_wcap += #captured go_ctx
scoreboard players operation @s go_turn *= #minus go_ctx
data modify entity @s data.weiqi.last set value {sq:-1,side:0,captured:[],pass:0b}
execute store result entity @s data.weiqi.last.sq int 1 run scoreboard players get #to go_ctx
execute store result entity @s data.weiqi.last.side int 1 run scoreboard players get #side go_ctx
data modify entity @s data.weiqi.last.captured set from storage weiqi:runtime captured
function weiqi:engine/snapshot
