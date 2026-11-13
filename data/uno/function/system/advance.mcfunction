scoreboard players add #epoch un_ctx 1
execute if score #epoch un_ctx matches 2000001.. run scoreboard players set #epoch un_ctx 1
scoreboard players operation @s un_epoch = #epoch un_ctx
function uno:ui/refresh
function uno:hud/refresh
function uno:visual/update_status
