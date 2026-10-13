
$data modify storage fimel_skform:runtime temp.storage.$(key) set value $(default)
# $data modify $(storage).$(key) set value 0

$function fimel_sklibs:skapi_player/pdata/modify {base_path:"storage fimel_skform:runtime temp.pdata",path:"storage.$(key)",value:$(default)}
