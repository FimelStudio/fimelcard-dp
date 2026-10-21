execute if score @s dd_bid matches 0 run return run function doudizhu:bid/finish
function doudizhu:player/audience
scoreboard players set @s dd_bidphase 1
scoreboard players set @s dd_bidleft 0
execute as @e[tag=dd.actors,scores={dd_eligible=1}] run scoreboard players add @e[tag=dd.current,limit=1] dd_bidleft 1
scoreboard players operation @s dd_turn = @s dd_firstcall
execute if score @s dd_bidleft matches 1 run return run function doudizhu:bid/rob_auto_finish
tellraw @a[tag=dd.audience] {text:"第二轮抢地主开始：从最早叫地主的人开始，跳过第一轮不叫的人。选择抢立即定地主；最后一人自动成为地主。",color:"gold"}
function doudizhu:round/announce
