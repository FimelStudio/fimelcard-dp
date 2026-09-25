scoreboard players set @s sk_state 6
scoreboard players set @s sk_timer 40
function skull:round/epoch
function skull:player/audience
dialog clear @a[tag=sk.audience]
function skull:hud/update
execute if entity @a[tag=sk.audience,scores={sk_wins=2..}] run return run function skull:game/finish
execute if score @s sk_players matches 1 run return run function skull:game/finish
tellraw @a[tag=sk.audience] {text:"[骷髅牌] 本轮结束，2秒后收回剩余卡牌并开始下一轮。",color:"gold"}
