$data modify storage fimel_title:io text set value [{text:"    ",bold:false},{selector:"@a[tag=wq.player,scores={wq_id=$(table),wq_seat=$(seat)}]",color:"aqua",bold:false},{text:":",color:"aqua"}]
$data modify storage fimel_title:io text append from storage wenfei:panel rows[$(first)]
$data modify storage fimel_title:io y set value $(y)
data modify storage fimel_title:io x set value 24.0d
function fimel_title:new_text
data modify storage fimel_title:io text set value [{text:"    ",bold:false}]
$data modify storage fimel_title:io text append from storage wenfei:panel rows[$(second)]
data modify storage fimel_title:io dy set value -14.0d
data modify storage fimel_title:io x set value 24.0d
function fimel_title:new_text
