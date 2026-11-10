scoreboard players operation #raw dc_ctx = @s dc_action
scoreboard players set @s dc_action 0
scoreboard players set #thousand dc_ctx 1000
scoreboard players operation #dnum dc_ctx = #raw dc_ctx
scoreboard players operation #dnum dc_ctx /= #thousand dc_ctx
scoreboard players operation #inum dc_ctx = #raw dc_ctx
scoreboard players operation #inum dc_ctx %= #thousand dc_ctx
data modify storage decrypto:sync incoming set value {d:"",i:""}
execute store result storage decrypto:sync incoming.t int 1 run scoreboard players get @s dc_id
execute store result storage decrypto:sync incoming.n int 1 run scoreboard players get @s dc_sform
execute if score #dnum dc_ctx matches 123 run data modify storage decrypto:sync incoming.d set value "123"
execute if score #dnum dc_ctx matches 124 run data modify storage decrypto:sync incoming.d set value "124"
execute if score #dnum dc_ctx matches 132 run data modify storage decrypto:sync incoming.d set value "132"
execute if score #dnum dc_ctx matches 134 run data modify storage decrypto:sync incoming.d set value "134"
execute if score #dnum dc_ctx matches 142 run data modify storage decrypto:sync incoming.d set value "142"
execute if score #dnum dc_ctx matches 143 run data modify storage decrypto:sync incoming.d set value "143"
execute if score #dnum dc_ctx matches 213 run data modify storage decrypto:sync incoming.d set value "213"
execute if score #dnum dc_ctx matches 214 run data modify storage decrypto:sync incoming.d set value "214"
execute if score #dnum dc_ctx matches 231 run data modify storage decrypto:sync incoming.d set value "231"
execute if score #dnum dc_ctx matches 234 run data modify storage decrypto:sync incoming.d set value "234"
execute if score #dnum dc_ctx matches 241 run data modify storage decrypto:sync incoming.d set value "241"
execute if score #dnum dc_ctx matches 243 run data modify storage decrypto:sync incoming.d set value "243"
execute if score #dnum dc_ctx matches 312 run data modify storage decrypto:sync incoming.d set value "312"
execute if score #dnum dc_ctx matches 314 run data modify storage decrypto:sync incoming.d set value "314"
execute if score #dnum dc_ctx matches 321 run data modify storage decrypto:sync incoming.d set value "321"
execute if score #dnum dc_ctx matches 324 run data modify storage decrypto:sync incoming.d set value "324"
execute if score #dnum dc_ctx matches 341 run data modify storage decrypto:sync incoming.d set value "341"
execute if score #dnum dc_ctx matches 342 run data modify storage decrypto:sync incoming.d set value "342"
execute if score #dnum dc_ctx matches 412 run data modify storage decrypto:sync incoming.d set value "412"
execute if score #dnum dc_ctx matches 413 run data modify storage decrypto:sync incoming.d set value "413"
execute if score #dnum dc_ctx matches 421 run data modify storage decrypto:sync incoming.d set value "421"
execute if score #dnum dc_ctx matches 423 run data modify storage decrypto:sync incoming.d set value "423"
execute if score #dnum dc_ctx matches 431 run data modify storage decrypto:sync incoming.d set value "431"
execute if score #dnum dc_ctx matches 432 run data modify storage decrypto:sync incoming.d set value "432"
execute if score #inum dc_ctx matches 123 run data modify storage decrypto:sync incoming.i set value "123"
execute if score #inum dc_ctx matches 124 run data modify storage decrypto:sync incoming.i set value "124"
execute if score #inum dc_ctx matches 132 run data modify storage decrypto:sync incoming.i set value "132"
execute if score #inum dc_ctx matches 134 run data modify storage decrypto:sync incoming.i set value "134"
execute if score #inum dc_ctx matches 142 run data modify storage decrypto:sync incoming.i set value "142"
execute if score #inum dc_ctx matches 143 run data modify storage decrypto:sync incoming.i set value "143"
execute if score #inum dc_ctx matches 213 run data modify storage decrypto:sync incoming.i set value "213"
execute if score #inum dc_ctx matches 214 run data modify storage decrypto:sync incoming.i set value "214"
execute if score #inum dc_ctx matches 231 run data modify storage decrypto:sync incoming.i set value "231"
execute if score #inum dc_ctx matches 234 run data modify storage decrypto:sync incoming.i set value "234"
execute if score #inum dc_ctx matches 241 run data modify storage decrypto:sync incoming.i set value "241"
execute if score #inum dc_ctx matches 243 run data modify storage decrypto:sync incoming.i set value "243"
execute if score #inum dc_ctx matches 312 run data modify storage decrypto:sync incoming.i set value "312"
execute if score #inum dc_ctx matches 314 run data modify storage decrypto:sync incoming.i set value "314"
execute if score #inum dc_ctx matches 321 run data modify storage decrypto:sync incoming.i set value "321"
execute if score #inum dc_ctx matches 324 run data modify storage decrypto:sync incoming.i set value "324"
execute if score #inum dc_ctx matches 341 run data modify storage decrypto:sync incoming.i set value "341"
execute if score #inum dc_ctx matches 342 run data modify storage decrypto:sync incoming.i set value "342"
execute if score #inum dc_ctx matches 412 run data modify storage decrypto:sync incoming.i set value "412"
execute if score #inum dc_ctx matches 413 run data modify storage decrypto:sync incoming.i set value "413"
execute if score #inum dc_ctx matches 421 run data modify storage decrypto:sync incoming.i set value "421"
execute if score #inum dc_ctx matches 423 run data modify storage decrypto:sync incoming.i set value "423"
execute if score #inum dc_ctx matches 431 run data modify storage decrypto:sync incoming.i set value "431"
execute if score #inum dc_ctx matches 432 run data modify storage decrypto:sync incoming.i set value "432"
function decrypto:sync/receive
