scoreboard players set @s dd_points 0
execute if score #winner dd_ctx = #lord dd_ctx if score @s dd_seat = #lord dd_ctx run scoreboard players set @s dd_points 1
execute unless score #winner dd_ctx = #lord dd_ctx unless score @s dd_seat = #lord dd_ctx run scoreboard players set @s dd_points 1
scoreboard players operation @s dd_total += @s dd_points
tellraw @a[tag=dd.audience] [{selector:"@s",color:"yellow"},{text:" 本副得分 ",color:"gray"},{score:{name:"@s",objective:"dd_points"},color:"gold"},{text:"，累计 "},{score:{name:"@s",objective:"dd_total"},color:"aqua"}]
