scoreboard players set #new_owner ca_ctx 0
execute if score #best_owner ca_ctx matches 1.. if score #metric_count ca_ctx matches 1 run scoreboard players operation #new_owner ca_ctx = #best_owner ca_ctx
execute store result storage catan:engine tmp.owner int 1 run scoreboard players get #old_owner ca_ctx
execute if score #best_owner ca_ctx matches 1.. if score #old_owner ca_ctx matches 1..4 run function catan:engine/award/keep with storage catan:engine tmp
