execute if score @e[tag=it.current,limit=1] it_input matches 1 run return 0
function ito:input/focus
execute unless entity @e[tag=it.focus,limit=1] run return 0
execute store result storage ito:input table int 1 run scoreboard players get @s it_table
execute store result storage ito:input slot int 1 run scoreboard players get #slot it_ctx
execute store result storage ito:input round int 1 run scoreboard players get @e[tag=it.current,limit=1] it_round
execute store result storage ito:input number int 1 run scoreboard players get @e[tag=it.focus,limit=1] it_number
data modify storage ito:input content set value {pages:[""]}
data modify storage ito:input content.pages[0] set from entity @e[tag=it.focus,limit=1] data.description
function ito:input/book_item with storage ito:input
