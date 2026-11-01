execute store result storage guandan:hud level int 1 run scoreboard players get @e[tag=gd.current,limit=1] gd_level
execute if score @e[tag=gd.current,limit=1] gd_level matches 11 run data modify storage guandan:hud level set value "J"
execute if score @e[tag=gd.current,limit=1] gd_level matches 12 run data modify storage guandan:hud level set value "Q"
execute if score @e[tag=gd.current,limit=1] gd_level matches 13 run data modify storage guandan:hud level set value "K"
execute if score @e[tag=gd.current,limit=1] gd_level matches 14 run data modify storage guandan:hud level set value "A"
function guandan:hud/level_text with storage guandan:hud
execute if score @e[tag=gd.current,limit=1] gd_state matches 1 run data modify storage fimel_title:io text.extra append value {text:" · 正在发牌",color:"gray"}
execute if score @e[tag=gd.current,limit=1] gd_state matches 2 run data modify storage fimel_title:io text.extra append value {text:" · 贡还牌",color:"yellow"}
execute if score @e[tag=gd.current,limit=1] gd_state matches 3 if score @s gd_seat = @e[tag=gd.current,limit=1] gd_turn run data modify storage fimel_title:io text.extra append value {text:" · 轮到你",color:"green"}
execute if score @e[tag=gd.current,limit=1] gd_state matches 3 unless score @s gd_seat = @e[tag=gd.current,limit=1] gd_turn run data modify storage fimel_title:io text.extra append value {text:" · 等待出牌",color:"gray"}
execute if score @e[tag=gd.current,limit=1] gd_state matches 4..5 run data modify storage fimel_title:io text.extra append value {text:" · 结算",color:"gold"}
scoreboard players operation #hud_status_y gd_ctx = #hud_maxdepth gd_ctx
scoreboard players set #hud_step gd_ctx 10
scoreboard players operation #hud_status_y gd_ctx *= #hud_step gd_ctx
scoreboard players add #hud_status_y gd_ctx 86
execute store result storage fimel_title:io y double 1 run scoreboard players get #hud_status_y gd_ctx
execute if score #hud_count gd_ctx matches 0 run data modify storage fimel_title:io y set value 38.0d
function guandan:hud/text_default
