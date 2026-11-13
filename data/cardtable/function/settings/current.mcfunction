$data modify storage cardtable:settings option set value {text:" $(current) ",color:"gold",bold:true}
$data modify storage cardtable:settings field$(field).extra append from storage cardtable:settings option
