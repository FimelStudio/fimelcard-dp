$data modify storage uno:hud rows[$(row)].cards.extra append from storage uno:hud card
$data modify storage uno:hud rows[$(row)].cards.extra append value {text:""}
$data modify storage uno:hud rows[$(row)].counts.extra append value {text:"x$(count)",color:"white"}
$data modify storage uno:hud rows[$(row)].counts.extra append value {text:""}
