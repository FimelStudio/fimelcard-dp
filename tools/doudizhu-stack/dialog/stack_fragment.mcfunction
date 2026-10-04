data modify storage doudizhu:ui fragment set value {text:"",shadow_color:0,click_event:{action:"run_command",command:""},hover_event:{action:"show_text",value:""}}
$data modify storage doudizhu:ui fragment.text set from storage doudizhu:ui stack_columns[$(column)].cards[$(index)].slices[$(slice)]
$data modify storage doudizhu:ui fragment.font set from storage doudizhu:ui stack_columns[$(column)].cards[$(index)].label.font
$data modify storage doudizhu:ui fragment.click_event.command set from storage doudizhu:ui stack_columns[$(column)].cards[$(index)].action.command
$data modify storage doudizhu:ui fragment.hover_event.value set from storage doudizhu:ui stack_columns[$(column)].cards[$(index)].tooltip
data modify storage doudizhu:ui grid.extra append from storage doudizhu:ui fragment
data modify storage doudizhu:ui grid.extra append value {text:"\uE001",font:"card:doudizhu/stack_spacing"}
