function catan:direct/turn_guard
execute unless score #direct_ready ca_ctx matches 1 run return 0
execute unless entity @e[tag=ca.current,scores={ca_state=3..4},limit=1] run function catan:direct/dev_phase
execute unless score #direct_ready ca_ctx matches 1 run return 0
execute if data entity @e[tag=ca.current,limit=1] data.catan{used_dev:1} run function catan:direct/dev_limit
