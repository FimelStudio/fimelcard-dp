$execute unless score @s ca_side matches $(from) unless score @s ca_side matches $(to) run return run function catan:ui/open
function catan:ui/begin
scoreboard players set @s ca_panel 5
data modify storage catan:ui trade set from entity @e[tag=ca.current,limit=1] data.catan.trade
execute store result score @s ca_trade_id run data get storage catan:ui trade.id
data modify storage catan:ui trade.g0 set from storage catan:ui trade.offer[0]
data modify storage catan:ui trade.g1 set from storage catan:ui trade.offer[1]
data modify storage catan:ui trade.g2 set from storage catan:ui trade.offer[2]
data modify storage catan:ui trade.g3 set from storage catan:ui trade.offer[3]
data modify storage catan:ui trade.g4 set from storage catan:ui trade.offer[4]
data modify storage catan:ui trade.w0 set from storage catan:ui trade.want[0]
data modify storage catan:ui trade.w1 set from storage catan:ui trade.want[1]
data modify storage catan:ui trade.w2 set from storage catan:ui trade.want[2]
data modify storage catan:ui trade.w3 set from storage catan:ui trade.want[3]
data modify storage catan:ui trade.w4 set from storage catan:ui trade.want[4]
function catan:ui/trade_names with storage catan:ui trade
function catan:ui/trade_note with storage catan:ui trade
execute if score @s ca_side = #ui_trade_to ca_ctx run function catan:ui/button {"code":360,"label":"同意交易","color":"green"}
function catan:ui/button {"code":361,"label":"拒绝／撤销","color":"red"}
function catan:ui/show with storage catan:ui
