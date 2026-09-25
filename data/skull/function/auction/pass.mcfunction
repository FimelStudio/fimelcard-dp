execute if score @s sk_lead = #actor_seat sk_ctx run return 0
scoreboard players set @a[tag=sk.actor,limit=1] sk_pass 1
dialog clear @a[tag=sk.actor,limit=1]
function skull:player/audience
tellraw @a[tag=sk.audience] [{selector:"@a[tag=sk.actor,limit=1]"},{text:" 放弃本轮竞标，已扣的牌仍参与挑战。",color:"gray"}]
scoreboard players set #bidders sk_ctx 0
execute as @a[tag=sk.audience,scores={sk_pass=0}] run scoreboard players add #bidders sk_ctx 1
execute if score #bidders sk_ctx matches 1 run return run function skull:challenge/start
function skull:round/next_turn
