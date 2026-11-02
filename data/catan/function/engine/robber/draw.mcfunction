scoreboard players operation #max ca_ctx = #total ca_ctx
scoreboard players remove #max ca_ctx 1
execute store result storage catan:engine rng.max int 1 run scoreboard players get #max ca_ctx
function catan:engine/robber/random with storage catan:engine rng
scoreboard players set #chosen ca_ctx -1
execute if score #chosen ca_ctx matches -1 if score #draw ca_ctx < #o0 ca_ctx run scoreboard players set #chosen ca_ctx 0
execute if score #chosen ca_ctx matches -1 run scoreboard players operation #draw ca_ctx -= #o0 ca_ctx
execute if score #chosen ca_ctx matches -1 if score #draw ca_ctx < #o1 ca_ctx run scoreboard players set #chosen ca_ctx 1
execute if score #chosen ca_ctx matches -1 run scoreboard players operation #draw ca_ctx -= #o1 ca_ctx
execute if score #chosen ca_ctx matches -1 if score #draw ca_ctx < #o2 ca_ctx run scoreboard players set #chosen ca_ctx 2
execute if score #chosen ca_ctx matches -1 run scoreboard players operation #draw ca_ctx -= #o2 ca_ctx
execute if score #chosen ca_ctx matches -1 if score #draw ca_ctx < #o3 ca_ctx run scoreboard players set #chosen ca_ctx 3
execute if score #chosen ca_ctx matches -1 run scoreboard players operation #draw ca_ctx -= #o3 ca_ctx
execute if score #chosen ca_ctx matches -1 if score #draw ca_ctx < #o4 ca_ctx run scoreboard players set #chosen ca_ctx 4
execute if score #chosen ca_ctx matches -1 run scoreboard players operation #draw ca_ctx -= #o4 ca_ctx
execute if score #chosen ca_ctx matches 0 run scoreboard players remove #o0 ca_ctx 1
execute if score #chosen ca_ctx matches 0 run scoreboard players add #r0 ca_ctx 1
execute if score #chosen ca_ctx matches 1 run scoreboard players remove #o1 ca_ctx 1
execute if score #chosen ca_ctx matches 1 run scoreboard players add #r1 ca_ctx 1
execute if score #chosen ca_ctx matches 2 run scoreboard players remove #o2 ca_ctx 1
execute if score #chosen ca_ctx matches 2 run scoreboard players add #r2 ca_ctx 1
execute if score #chosen ca_ctx matches 3 run scoreboard players remove #o3 ca_ctx 1
execute if score #chosen ca_ctx matches 3 run scoreboard players add #r3 ca_ctx 1
execute if score #chosen ca_ctx matches 4 run scoreboard players remove #o4 ca_ctx 1
execute if score #chosen ca_ctx matches 4 run scoreboard players add #r4 ca_ctx 1
function catan:engine/save_resources with storage catan:engine request
function catan:engine/save_other with storage catan:engine request
data modify storage catan:engine state.last.stolen set value 1
