$execute unless data storage doudizhu:ui stack_columns[$(column)] run return 0
$execute store result score #stack_count dd_ctx run data get storage doudizhu:ui stack_columns[$(column)].cards
$scoreboard players set #stack_index dd_ctx $(line)
scoreboard players remove #stack_count dd_ctx 1
scoreboard players operation #stack_index dd_ctx < #stack_count dd_ctx
$scoreboard players set #stack_slice dd_ctx $(line)
scoreboard players operation #stack_slice dd_ctx -= #stack_index dd_ctx
execute if score #stack_slice dd_ctx matches 6.. run return run function doudizhu:dialog/stack_blank
$data modify storage doudizhu:ui stack_args set value {column:$(column)}
execute store result storage doudizhu:ui stack_args.index int 1 run scoreboard players get #stack_index dd_ctx
execute store result storage doudizhu:ui stack_args.slice int 1 run scoreboard players get #stack_slice dd_ctx
function doudizhu:dialog/stack_fragment with storage doudizhu:ui stack_args
