$execute if data storage cardtable:installation chunks[{x:$(x),z:$(z)}] run return 0
$data modify storage cardtable:installation chunk set value {x:$(x),z:$(z),existed:1b}
$execute in minecraft:overworld store success storage cardtable:installation chunk.existed byte 1 run forceload query $(x) $(z)
data modify storage cardtable:installation chunks append from storage cardtable:installation chunk
data remove storage cardtable:installation chunk
