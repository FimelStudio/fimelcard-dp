# 当前执行者为掉落物；仅接受加密者本人丢出的提示册。
execute unless data entity @s Thrower run return 0
data modify storage decrypto:input thrower set from entity @s Thrower
execute store success score #other dc_ctx run data modify storage decrypto:input thrower set from storage decrypto:input submitter_uuid
execute unless score #other dc_ctx matches 0 run return 0
tag @s add dc.submitted_book
execute as @e[type=minecraft:marker,tag=dc.controller,scores={dc_state=2}] at @s unless score @s dc_input matches 1 if score @s dc_id = #ctx dc_ctx if entity @a[tag=dc.submitter,scores={dc_team=1},limit=1] run function decrypto:input/accept_book
execute as @e[type=minecraft:marker,tag=dc.controller,scores={dc_state=4}] at @s unless score @s dc_input matches 1 if score @s dc_id = #ctx dc_ctx if entity @a[tag=dc.submitter,scores={dc_team=2},limit=1] run function decrypto:input/accept_book
tag @s remove dc.submitted_book
