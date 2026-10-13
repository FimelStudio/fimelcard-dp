
$data modify storage fimel_title:io temp_panel set from storage fimel_title:io panels[$(panel_id)]
# 再检查一次面板首项，防止已分配的空面板触发 26.2 的组件解析警告
execute if data storage fimel_title:io temp_panel[0] run title @s actionbar {"nbt":"temp_panel","storage":"fimel_title:io","interpret":true}

