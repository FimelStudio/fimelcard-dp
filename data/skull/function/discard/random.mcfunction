$data modify storage skull:io discard_pool set from entity @s data.skull.seats.s$(seat).owned
execute store result score #size sk_ctx run data get storage skull:io discard_pool
execute store result storage skull:io random.max int 1 run scoreboard players remove #size sk_ctx 1
function skull:discard/draw with storage skull:io random
