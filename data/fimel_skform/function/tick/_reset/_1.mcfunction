
function fimel_sklibs:skapi_player/pdata/get {base_path:"storage fimel_skform:runtime temp.pdata",path:"form_id.v",output:"storage fimel_skform:runtime temp.form_id"}

execute store success score fimel.skform.check fcs_lib run data modify storage fimel_skform:runtime temp.form_id set from storage fimel_skform:runtime temp.pform_id.v

execute if score fimel.skform.check fcs_lib matches 0 run scoreboard players add fimel.skform.count fcs_lib 1
