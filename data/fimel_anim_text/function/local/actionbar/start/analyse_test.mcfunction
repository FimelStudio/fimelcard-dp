# 检测是否为列表

execute unless data storage fimel_anim_text:runtime local.actionbar.data.text[0] if score #settings.tip.error fca_store matches 1 run return run function fimel_anim_text:local/actionbar/fail/analyse

# 复制组件

data modify storage fimel_anim_text:runtime local.actionbar.input set from storage fimel_anim_text:runtime local.actionbar.data.text