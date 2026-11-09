execute if data entity @e[tag=ca.current,limit=1] data.catan.trade run return run function catan:ui/trade_response
function catan:direct/look
execute if score #look_side ca_ctx matches 1..4 run return run function catan:direct/look_trade
execute unless score @s ca_side matches 1 if data entity @e[tag=ca.current,limit=1] data.catan.p1.name run function catan:direct/partner_tool {side:1}
execute unless score @s ca_side matches 2 if data entity @e[tag=ca.current,limit=1] data.catan.p2.name run function catan:direct/partner_tool {side:2}
execute unless score @s ca_side matches 3 if data entity @e[tag=ca.current,limit=1] data.catan.p3.name run function catan:direct/partner_tool {side:3}
execute unless score @s ca_side matches 4 if data entity @e[tag=ca.current,limit=1] data.catan.p4.name run function catan:direct/partner_tool {side:4}
function catan:hud/notice {"text":{"text":"手持目标玩家的交易物品按Q，打开单页报价编辑器。","color":"yellow"}}
