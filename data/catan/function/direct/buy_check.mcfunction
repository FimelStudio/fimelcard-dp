function catan:direct/main_guard
execute unless score #direct_ready ca_ctx matches 1 run return 0
execute unless data entity @e[tag=ca.current,limit=1] data.catan.dev_deck[0] run return run function catan:direct/deck_empty
function catan:direct/cost {label:"购买发展卡",cost:[0,0,1,1,1]}
