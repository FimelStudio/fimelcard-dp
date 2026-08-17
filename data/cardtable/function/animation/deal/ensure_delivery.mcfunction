# 碰撞或玩家移动导致牌未及时拾取时，把牌贴到对应玩家身边作为可靠性补偿
execute if entity @s[tag=ct.visual_only] run return run kill @s

scoreboard players operation #ctx_id ct_ctx = @s ct_id
scoreboard players operation #deal_seat ct_ctx = @s ct_seat
tag @a[tag=ct.deal_receiver] remove ct.deal_receiver
execute as @a[tag=ct.player] if score @s ct_id = #ctx_id ct_ctx if score @s ct_seat = #deal_seat ct_ctx run tag @s add ct.deal_receiver
execute unless entity @a[tag=ct.deal_receiver,limit=1] run kill @s
execute unless entity @a[tag=ct.deal_receiver,limit=1] run return fail

data modify entity @s Owner set from entity @a[tag=ct.deal_receiver,limit=1] UUID
data merge entity @s {PickupDelay:0s,Motion:[0.0d,0.0d,0.0d]}
tp @s @a[tag=ct.deal_receiver,limit=1]
tag @s remove ct.dealt_card
tag @a[tag=ct.deal_receiver] remove ct.deal_receiver
