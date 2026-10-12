scoreboard players operation @s dd_points = #unit dd_ctx
execute if score #winner dd_ctx = #lord dd_ctx unless score @s dd_seat = #lord dd_ctx run scoreboard players operation @s dd_points -= #unit dd_ctx
execute if score #winner dd_ctx = #lord dd_ctx unless score @s dd_seat = #lord dd_ctx run scoreboard players operation @s dd_points -= #unit dd_ctx
execute unless score #winner dd_ctx = #lord dd_ctx if score @s dd_seat = #lord dd_ctx run scoreboard players operation @s dd_points -= #unit dd_ctx
execute unless score #winner dd_ctx = #lord dd_ctx if score @s dd_seat = #lord dd_ctx run scoreboard players operation @s dd_points -= #unit dd_ctx
execute if score @s dd_seat = #lord dd_ctx run scoreboard players operation @s dd_points += @s dd_points
scoreboard players add @s dd_total 0
scoreboard players operation @s dd_total += @s dd_points
tellraw @a[tag=dd.audience] [{selector:"@s",color:"yellow"},{text:" 本局得分：",color:"gray"},{score:{name:"@s",objective:"dd_points"},color:"gold"},{text:"　累计：",color:"gray"},{score:{name:"@s",objective:"dd_total"},color:"aqua"}]
