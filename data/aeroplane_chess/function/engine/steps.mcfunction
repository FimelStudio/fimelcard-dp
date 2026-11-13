execute if score #pos ac_ctx matches 57 run scoreboard players set #direction ac_ctx -1
scoreboard players operation #pos ac_ctx += #direction ac_ctx
data modify storage aeroplane_chess:runtime step set value {pos:0,kind:0,land:0}
execute store result storage aeroplane_chess:runtime step.pos int 1 run scoreboard players get #pos ac_ctx
data modify storage aeroplane_chess:runtime plan.queue append from storage aeroplane_chess:runtime step
scoreboard players remove #dice ac_ctx 1
execute if score #dice ac_ctx matches 1.. run function aeroplane_chess:engine/steps
