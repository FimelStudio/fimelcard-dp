scoreboard players set #usedjump ac_ctx 1
scoreboard players add #pos ac_ctx 4
data modify storage aeroplane_chess:runtime step set value {pos:0,kind:2,land:1}
execute store result storage aeroplane_chess:runtime step.pos int 1 run scoreboard players get #pos ac_ctx
data modify storage aeroplane_chess:runtime plan.queue append from storage aeroplane_chess:runtime step
