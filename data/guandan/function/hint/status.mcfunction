data modify storage guandan:ui phase set value {text:"提示：",color:"green",extra:[{text:""}]}
data modify storage guandan:ui phase.extra[0].text set from entity @e[tag=gd.current,limit=1] data.guandan.hint_label
