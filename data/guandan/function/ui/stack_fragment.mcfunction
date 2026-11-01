data modify storage guandan:ui fragment set value {text:"",font:"card:guandan/stack",color:"white",shadow_color:0,click_event:{action:"run_command",command:""},hover_event:{action:"show_text",value:{text:""}}}
$data modify storage guandan:ui fragment.text set from storage guandan:ui stack_columns[$(column)].cards[$(index)].slices[$(slice)]
$data modify storage guandan:ui fragment.click_event.command set from storage guandan:ui stack_columns[$(column)].cards[$(index)].command
$data modify storage guandan:ui fragment.hover_event.value.text set from storage guandan:ui stack_columns[$(column)].cards[$(index)].name
execute if score #ui_stack_index gd_ctx matches 1.. run data modify storage guandan:ui fragment.font set value "card:guandan/stack_joined"
data modify storage guandan:ui grid.extra append from storage guandan:ui fragment
data modify storage guandan:ui grid.extra append value {text:"",font:"card:guandan/stack_spacing"}
