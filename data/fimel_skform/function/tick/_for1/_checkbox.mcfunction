


#$execute store result score fimel.skform.a fcs_lib run data get $(storage).$(key)[$(value)]

$function fimel_sklibs:skapi_player/pdata/get {base_path:"storage fimel_skform:runtime temp.pdata",path:"storage.$(key)[$(value)]",output:"storage fimel_skform:runtime temp.a"}
execute store result score fimel.skform.a fcs_lib run data get storage fimel_skform:runtime temp.a

#$execute if score fimel.skform.a fcs_lib matches 0 run data modify $(storage).$(key)[$(value)] set value 1
#$execute if score fimel.skform.a fcs_lib matches 1 run data modify $(storage).$(key)[$(value)] set value 0

$execute if score fimel.skform.a fcs_lib matches 0 run function fimel_sklibs:skapi_player/pdata/modify {base_path:"storage fimel_skform:runtime temp.pdata",path:"storage.$(key)[$(value)]",value:1}
$execute if score fimel.skform.a fcs_lib matches 1 run function fimel_sklibs:skapi_player/pdata/modify {base_path:"storage fimel_skform:runtime temp.pdata",path:"storage.$(key)[$(value)]",value:0}

