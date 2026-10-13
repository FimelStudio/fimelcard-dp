

data modify storage fimel_skform:runtime temp.args_sco.form_id set from storage fimel_skform:runtime temp.form_id
data modify storage fimel_skform:runtime temp.args_sco.key set from storage fimel_skform:runtime temp.j.key

function fimel_skform:tick/_reset/_scoreboard/_1 with storage fimel_skform:runtime temp.args_sco
