# 先锁定结算阶段，防止同一局重复计分。
execute unless score @s dd_state matches 3 run return 0
function doudizhu:game/ensure_match
scoreboard players set @s dd_state 4
scoreboard players set @s dd_timer 100
function doudizhu:player/audience
tellraw @a[tag=dd.audience] [{text:"════ 第 ",color:"gold"},{score:{name:"@s",objective:"dd_round"}},{text:" / "},{score:{name:"@s",objective:"dd_limit"}},{text:" 局结算 ════"}]
scoreboard players operation #lord dd_ctx = @s dd_lord
scoreboard players set #spring dd_ctx 0
scoreboard players set #farmerplays dd_ctx 0
execute as @e[tag=dd.actors] unless score @s dd_seat = #lord dd_ctx run scoreboard players operation #farmerplays dd_ctx += @s dd_plays
execute if score #winner dd_ctx = #lord dd_ctx if score #farmerplays dd_ctx matches 0 run scoreboard players set #spring dd_ctx 1
execute unless score #winner dd_ctx = #lord dd_ctx as @e[tag=dd.actors] if score @s dd_seat = #lord dd_ctx if score @s dd_plays matches 1 run scoreboard players set #spring dd_ctx 1
execute if score #spring dd_ctx matches 1 run scoreboard players operation @s dd_mult += @s dd_mult
scoreboard players operation #unit dd_ctx = @s dd_bid
scoreboard players operation #unit dd_ctx *= @s dd_mult
execute if score #winner dd_ctx = #lord dd_ctx run tellraw @a[tag=dd.audience] {text:"地主获胜！",color:"gold",bold:true}
execute unless score #winner dd_ctx = #lord dd_ctx run tellraw @a[tag=dd.audience] {text:"农民共同获胜！",color:"green",bold:true}
execute if score #spring dd_ctx matches 1 run tellraw @a[tag=dd.audience] {text:"春天／反春天，倍数翻倍。",color:"yellow"}
execute as @e[tag=dd.actors] run function doudizhu:game/score
execute unless score @s dd_audio matches 0 as @a[tag=dd.audience,scores={dd_points=1..}] run function doudizhu:music/start_win
execute unless score @s dd_audio matches 0 as @a[tag=dd.audience,scores={dd_points=..-1}] run function doudizhu:music/start_lose
function doudizhu:log {text:"本局结算完成，累计分数已保存"}
execute as @a[tag=dd.audience] run dialog clear @s
function doudizhu:input/sync
execute if score @s dd_round < @s dd_limit run tellraw @a[tag=dd.audience] {text:"5秒后自动开始下一局。",color:"yellow"}
execute unless score @s dd_round < @s dd_limit run tellraw @a[tag=dd.audience] {text:"全部局数已完成，5秒后公布总分并返回大厅。",color:"yellow"}
tag @a[tag=dd.audience] remove dd.audience
tag @e[tag=dd.actors] remove dd.actors
