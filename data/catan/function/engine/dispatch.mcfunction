execute if score #code ca_ctx matches 1 run return run function catan:engine/setup/settlement
execute if score #code ca_ctx matches 2 run return run function catan:engine/setup/road
execute if score #code ca_ctx matches 10 run return run function catan:engine/roll
execute if score #code ca_ctx matches 11 run return run function catan:engine/discard
execute if score #code ca_ctx matches 12 run return run function catan:engine/robber/move
execute if score #code ca_ctx matches 13 run return run function catan:engine/robber/steal
execute if score #code ca_ctx matches 20 run return run function catan:engine/build/road
execute if score #code ca_ctx matches 21 run return run function catan:engine/build/settlement
execute if score #code ca_ctx matches 22 run return run function catan:engine/build/city
execute if score #code ca_ctx matches 23 run return run function catan:engine/development/buy
execute if score #code ca_ctx matches 29 run return run function catan:engine/end_turn
execute if score #code ca_ctx matches 30 run return run function catan:engine/development/play
execute if score #code ca_ctx matches 31 run return run function catan:engine/development/finish_roads
execute if score #code ca_ctx matches 40 run return run function catan:engine/trade/offer
execute if score #code ca_ctx matches 41 run return run function catan:engine/trade/accept
execute if score #code ca_ctx matches 42 run return run function catan:engine/trade/reject
execute if score #code ca_ctx matches 50 run return run function catan:engine/trade/bank
return run function catan:engine/error {id:9}
