$execute unless data entity @s data.skull.seats.s$(seat).hand[{slot:$(slot)}] run return 0
scoreboard players set #played sk_ctx 1
$data modify entity @s data.skull.seats.s$(seat).stack append from entity @s data.skull.seats.s$(seat).hand[{slot:$(slot)}]
$data remove entity @s data.skull.seats.s$(seat).hand[{slot:$(slot)}]
scoreboard players add @a[tag=sk.actor,limit=1] sk_count 1
scoreboard players set @a[tag=sk.actor,limit=1] sk_done 1
scoreboard players add @s sk_total 1
dialog clear @a[tag=sk.actor,limit=1]
execute as @a[tag=sk.actor,limit=1] run function skull:hand/sync
function skull:player/audience
tellraw @a[tag=sk.audience] [{text:"[骷髅牌] ",color:"gold"},{selector:"@a[tag=sk.actor,limit=1]"},{text:" 扣下一张牌。",color:"gray"}]
function skull:hud/update
function skull:log {text:"玩家完成秘密扣牌，已更新中央出牌数量"}
execute if score @s sk_state matches 1 run return run function skull:round/check_initial
function skull:round/next_turn
