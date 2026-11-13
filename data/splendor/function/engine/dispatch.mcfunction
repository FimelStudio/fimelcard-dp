execute if score #code sp_ctx matches 1 run return run function splendor:engine/take
execute if score #code sp_ctx matches 2 run return run function splendor:engine/reserve
execute if score #code sp_ctx matches 3 run return run function splendor:engine/buy
execute if score #code sp_ctx matches 4 run return run function splendor:engine/discard
execute if score #code sp_ctx matches 5 run return run function splendor:engine/noble/select
return run function splendor:engine/error {id:9}
