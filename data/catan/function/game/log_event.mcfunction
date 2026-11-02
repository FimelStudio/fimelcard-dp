data modify storage catan:runtime log set from entity @s data.catan.last
data modify storage catan:runtime log.label set value "完成操作"
execute if data storage catan:runtime log{kind:"road"} run data modify storage catan:runtime log.label set value "修建道路"
execute if data storage catan:runtime log{kind:"settlement"} run data modify storage catan:runtime log.label set value "建造村庄"
execute if data storage catan:runtime log{kind:"city"} run data modify storage catan:runtime log.label set value "升级城市"
execute if data storage catan:runtime log{kind:"robber"} run data modify storage catan:runtime log.label set value "移动强盗"
execute if data storage catan:runtime log{kind:"development"} run data modify storage catan:runtime log.label set value "操作开发牌"
execute if data storage catan:runtime log{code:23} run data modify storage catan:runtime log.label set value "购买开发牌"
execute if data storage catan:runtime log{code:30,target:0} run data modify storage catan:runtime log.label set value "使用骑士"
execute if data storage catan:runtime log{code:30,target:1} run data modify storage catan:runtime log.label set value "使用修路"
execute if data storage catan:runtime log{code:30,target:2} run data modify storage catan:runtime log.label set value "使用垄断"
execute if data storage catan:runtime log{code:30,target:3} run data modify storage catan:runtime log.label set value "使用发明"
execute if data storage catan:runtime log{kind:"trade"} run data modify storage catan:runtime log.label set value "完成交易"
execute if data storage catan:runtime log{kind:"dice"} run function catan:game/log_dice with storage catan:runtime log
function catan:game/log_actor with storage catan:runtime log
