$data modify storage fimel_title:io text set value {"text":"","bold":false,"extra":[{"nbt":"data.catan.p$(side).name","entity":"@e[tag=ca.current,limit=1]","interpret":true},{"text":" · "},{"nbt":"data.catan.p$(side).public_vp","entity":"@e[tag=ca.current,limit=1]","color":"gold"},{"text":"分"}]}
$function catan:hud/name_color {side:$(side),index:0}
$execute if score @s ca_side matches $(side) run data modify storage fimel_title:io text.extra[2] set value {"nbt":"data.catan.p$(side).vp","entity":"@e[tag=ca.current,limit=1]","color":"gold"}
$execute if score @s ca_side matches $(side) run data modify storage fimel_title:io text.extra[3].text set value "分（本人）"
$execute if entity @e[tag=ca.current,scores={ca_turn=$(side),ca_state=1..8},limit=1] run data modify storage fimel_title:io text.extra insert 1 value {text:" ▶",color:"yellow"}
$function catan:hud/line {x:$(x),y:$(y),origin:"$(origin)",align:"$(align)"}
$data modify storage fimel_title:io text set value {"text":"资源 ","color":"gray","bold":false,"extra":[{"nbt":"data.catan.p$(side).resource_count","entity":"@e[tag=ca.current,limit=1]","color":"white"},{"text":" · 发展 "},{"nbt":"data.catan.p$(side).dev_count","entity":"@e[tag=ca.current,limit=1]","color":"white"}]}
$execute if score @s ca_side matches $(side) run function catan:hud/own_resources {side:$(side)}
$function catan:hud/line {x:$(x),y:$(y2),origin:"$(origin)",align:"$(align)"}
$data modify storage fimel_title:io text set value {"text":"道路 ","color":"gray","bold":false,"extra":[{"nbt":"data.catan.p$(side).road_length","entity":"@e[tag=ca.current,limit=1]","color":"aqua"},{"text":" · 骑士 "},{"nbt":"data.catan.p$(side).knights","entity":"@e[tag=ca.current,limit=1]","color":"aqua"}]}
$execute if score @s ca_side matches $(side) run data modify storage fimel_title:io text.extra append value {"text":" · 发展 ","extra":[{"nbt":"data.catan.p$(side).dev_count","entity":"@e[tag=ca.current,limit=1]","color":"white"}]}
$execute if data entity @e[tag=ca.current,limit=1] data.catan{longest:$(side)} run data modify storage fimel_title:io text.extra append value {"text":" · 最长道路","color":"gold"}
$execute if data entity @e[tag=ca.current,limit=1] data.catan{army:$(side)} run data modify storage fimel_title:io text.extra append value {"text":" · 最大骑士军","color":"gold"}
$function catan:hud/line {x:$(x),y:$(y3),origin:"$(origin)",align:"$(align)"}
