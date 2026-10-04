execute if entity @a[tag=wq.actor,scores={wq_guess=1}] run tellraw @a[tag=wq.actor] {text:"[问非所答] 正在收集大家的答案，请等待。",color:"yellow"}
execute if entity @a[tag=wq.actor,scores={wq_guess=1}] run return 0
data modify storage wenfei:ui secret set from entity @s data.wenfei.correct.text
tellraw @a[tag=wq.actor] [{text:"[仅你可见] 本轮秘密问题：",color:"gold"},{nbt:"secret",storage:"wenfei:ui"}]
execute unless score @s wq_input matches 1 run tellraw @a[tag=wq.actor] {text:"把答案写在书与笔第一页，点击完成后按Q提交，不要签名。只写答案，不抄问题；提交后不能修改。",color:"yellow"}
execute if entity @a[tag=wq.actor,scores={wq_done=1}] run tellraw @a[tag=wq.actor] {text:"你的答案已提交，等待其他玩家。",color:"green"}
execute if score @s wq_input matches 1 if entity @a[tag=wq.actor,scores={wq_done=0}] run tellraw @a[tag=wq.actor] {text:"按Q丢出紫色染料打开秘密回答对话框；最多64个字符，提交需要OP，关闭不保存草稿。",color:"yellow"}
execute if score @s wq_input matches 1 as @a[tag=wq.actor,scores={wq_done=0}] unless items entity @s hotbar.* minecraft:purple_dye[minecraft:custom_data~{wenfei:{tool:"answer_dialog"}}] unless items entity @s inventory.* minecraft:purple_dye[minecraft:custom_data~{wenfei:{tool:"answer_dialog"}}] unless items entity @s weapon.offhand minecraft:purple_dye[minecraft:custom_data~{wenfei:{tool:"answer_dialog"}}] run function wenfei:form/give_tool
