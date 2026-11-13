execute unless score @s ll_hint_target = #aim ll_ctx run scoreboard players set @s ll_hint 0
scoreboard players operation @s ll_hint_target = #aim ll_ctx
execute if score @s ll_hintwait matches 1.. run return 0
execute if score @s ll_hint matches 1.. run scoreboard players remove @s ll_hint 1
execute if score @s ll_hint matches 1.. run return 0
scoreboard players set @s ll_hint 5
tag @a[tag=ll.hint_target] remove ll.hint_target
execute as @a[tag=ll.audience] if score @s ll_seat = #aim ll_ctx run tag @s add ll.hint_target
execute if score #aim ll_ctx matches 1..8 unless score #unavailable ll_ctx matches 1 run title @s actionbar [{text:"已选中：",color:"yellow"},{selector:"@a[tag=ll.hint_target,limit=1]",color:"green"},{text:" · Q 确认",color:"gray"}]
execute if score #aim ll_ctx matches 1..8 if score #unavailable ll_ctx matches 1 run title @s actionbar [{text:"目标：",color:"yellow"},{selector:"@a[tag=ll.hint_target,limit=1]",color:"white"},{text:" · 不可选：已出局、受保护或不能对自己使用",color:"red"}]
execute if score #aim ll_ctx matches 0 run title @s actionbar {text:"未选中玩家 · 朝向目标选中（保留3秒），低头清除",color:"yellow"}
tag @a[tag=ll.hint_target] remove ll.hint_target
