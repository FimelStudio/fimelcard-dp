execute store result storage guandan:visual seat int 1 run scoreboard players get @s gd_seat
scoreboard players operation #vis_seat gd_ctx = @s gd_seat
scoreboard players operation #vis_index gd_ctx = @s gd_seat
scoreboard players remove #vis_index gd_ctx 1
execute store result storage guandan:visual seat_index int 1 run scoreboard players get #vis_index gd_ctx
function guandan:visual/seat with storage guandan:visual
data modify storage guandan:visual seat_data.name set value {text:"玩家"}
data modify storage guandan:visual seat_data.name set from entity @s data.gd_name
data modify storage guandan:visual seat_data.line set value ""
data modify storage guandan:visual seat_data.line set from entity @s data.last_label
execute store result storage guandan:visual seat_data.team int 1 run scoreboard players get @s gd_team
execute store result storage guandan:visual seat_data.rank int 1 run scoreboard players get @s gd_rank
data modify storage guandan:visual seat_data.count_text set value ""
execute if entity @e[tag=gd.current,scores={gd_show=1},limit=1] run function guandan:visual/count_text
data modify storage guandan:visual seat_data.turn_text set value ""
execute if score @s gd_seat = @e[tag=gd.current,limit=1] gd_turn run data modify storage guandan:visual seat_data.turn_text set value " ◀"
function guandan:visual/label_at with storage guandan:visual seat_data
# 只读取本桌公开出牌；绝不读取 gd.card 的玩家持有牌面。
data modify storage guandan:visual public set value []
data modify storage guandan:visual public set from entity @s data.last_play
scoreboard players set #playing gd_ctx 0
execute as @e[tag=gd.fx,tag=gd.playing] if score @s ct_id = #vis_table gd_ctx if score @s gd_v_seat = #vis_seat gd_ctx run scoreboard players set #playing gd_ctx 1
execute if data storage guandan:visual public[0] if score #playing gd_ctx matches 0 run function guandan:visual/public_group
