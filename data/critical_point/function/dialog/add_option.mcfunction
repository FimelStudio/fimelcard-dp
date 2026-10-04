$data modify storage critical_point:dialog ui.actions append value {label:$(label),action:{type:"minecraft:run_command",command:"trigger cp_action set $(value)"}}
