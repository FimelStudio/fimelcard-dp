$data modify storage catan:engine state.winner set value $(player)
data modify storage catan:engine state.phase set value 11
data remove storage catan:engine state.trade
data remove storage catan:engine state.eligible
