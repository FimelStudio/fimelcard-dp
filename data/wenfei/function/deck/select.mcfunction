$data modify entity @s data.wenfei.pool set from storage wenfei:catalog categories[$(category)].questions
$data modify entity @s data.wenfei.category set from storage wenfei:catalog categories[$(category)].name
data modify entity @s data.wenfei.deck set value []
function wenfei:deck/pick
function wenfei:deck/pick
function wenfei:deck/pick
function wenfei:deck/pick
function wenfei:deck/pick
execute store result storage wenfei:io draw.index int 1 run random value 0..4
function wenfei:deck/correct with storage wenfei:io draw
data remove entity @s data.wenfei.pool
