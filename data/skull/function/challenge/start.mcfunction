scoreboard players set @s sk_state 4
scoreboard players set @s sk_flipped 0
scoreboard players set @s sk_timer 10
function skull:round/epoch
function skull:player/audience
dialog clear @a[tag=sk.audience]
scoreboard players operation #lead sk_ctx = @s sk_lead
execute as @a[tag=sk.audience] if score @s sk_seat = #lead sk_ctx run tellraw @a[tag=sk.audience] [{text:"[骷髅牌] 挑战者：",color:"gold"},{selector:"@s"},{text:"。先自动翻自己的牌，再选择其他牌堆。"}]
function skull:log {text:"竞标结束：挑战开始"}
