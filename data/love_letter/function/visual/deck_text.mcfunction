$data modify entity @s text set value {text:"",extra:[{text:"剩余 ",color:"gray"},{text:"$(count)",color:"gold"},{text:" 张",color:"gray"}]}
$data modify entity @s data.ll_count set value $(count)
