function doudizhu:hud/counter_count
data modify storage fimel_title:io font set value "minecraft:default_mod"
data modify storage fimel_title:io neg_font set value "minecraft:default_neg"
data modify storage fimel_title:io align set value "middle"
data modify storage fimel_title:io origin set value "up"
data modify storage fimel_title:io dx set value 0.0d
data modify storage fimel_title:io dy set value 0.0d
data modify storage doudizhu:counter label set value "大王"
data modify storage doudizhu:counter x set value -136.0d
execute store result storage doudizhu:counter count int 1 run scoreboard players get #counter_17 dd_ctx
function doudizhu:hud/counter_cell with storage doudizhu:counter
data modify storage doudizhu:counter label set value "小王"
data modify storage doudizhu:counter x set value -104.0d
execute store result storage doudizhu:counter count int 1 run scoreboard players get #counter_16 dd_ctx
function doudizhu:hud/counter_cell with storage doudizhu:counter
data modify storage doudizhu:counter label set value "2"
data modify storage doudizhu:counter x set value -80.0d
execute store result storage doudizhu:counter count int 1 run scoreboard players get #counter_15 dd_ctx
function doudizhu:hud/counter_cell with storage doudizhu:counter
data modify storage doudizhu:counter label set value "A"
data modify storage doudizhu:counter x set value -62.0d
execute store result storage doudizhu:counter count int 1 run scoreboard players get #counter_14 dd_ctx
function doudizhu:hud/counter_cell with storage doudizhu:counter
data modify storage doudizhu:counter label set value "K"
data modify storage doudizhu:counter x set value -44.0d
execute store result storage doudizhu:counter count int 1 run scoreboard players get #counter_13 dd_ctx
function doudizhu:hud/counter_cell with storage doudizhu:counter
data modify storage doudizhu:counter label set value "Q"
data modify storage doudizhu:counter x set value -26.0d
execute store result storage doudizhu:counter count int 1 run scoreboard players get #counter_12 dd_ctx
function doudizhu:hud/counter_cell with storage doudizhu:counter
data modify storage doudizhu:counter label set value "J"
data modify storage doudizhu:counter x set value -8.0d
execute store result storage doudizhu:counter count int 1 run scoreboard players get #counter_11 dd_ctx
function doudizhu:hud/counter_cell with storage doudizhu:counter
data modify storage doudizhu:counter label set value "10"
data modify storage doudizhu:counter x set value 10.0d
execute store result storage doudizhu:counter count int 1 run scoreboard players get #counter_10 dd_ctx
function doudizhu:hud/counter_cell with storage doudizhu:counter
data modify storage doudizhu:counter label set value "9"
data modify storage doudizhu:counter x set value 28.0d
execute store result storage doudizhu:counter count int 1 run scoreboard players get #counter_9 dd_ctx
function doudizhu:hud/counter_cell with storage doudizhu:counter
data modify storage doudizhu:counter label set value "8"
data modify storage doudizhu:counter x set value 46.0d
execute store result storage doudizhu:counter count int 1 run scoreboard players get #counter_8 dd_ctx
function doudizhu:hud/counter_cell with storage doudizhu:counter
data modify storage doudizhu:counter label set value "7"
data modify storage doudizhu:counter x set value 64.0d
execute store result storage doudizhu:counter count int 1 run scoreboard players get #counter_7 dd_ctx
function doudizhu:hud/counter_cell with storage doudizhu:counter
data modify storage doudizhu:counter label set value "6"
data modify storage doudizhu:counter x set value 82.0d
execute store result storage doudizhu:counter count int 1 run scoreboard players get #counter_6 dd_ctx
function doudizhu:hud/counter_cell with storage doudizhu:counter
data modify storage doudizhu:counter label set value "5"
data modify storage doudizhu:counter x set value 100.0d
execute store result storage doudizhu:counter count int 1 run scoreboard players get #counter_5 dd_ctx
function doudizhu:hud/counter_cell with storage doudizhu:counter
data modify storage doudizhu:counter label set value "4"
data modify storage doudizhu:counter x set value 118.0d
execute store result storage doudizhu:counter count int 1 run scoreboard players get #counter_4 dd_ctx
function doudizhu:hud/counter_cell with storage doudizhu:counter
data modify storage doudizhu:counter label set value "3"
data modify storage doudizhu:counter x set value 136.0d
execute store result storage doudizhu:counter count int 1 run scoreboard players get #counter_3 dd_ctx
function doudizhu:hud/counter_cell with storage doudizhu:counter
