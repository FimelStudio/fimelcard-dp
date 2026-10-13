
tellraw @a [{"text":"当前demoS0的值为："},{"nbt":"temp.demoS0","storage":"fimel_sklibs:arrays"}]

#data modify storage fimel_sklibs:arrays temp.demoS3 set value {tag:"c3"}
#function fimel_sklibs:skapi_arrays/equal {a:"storage fimel_sklibs:arrays temp.demoS0",b:"storage fimel_sklibs:arrays temp.demoS3"}
#execute if function fimel_sklibs:skapi_arrays/equal_r run return run function fimel_sklibs:skapi_arrays/continue

# demoS1作为遍历变量
data modify storage fimel_sklibs:arrays temp.demoS1 set value 0

# 使用demoS1遍历demoS2并运行execute2函数
function fimel_sklibs:skapi_arrays/foreach {i:{data:"storage fimel_sklibs:arrays temp.demoS1"},target:{data:"storage fimel_sklibs:arrays demoS2"},execute:{value:"function fimel_sklibs:skapi_arrays/debug/demo1/execute2"}}
