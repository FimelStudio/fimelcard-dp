# 必需选择在下一刻打开，等待本次丢牌回收或 Dialog after_action 关闭完成。
scoreboard players operation @s ll_seen = @e[tag=ll.current,limit=1] ll_epoch
tag @s add ll.choice_pending
execute if entity @e[tag=ll.current,scores={ll_phase=3},limit=1] run title @s actionbar {text:"侍卫已打出，请在即将打开的窗口中猜测目标手牌。",color:"yellow"}
