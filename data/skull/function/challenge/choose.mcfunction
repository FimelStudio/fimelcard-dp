execute store result storage skull:io flip.seat int 1 run scoreboard players get @s sk_lead
scoreboard players set #own sk_ctx 0
function skull:challenge/check_own with storage skull:io flip
execute if score #own sk_ctx matches 1 run return 0
scoreboard players operation #target sk_ctx = #choice sk_ctx
scoreboard players remove #target sk_ctx 40
execute if score #target sk_ctx = @s sk_lead run return 0
scoreboard players operation @s sk_source = #target sk_ctx
execute store result storage skull:io flip.seat int 1 run scoreboard players get #target sk_ctx
function skull:challenge/flip with storage skull:io flip
