$data modify storage title:io text set value [{text:"    ",bold:false},{selector:"@a[tag=wq.player,scores={wq_id=$(table),wq_seat=$(seat)}]",color:"aqua",bold:false},{text:":",color:"aqua"}]
$data modify storage title:io text append from storage wenfei:panel rows[$(first)]
$data modify storage title:io y set value $(y)
data modify storage title:io x set value 24.0d
function title:new_text
data modify storage title:io text set value [{text:"    ",bold:false}]
$data modify storage title:io text append from storage wenfei:panel rows[$(second)]
data modify storage title:io dy set value -14.0d
data modify storage title:io x set value 24.0d
function title:new_text
