function doudizhu:player/audience
scoreboard players operation #lord dd_ctx = @s dd_lord
scoreboard players set #spring dd_ctx 0
scoreboard players set #farmerplays dd_ctx 0
execute as @a[tag=dd.audience] unless score @s dd_seat = #lord dd_ctx run scoreboard players operation #farmerplays dd_ctx += @s dd_plays
execute if score #winner dd_ctx = #lord dd_ctx if score #farmerplays dd_ctx matches 0 run scoreboard players set #spring dd_ctx 1
execute unless score #winner dd_ctx = #lord dd_ctx as @a[tag=dd.audience] if score @s dd_seat = #lord dd_ctx if score @s dd_plays matches 1 run scoreboard players set #spring dd_ctx 1
execute if score #spring dd_ctx matches 1 run scoreboard players operation @s dd_mult += @s dd_mult
scoreboard players operation #unit dd_ctx = @s dd_bid
scoreboard players operation #unit dd_ctx *= @s dd_mult
execute if score #winner dd_ctx = #lord dd_ctx run tellraw @a[tag=dd.audience] {text:"地主获胜！",color:"gold",bold:true}
execute unless score #winner dd_ctx = #lord dd_ctx run tellraw @a[tag=dd.audience] {text:"农民共同获胜！",color:"green",bold:true}
execute if score #spring dd_ctx matches 1 run tellraw @a[tag=dd.audience] {text:"春天／反春天，倍数翻倍。",color:"yellow"}
execute as @a[tag=dd.audience] run function doudizhu:game/score
function doudizhu:log {text:"本局结算完成，返回大厅"}
function doudizhu:game/abort
