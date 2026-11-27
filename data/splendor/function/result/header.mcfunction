$data modify storage splendor:result line set value {text:"",extra:[{text:"$(side)号　",color:"gray"},$(name),{text:" · $(vp)分 · 发展卡$(cards_count)张／贵族$(noble_count)张",color:"yellow"},{text:"$(mark)",color:"gold"}]}
function splendor:result/emit
