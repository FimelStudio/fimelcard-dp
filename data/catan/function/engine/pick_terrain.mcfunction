$data modify storage catan:engine state.terrain[$(hex)] set from storage catan:engine bag[$(pick)]
$data modify storage catan:engine state.numbers[$(hex)] set value 0
$data remove storage catan:engine bag[$(pick)]
