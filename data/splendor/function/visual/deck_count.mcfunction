$data modify storage splendor:visual pose set from storage splendor:layout $(layout).deck_labels[$(slot)]
data modify storage splendor:visual kind set value 8
$data modify storage splendor:visual text set value {text:"$(count)",color:"gold",bold:true}
function splendor:visual/label_spawn
