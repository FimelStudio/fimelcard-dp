$data modify storage fimel_title:io text set value {text:"第$(round)轮 · ",color:"gold",bold:false,extra:[{nbt:"data.splendor.p$(turn).name",entity:"@e[tag=sp.current,limit=1]",interpret:true},{text:" 行动 · 右键选择/确认 · 左键取消",color:"yellow"}]}
execute if score @e[tag=sp.current,limit=1] sp_state matches 2 run data modify storage fimel_title:io text set value {text:"宝石超过10颗：右键选退珠、左键撤销，或Q丢出多余宝石",color:"yellow"}
execute if score @e[tag=sp.current,limit=1] sp_state matches 4 run data modify storage fimel_title:io text set value {text:"交易结束 · 查看本局结果",color:"gold"}
function splendor:hud/center
