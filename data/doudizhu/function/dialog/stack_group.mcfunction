execute store result score #stack_rank dd_ctx run data get storage doudizhu:ui stack_queue[0].rank
execute unless score #stack_rank dd_ctx = #stack_previous dd_ctx run data modify storage doudizhu:ui stack_columns append value {cards:[]}
data modify storage doudizhu:ui stack_columns[-1].cards append from storage doudizhu:ui stack_queue[0]
scoreboard players operation #stack_previous dd_ctx = #stack_rank dd_ctx
data remove storage doudizhu:ui stack_queue[0]
execute if data storage doudizhu:ui stack_queue[0] run function doudizhu:dialog/stack_group
