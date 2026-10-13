

scoreboard players reset @s fcs_form_submit

function fimel_sklibs:skapi_player/pdata/get {base_path:"storage fimel_skform:runtime temp.pdata",path:"func.v",output:"storage fimel_skform:runtime temp.args_submit.func"}
function fimel_sklibs:skapi_player/pdata/get {base_path:"storage fimel_skform:runtime temp.pdata",path:"storage",output:"storage fimel_skform:runtime temp.args_submit.storage"}

function fimel_skform:tick/_submit/_1 with storage fimel_skform:runtime temp.args_submit


function fimel_skform:end_form
