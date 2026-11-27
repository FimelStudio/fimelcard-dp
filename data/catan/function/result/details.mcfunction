$data modify storage catan:result line set value {text:"发展卡：骑士$(d0)／修路$(d1)／丰收$(d2)／垄断$(d3)／胜利点$(d4)",color:"aqua"}
function catan:result/emit
$data modify storage catan:result line set value {text:"道路$(roads) · 当前最长$(road_length)（奖分$(longest_points)） · 已用骑士$(knights)（军团奖分$(army_points)）",color:"gray"}
function catan:result/emit
$data modify storage catan:result line set value {text:"村庄$(settlements)／城市$(cities) · 公开$(public_vp)分＋隐藏胜利点$(hidden)分 · 剩余资源$(resource_count)张",color:"gray"}
function catan:result/emit
$data modify storage catan:result line set value {text:"",extra:[{text:"$(side)号　",color:"gray"},$(name),{text:" · $(vp)分",color:"yellow"},{text:"$(mark)",color:"gold"}]}
function catan:result/emit
