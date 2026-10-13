

# say 修改了值

# 存储 数据和键值
data modify storage fimel_skform:runtime temp.args_tri.key set from storage fimel_skform:runtime temp.scoreboards[0].key
data modify storage fimel_skform:runtime temp.args_tri.type set from storage fimel_skform:runtime temp.scoreboards[0].type
data modify storage fimel_skform:runtime temp.args_tri.form_id set from storage fimel_skform:runtime temp.scoreboards[0].form_id
$execute store result storage fimel_skform:runtime temp.args_tri.value int 1 run scoreboard players get @s $(scoreboard)
#function fimel_sklibs:skapi_player/pdata/get {base_path:"storage fimel_skform:runtime temp.pdata",path:"storage.v",output:"storage fimel_skform:runtime temp.args_tri.storage"}
function fimel_sklibs:skapi_player/pdata/get {base_path:"storage fimel_skform:runtime temp.pdata",path:"func.v",output:"storage fimel_skform:runtime temp.args_tri.func"}

# 按类型处理
# function #bs.dump:var {var:{_:"storage fimel_skform:runtime temp.args_tri 10"}}
execute if data storage fimel_skform:runtime temp.args_tri{type:"int"} run function fimel_skform:tick/_for1/_int
    # radio color也可以用int来处理
execute if data storage fimel_skform:runtime temp.args_tri{type:"radio"} run function fimel_skform:tick/_for1/_int
execute if data storage fimel_skform:runtime temp.args_tri{type:"color"} run function fimel_skform:tick/_for1/_int

execute if data storage fimel_skform:runtime temp.args_tri{type:"checkbox"} run function fimel_skform:tick/_for1/_checkbox with storage fimel_skform:runtime temp.args_tri

# 重置玩家计分板
$scoreboard players reset @s $(scoreboard)

# 重新给玩家显示表单
function fimel_skform:tick/_for1/_2 with storage fimel_skform:runtime temp.args_tri
