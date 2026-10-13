# 动作栏播放

execute if score #global.actionbar.print fca_store matches 1.. run function fimel_anim_text:global/actionbar/process/tick

# 标题栏播放

execute if score #global.title.print fca_store matches 1.. run function fimel_anim_text:global/title/process/tick

# 副标题栏播放

execute if score #global.subtitle.print fca_store matches 1.. run function fimel_anim_text:global/subtitle/process/tick