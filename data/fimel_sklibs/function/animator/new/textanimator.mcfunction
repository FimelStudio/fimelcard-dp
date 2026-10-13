

$data modify storage fimel_sklibs:animator temp.input set value $(config)

data modify storage fimel_sklibs:animator temp.args1.tags set value []
data modify storage fimel_sklibs:animator temp.args1.scale set value 1
data modify storage fimel_sklibs:animator temp.args1.tags set from storage fimel_sklibs:animator temp.input.tags
data modify storage fimel_sklibs:animator temp.args1.scale set from storage fimel_sklibs:animator temp.input.scale
data modify storage fimel_sklibs:animator temp.args1.y set from storage fimel_sklibs:animator temp.input.y

# 生成文本展示实体
execute summon text_display run function fimel_sklibs:animator/new/textanimator/_0 with storage fimel_sklibs:animator temp.args1
