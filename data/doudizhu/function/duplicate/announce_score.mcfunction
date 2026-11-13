function doudizhu:duplicate/format_side
data modify storage doudizhu:ui first_side_text set from storage doudizhu:ui side_text
execute as @e[tag=dd.other_lane,limit=1] run function doudizhu:duplicate/format_side
tellraw @a[tag=dd.audience] [{text:"[双桌结算] 甲桌 ",color:"yellow"},{nbt:"first_side_text",storage:"doudizhu:ui",interpret:true},{text:"　乙桌 ",color:"yellow"},{nbt:"side_text",storage:"doudizhu:ui",interpret:true}]
execute if score #pair_points dd_ctx matches 1.. run tellraw @a[tag=dd.audience] [{text:"红队本副得 ",color:"red"},{score:{name:"#pair_points",objective:"dd_ctx"}},{text:" 分。"}]
execute if score #pair_points dd_ctx matches ..-1 run function doudizhu:duplicate/announce_blue
execute if score #pair_points dd_ctx matches 0 run tellraw @a[tag=dd.audience] {text:"本副平局。",color:"yellow"}
function doudizhu:duplicate/totals
