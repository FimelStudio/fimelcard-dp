execute store result storage guandan:ui option_high int 1 run scoreboard players get #ui_high gd_ctx
execute if score #ui_high gd_ctx matches 1 run data modify storage guandan:ui option_high set value "A（低）"
execute if score #ui_high gd_ctx matches 11 run data modify storage guandan:ui option_high set value "J"
execute if score #ui_high gd_ctx matches 12 run data modify storage guandan:ui option_high set value "Q"
execute if score #ui_high gd_ctx matches 13 run data modify storage guandan:ui option_high set value "K"
execute if score #ui_high gd_ctx matches 14 run data modify storage guandan:ui option_high set value "A"
execute if score #ui_high gd_ctx matches 15 run data modify storage guandan:ui option_high set value "级牌"
execute if score #ui_high gd_ctx matches 16 run data modify storage guandan:ui option_high set value "小王"
execute if score #ui_high gd_ctx matches 17 run data modify storage guandan:ui option_high set value "大王"
