execute if score #hud_col un_ctx matches 18 run function uno:hud/next_row
execute store result storage uno:hud row int 1 run scoreboard players get #hud_row un_ctx
execute store result storage uno:hud count int 1 run scoreboard players get #hud_count un_ctx
$data modify storage uno:hud card set value {text:"$(glyph)",color:"white"}
$execute if score #hud_pick un_ctx matches $(id) run data modify storage uno:hud card.text set value "$(selected)"
function uno:hud/append with storage uno:hud
scoreboard players add #hud_col un_ctx 1
scoreboard players add #hud_types un_ctx 1
