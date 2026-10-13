
# demo1
# 多层遍历

tellraw @s "\u00a7e > Demo1"

# demoS0作为遍历变量
data modify storage fimel_sklibs:arrays temp.demoS0 set value 0

# demoS2作为被遍历的列表，使用range函数赋初值[1,2,3,4,5]
# function fimel_sklibs:skapi_arrays/range {start:1,stop:6,step:1,output:"skapi.arrays demoS2"}

# demoS2作为被遍历的列表,列表内容也可以是别的类型
data modify storage fimel_sklibs:arrays temp.demoS2 set value [{tag:"c1"},{tag:"c2"},{tag:"c3"},{tag:"c4"}]

# 使用demoS0遍历demoS2并运行execute1函数
function fimel_sklibs:skapi_arrays/foreach {i:{data:"storage fimel_sklibs:arrays temp.demoS0"},target:{data:"storage fimel_sklibs:arrays temp.demoS2"},execute:{value:"function fimel_sklibs:skapi_arrays/debug/demo1/execute1"}}