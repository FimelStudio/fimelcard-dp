$data modify storage catan:ui trade.from_name set from entity @e[tag=ca.current,limit=1] data.catan.p$(from).name
$data modify storage catan:ui trade.to_name set from entity @e[tag=ca.current,limit=1] data.catan.p$(to).name
$scoreboard players set #ui_trade_to ca_ctx $(to)
