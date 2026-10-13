# 移除text translate nbt score keybind selector object extra

data modify storage fimel_anim_text:runtime operation.component.split.template.color set from storage fimel_anim_text:runtime operation.component.split.input.color

data modify storage fimel_anim_text:runtime operation.component.split.template.bold set from storage fimel_anim_text:runtime operation.component.split.input.bold

data modify storage fimel_anim_text:runtime operation.component.split.template.italic set from storage fimel_anim_text:runtime operation.component.split.input.italic

data modify storage fimel_anim_text:runtime operation.component.split.template.underlined set from storage fimel_anim_text:runtime operation.component.split.input.underlined

data modify storage fimel_anim_text:runtime operation.component.split.template.strikethrough set from storage fimel_anim_text:runtime operation.component.split.input.strikethrough

data modify storage fimel_anim_text:runtime operation.component.split.template.obfuscated set from storage fimel_anim_text:runtime operation.component.split.input.obfuscated

data modify storage fimel_anim_text:runtime operation.component.split.template.font set from storage fimel_anim_text:runtime operation.component.split.input.font

data modify storage fimel_anim_text:runtime operation.component.split.template.sound set from storage fimel_anim_text:runtime operation.component.split.input.sound

data modify storage fimel_anim_text:runtime operation.component.split.template.delay set from storage fimel_anim_text:runtime operation.component.split.input.delay

# 复制组件

data modify storage fimel_anim_text:runtime operation.split.template append from storage fimel_anim_text:runtime operation.component.split.template