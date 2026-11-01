scoreboard players operation #seed go_ctx = @s go_sq
scoreboard players operation #color go_ctx = @s go_eff
function weiqi:engine/group/start
execute if score #libs go_ctx matches 0 as @e[tag=go.board,tag=go.group] run function weiqi:engine/capture/remove
