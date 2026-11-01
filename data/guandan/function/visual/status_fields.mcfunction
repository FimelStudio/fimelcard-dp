execute store result storage guandan:visual level int 1 run scoreboard players get @e[tag=gd.current,limit=1] gd_level
execute if score @e[tag=gd.current,limit=1] gd_level matches 11 run data modify storage guandan:visual level set value "J"
execute if score @e[tag=gd.current,limit=1] gd_level matches 12 run data modify storage guandan:visual level set value "Q"
execute if score @e[tag=gd.current,limit=1] gd_level matches 13 run data modify storage guandan:visual level set value "K"
execute if score @e[tag=gd.current,limit=1] gd_level matches 14 run data modify storage guandan:visual level set value "A"
execute store result storage guandan:visual level0 int 1 run scoreboard players get @e[tag=gd.current,limit=1] gd_team0
execute if score @e[tag=gd.current,limit=1] gd_team0 matches 11 run data modify storage guandan:visual level0 set value "J"
execute if score @e[tag=gd.current,limit=1] gd_team0 matches 12 run data modify storage guandan:visual level0 set value "Q"
execute if score @e[tag=gd.current,limit=1] gd_team0 matches 13 run data modify storage guandan:visual level0 set value "K"
execute if score @e[tag=gd.current,limit=1] gd_team0 matches 14 run data modify storage guandan:visual level0 set value "A"
execute store result storage guandan:visual level1 int 1 run scoreboard players get @e[tag=gd.current,limit=1] gd_team1
execute if score @e[tag=gd.current,limit=1] gd_team1 matches 11 run data modify storage guandan:visual level1 set value "J"
execute if score @e[tag=gd.current,limit=1] gd_team1 matches 12 run data modify storage guandan:visual level1 set value "Q"
execute if score @e[tag=gd.current,limit=1] gd_team1 matches 13 run data modify storage guandan:visual level1 set value "K"
execute if score @e[tag=gd.current,limit=1] gd_team1 matches 14 run data modify storage guandan:visual level1 set value "A"
function guandan:visual/status_text with storage guandan:visual
