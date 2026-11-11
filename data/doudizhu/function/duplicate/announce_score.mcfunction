tellraw @a[tag=dd.audience] [{text:"[双桌结算] 红方净分　甲桌 ",color:"yellow"},{score:{name:"@s",objective:"dd_side_score"}},{text:"　乙桌 "},{score:{name:"@e[tag=dd.other_lane,limit=1]",objective:"dd_side_score"}},{text:"　分差 "},{score:{name:"#difference",objective:"dd_ctx"}}]
execute if score #pair_points dd_ctx matches 1.. run tellraw @a[tag=dd.audience] [{text:"红队本副得 ",color:"red"},{score:{name:"#pair_points",objective:"dd_ctx"}},{text:" 分。"}]
execute if score #pair_points dd_ctx matches ..-1 run function doudizhu:duplicate/announce_blue
execute if score #pair_points dd_ctx matches 0 run tellraw @a[tag=dd.audience] {text:"本副平局。",color:"yellow"}
function doudizhu:duplicate/totals
