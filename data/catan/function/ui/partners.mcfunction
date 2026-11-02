function catan:ui/begin
scoreboard players set @s ca_panel 2
data modify storage catan:ui title set value "卡坦岛 · 交易对象"
data modify storage catan:ui note set value {text:"选择交易对象；交易双方须包含当前行动者。",color:"aqua"}
execute unless score @s ca_side matches 1 if data entity @e[tag=ca.current,limit=1] data.catan.p1.name run function catan:ui/partner {side:1,code:501}
execute unless score @s ca_side matches 2 if data entity @e[tag=ca.current,limit=1] data.catan.p2.name run function catan:ui/partner {side:2,code:502}
execute unless score @s ca_side matches 3 if data entity @e[tag=ca.current,limit=1] data.catan.p3.name run function catan:ui/partner {side:3,code:503}
execute unless score @s ca_side matches 4 if data entity @e[tag=ca.current,limit=1] data.catan.p4.name run function catan:ui/partner {side:4,code:504}
function catan:ui/show with storage catan:ui
