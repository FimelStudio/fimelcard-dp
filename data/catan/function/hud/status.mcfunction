data modify storage fimel_title:io text set value {"text":"等待其他玩家行动","color":"yellow","bold":false}
execute if entity @e[tag=ca.current,scores={ca_state=1},limit=1] run data modify storage fimel_title:io text set value {"text":"初始村庄：手持村庄瞄准交点，右键或Q两次确认","color":"yellow","bold":false}
execute if entity @e[tag=ca.current,scores={ca_state=2},limit=1] run data modify storage fimel_title:io text set value {"text":"初始道路：手持道路瞄准相邻边，右键或Q两次确认","color":"yellow","bold":false}
execute if entity @e[tag=ca.current,scores={ca_state=3},limit=1] run data modify storage fimel_title:io text set value {"text":"投骰前：骰子按Q，或使用旧发展卡","color":"yellow","bold":false}
execute if entity @e[tag=ca.current,scores={ca_state=4},limit=1] run data modify storage fimel_title:io text set value {"text":"行动：建造／交易／发展卡；结束回合按Q两次","color":"yellow","bold":false}
execute if entity @e[tag=ca.current,scores={ca_state=5},limit=1] run data modify storage fimel_title:io text set value {"text":"弃牌：资源按Q加入，撤销物品按Q退回，选满自动提交","color":"yellow","bold":false}
execute if entity @e[tag=ca.current,scores={ca_state=6},limit=1] run data modify storage fimel_title:io text set value {"text":"强盗：瞄准新地块，右键或Q两次确认","color":"yellow","bold":false}
execute if entity @e[tag=ca.current,scores={ca_state=7},limit=1] run data modify storage fimel_title:io text set value {"text":"偷取：选择相邻对手","color":"yellow","bold":false}
execute if entity @e[tag=ca.current,scores={ca_state=8},limit=1] run data modify storage fimel_title:io text set value {"text":"免费修路：选择道路位置，或按Q放弃","color":"yellow","bold":false}
execute if entity @e[tag=ca.current,scores={ca_state=11},limit=1] run data modify storage fimel_title:io text set value {"text":"本局已结束","color":"yellow","bold":false}
function catan:hud/status_turn with entity @e[tag=ca.current,limit=1] data.catan
function catan:hud/center
