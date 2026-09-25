execute if entity @a[tag=wq.actor,scores={wq_guess=1}] run tellraw @a[tag=wq.actor] {text:"[问非所答] 正在收集大家的答案，请等待。",color:"yellow"}
execute if entity @a[tag=wq.actor,scores={wq_guess=1}] run return 0
data modify storage wenfei:ui secret set from entity @s data.wenfei.correct.text
tellraw @a[tag=wq.actor] [{text:"[仅你可见] 本轮秘密问题：",color:"gold"},{nbt:"secret",storage:"wenfei:ui"}]
tellraw @a[tag=wq.actor] {text:"把答案写在书与笔第一页，点击完成后按Q提交，不要签名。只写答案，不抄问题；提交后不能修改。",color:"yellow"}
execute if entity @a[tag=wq.actor,scores={wq_done=1}] run tellraw @a[tag=wq.actor] {text:"你的答案已提交，等待其他玩家。",color:"green"}
