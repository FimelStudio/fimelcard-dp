$execute unless data storage guandan:ui stack_columns[$(column)] run return 0
$execute store result score #ui_stack_count gd_ctx run data get storage guandan:ui stack_columns[$(column)].cards
$scoreboard players set #ui_stack_index gd_ctx $(line)
scoreboard players remove #ui_stack_count gd_ctx 1
scoreboard players operation #ui_stack_index gd_ctx < #ui_stack_count gd_ctx
$scoreboard players set #ui_stack_slice gd_ctx $(line)
scoreboard players operation #ui_stack_slice gd_ctx -= #ui_stack_index gd_ctx
execute if score #ui_stack_slice gd_ctx matches 6.. run return run function guandan:ui/stack_blank
$data modify storage guandan:ui stack_args set value {column:$(column)}
execute store result storage guandan:ui stack_args.index int 1 run scoreboard players get #ui_stack_index gd_ctx
execute store result storage guandan:ui stack_args.slice int 1 run scoreboard players get #ui_stack_slice gd_ctx
function guandan:ui/stack_fragment with storage guandan:ui stack_args
