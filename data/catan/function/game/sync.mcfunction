execute store result score @s ca_state run data get entity @s data.catan.phase
execute store result score @s ca_epoch run data get entity @s data.catan.epoch
execute store result score @s ca_turn run data get entity @s data.catan.turn
execute store result score @s ca_winner run data get entity @s data.catan.winner
execute if score @s ca_state matches 1 run data modify entity @s data.catan.hint set value "放置村庄"
execute if score @s ca_state matches 2 run data modify entity @s data.catan.hint set value "放置相邻道路"
execute if score @s ca_state matches 3 run data modify entity @s data.catan.hint set value "等待投骰"
execute if score @s ca_state matches 4 run data modify entity @s data.catan.hint set value "建造／交易／结束回合"
execute if score @s ca_state matches 5 run data modify entity @s data.catan.hint set value "等待弃牌"
execute if score @s ca_state matches 6 run data modify entity @s data.catan.hint set value "移动强盗"
execute if score @s ca_state matches 7 run data modify entity @s data.catan.hint set value "选择偷取对象"
execute if score @s ca_state matches 8 run data modify entity @s data.catan.hint set value "免费修路"
execute if score @s ca_state matches 10 run data modify entity @s data.catan.hint set value "计算最长道路"
execute if score @s ca_state matches 11 run data modify entity @s data.catan.hint set value "对局结束"
