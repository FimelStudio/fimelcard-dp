execute store result storage ito:input table int 1 run scoreboard players get @s it_table
function ito:input/dye_item with storage ito:input
scoreboard players operation #actor it_ctx = @s it_seat
scoreboard players set #slot it_ctx 1
function ito:input/book_return
scoreboard players set #slot it_ctx 2
function ito:input/book_return
scoreboard players set #slot it_ctx 3
function ito:input/book_return
