data modify storage catan:engine state.phase set value 6
data modify storage catan:engine state.robber_return set value 4
scoreboard players set #all_due ca_ctx 0
scoreboard players set #total ca_ctx 0
scoreboard players operation #total ca_ctx += #res1_0 ca_ctx
scoreboard players operation #total ca_ctx += #res1_1 ca_ctx
scoreboard players operation #total ca_ctx += #res1_2 ca_ctx
scoreboard players operation #total ca_ctx += #res1_3 ca_ctx
scoreboard players operation #total ca_ctx += #res1_4 ca_ctx
scoreboard players set #due ca_ctx 0
execute if score #total ca_ctx matches 8.. run scoreboard players operation #due ca_ctx = #total ca_ctx
scoreboard players operation #due ca_ctx /= #two ca_ctx
execute store result storage catan:engine state.p1.discard_due int 1 run scoreboard players get #due ca_ctx
scoreboard players operation #all_due ca_ctx += #due ca_ctx
scoreboard players set #total ca_ctx 0
scoreboard players operation #total ca_ctx += #res2_0 ca_ctx
scoreboard players operation #total ca_ctx += #res2_1 ca_ctx
scoreboard players operation #total ca_ctx += #res2_2 ca_ctx
scoreboard players operation #total ca_ctx += #res2_3 ca_ctx
scoreboard players operation #total ca_ctx += #res2_4 ca_ctx
scoreboard players set #due ca_ctx 0
execute if score #total ca_ctx matches 8.. run scoreboard players operation #due ca_ctx = #total ca_ctx
scoreboard players operation #due ca_ctx /= #two ca_ctx
execute store result storage catan:engine state.p2.discard_due int 1 run scoreboard players get #due ca_ctx
scoreboard players operation #all_due ca_ctx += #due ca_ctx
scoreboard players set #total ca_ctx 0
scoreboard players operation #total ca_ctx += #res3_0 ca_ctx
scoreboard players operation #total ca_ctx += #res3_1 ca_ctx
scoreboard players operation #total ca_ctx += #res3_2 ca_ctx
scoreboard players operation #total ca_ctx += #res3_3 ca_ctx
scoreboard players operation #total ca_ctx += #res3_4 ca_ctx
scoreboard players set #due ca_ctx 0
execute if score #total ca_ctx matches 8.. run scoreboard players operation #due ca_ctx = #total ca_ctx
scoreboard players operation #due ca_ctx /= #two ca_ctx
execute store result storage catan:engine state.p3.discard_due int 1 run scoreboard players get #due ca_ctx
scoreboard players operation #all_due ca_ctx += #due ca_ctx
scoreboard players set #total ca_ctx 0
scoreboard players operation #total ca_ctx += #res4_0 ca_ctx
scoreboard players operation #total ca_ctx += #res4_1 ca_ctx
scoreboard players operation #total ca_ctx += #res4_2 ca_ctx
scoreboard players operation #total ca_ctx += #res4_3 ca_ctx
scoreboard players operation #total ca_ctx += #res4_4 ca_ctx
scoreboard players set #due ca_ctx 0
execute if score #total ca_ctx matches 8.. run scoreboard players operation #due ca_ctx = #total ca_ctx
scoreboard players operation #due ca_ctx /= #two ca_ctx
execute store result storage catan:engine state.p4.discard_due int 1 run scoreboard players get #due ca_ctx
scoreboard players operation #all_due ca_ctx += #due ca_ctx
execute if score #all_due ca_ctx matches 1.. run data modify storage catan:engine state.phase set value 5
