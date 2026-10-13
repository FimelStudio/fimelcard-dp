# 检测是否为列表

execute unless data storage fimel_anim_text:runtime storage.output.data.data.text[0] if score #settings.tip.error fca_store matches 1 run return run function fimel_anim_text:storage/output/fail/analyse

# 复制组件

data modify storage fimel_anim_text:runtime storage.output.data.input set from storage fimel_anim_text:runtime storage.output.data.data.text