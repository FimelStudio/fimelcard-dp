
# say reset0

function fimel_sklibs:skapi_player/pdata/get {base_path:"storage fimel_skform:runtime temp.pdata",path:"form_id.v",output:"storage fimel_skform:runtime temp.pform_id.v"}

scoreboard players set fimel.skform.count fcs_lib 0
execute as @a[tag=fimel.skform.had] run function fimel_skform:tick/_reset/_1
execute if score fimel.skform.count fcs_lib matches 0 run function fimel_skform:tick/_reset/_2 with storage fimel_skform:runtime temp.pform_id

tag @s remove fimel.skform.test

