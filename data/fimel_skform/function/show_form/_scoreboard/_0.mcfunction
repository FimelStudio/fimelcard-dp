

data modify storage fimel_skform:runtime temp.args_sco.form_id set from storage fimel_skform:runtime temp.form_id
data modify storage fimel_skform:runtime temp.args_sco.key set from storage fimel_skform:runtime temp.i.key

function fimel_skform:show_form/_scoreboard/_1 with storage fimel_skform:runtime temp.args_sco
