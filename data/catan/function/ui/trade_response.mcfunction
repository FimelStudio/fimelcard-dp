execute unless data entity @e[tag=ca.current,limit=1] data.catan.trade run return run function catan:ui/open
data modify storage catan:ui trade set from entity @e[tag=ca.current,limit=1] data.catan.trade
function catan:ui/trade_guard with storage catan:ui trade
