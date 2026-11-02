# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation #base wq_ctx = @s wq_epoch
scoreboard players operation #base wq_ctx *= #hundred wq_ctx
execute if score @s wq_state matches 1 if entity @a[tag=wq.actor,scores={wq_guess=1}] run function wenfei:ui/category
execute if score @s wq_state matches 1 if entity @a[tag=wq.actor,scores={wq_guess=0}] run tellraw @a[tag=wq.actor] {text:"[问非所答] 等待猜题者选择类别。",color:"yellow"}
execute if score @s wq_state matches 2 run function wenfei:ui/answer
execute if score @s wq_state matches 3 if entity @a[tag=wq.actor,scores={wq_guess=1}] run function wenfei:ui/rating
execute if score @s wq_state matches 3 if entity @a[tag=wq.actor,scores={wq_guess=0}] run tellraw @a[tag=wq.actor] {text:"[问非所答] 等待猜题者评分，请勿透露秘密问题。",color:"yellow"}
