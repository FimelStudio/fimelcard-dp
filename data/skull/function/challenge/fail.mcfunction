tellraw @a[tag=sk.audience] {text:"[骷髅牌] 翻到骷髅，挑战失败！挑战者将秘密永久弃掉一张牌。",color:"red"}
function skull:log {text:"挑战失败，进入秘密弃牌"}
scoreboard players set @s sk_state 5
function skull:round/epoch
execute if score @s sk_source = @s sk_lead run return run function skull:ui/refresh
execute store result storage skull:io discard.seat int 1 run scoreboard players get @s sk_lead
function skull:discard/random with storage skull:io discard
