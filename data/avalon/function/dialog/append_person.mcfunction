function avalon:name/resolve
$data modify storage avalon:ui dialog.actions append value {label:{text:"$(mark)",extra:[]},width:210,action:{type:"minecraft:run_command",command:"trigger av_action set $(button)"}}
data modify storage avalon:ui dialog.actions[-1].label.extra append from storage avalon:name resolved
