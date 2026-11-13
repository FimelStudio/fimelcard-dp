$data modify storage fimel_title:io text set value {text:"璀璨宝石 · 第$(round)轮 · ",color:"gold",extra:[{nbt:"data.splendor.p$(turn).name",entity:"@e[tag=sp.current,limit=1]",interpret:true},{text:" 行动 · 右键拿取/购买 · 紫色染料Q更多操作",color:"yellow"}]}
function splendor:hud/text
