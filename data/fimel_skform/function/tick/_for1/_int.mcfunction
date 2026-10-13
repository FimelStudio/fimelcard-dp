
# say intcheck

execute if data storage fimel_skform:runtime temp.scoreboards[0].max run function fimel_skform:tick/_for1/_int/_max_0 with storage fimel_skform:runtime temp.args_tri
execute if data storage fimel_skform:runtime temp.scoreboards[0].min run function fimel_skform:tick/_for1/_int/_min_0 with storage fimel_skform:runtime temp.args_tri

function fimel_skform:tick/_for1/_int/_1 with storage fimel_skform:runtime temp.args_tri

