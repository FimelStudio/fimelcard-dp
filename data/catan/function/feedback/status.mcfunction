execute if entity @e[tag=ca.current,scores={ca_state=5},limit=1] run function catan:feedback/discard_status
execute if data entity @e[tag=ca.current,limit=1] data.catan.trade run function catan:feedback/trade_status with entity @e[tag=ca.current,limit=1] data.catan.trade
