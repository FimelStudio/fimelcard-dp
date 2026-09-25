function skull:player/audience
scoreboard players operation #turn sk_ctx = @s sk_turn
scoreboard players operation #lead sk_ctx = @s sk_lead
execute if score @s sk_state matches 1 run tellraw @a[tag=sk.audience,scores={sk_done=0}] {text:"[骷髅牌] 选中手牌按Q，秘密扣下第一张。",color:"yellow"}
execute if score @s sk_state matches 2 as @a[tag=sk.audience] if score @s sk_seat = #turn sk_ctx run function skull:hand/sync
execute if score @s sk_state matches 2 as @a[tag=sk.audience] if score @s sk_seat = #turn sk_ctx run tellraw @s {text:"[骷髅牌] 轮到你：选中手牌按Q继续扣牌；或按Q丢出紫色染料，打开叫号对话框。无手牌时必须叫号。",color:"yellow"}
execute if score @s sk_state matches 3 as @a[tag=sk.audience] if score @s sk_seat = #turn sk_ctx run function skull:ui/open
execute if score @s sk_state matches 4..5 as @a[tag=sk.audience] if score @s sk_seat = #lead sk_ctx run function skull:ui/open
