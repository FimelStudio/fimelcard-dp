scoreboard players operation #bid sk_ctx = #choice sk_ctx
scoreboard players remove #bid sk_ctx 10
execute unless score #bid sk_ctx > @s sk_bid run return 0
execute if score #bid sk_ctx > @s sk_total run return 0
execute if score #bid sk_ctx < @a[tag=sk.actor,limit=1] sk_count run return 0
execute unless entity @a[tag=sk.actor,scores={sk_pass=0}] run return 0
scoreboard players operation @s sk_bid = #bid sk_ctx
scoreboard players operation @s sk_lead = #actor_seat sk_ctx
scoreboard players set @s sk_state 3
dialog clear @a[tag=sk.actor,limit=1]
function skull:player/audience
tellraw @a[tag=sk.audience] [{text:"[骷髅牌] ",color:"gold"},{selector:"@a[tag=sk.actor,limit=1]"},{text:" 叫号：",color:"yellow"},{score:{name:"@s",objective:"sk_bid"}},{text:" 张花。"}]
function skull:log {text:"有效叫号：进入或继续竞标"}
execute if score @s sk_bid = @s sk_total run return run function skull:challenge/start
function skull:round/next_turn
