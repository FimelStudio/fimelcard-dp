$data modify storage avalon:ui dialog.body append value {type:"minecraft:plain_message",width:440,contents:{text:"$(label)",extra:[]}}
$data modify storage avalon:ui dialog.body[-1].contents.extra set from storage avalon:names $(kind)
