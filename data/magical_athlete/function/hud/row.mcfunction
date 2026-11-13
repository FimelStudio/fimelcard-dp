$data modify storage fimel_title:io text set value {"text":"","bold":false,"extra":[{"nbt":"data.magical_athlete.p$(side).name","entity":"@e[tag=ma.current,limit=1]","interpret":true},{"text":" · "},{"nbt":"data.magical_athlete.p$(side).points","entity":"@e[tag=ma.current,limit=1]","color":"gold"},{"text":"分","color":"gold"}]}
$execute if entity @e[tag=ma.current,scores={ma_turn=$(side)},limit=1] run data modify storage fimel_title:io text.text set value "▶ "
$function magical_athlete:hud/line {x:$(x),y:$(y),origin:"$(origin)",align:"$(align)"}
$data modify storage fimel_title:io text set value {"text":"本场 ","color":"gray","bold":false,"extra":[{"nbt":"data.magical_athlete.p$(side).race_points","entity":"@e[tag=ma.current,limit=1]","color":"aqua"},{"text":"分"}]}
$function magical_athlete:hud/line {x:$(x),y:$(y2),origin:"$(origin)",align:"$(align)"}
data modify storage fimel_title:io text set value {"text":"角色与能力：查看物品栏","color":"gray","bold":false}
$execute if entity @e[tag=ma.current,scores={ma_state=3..5},limit=1] run function magical_athlete:hud/racers {side:$(side)}
$function magical_athlete:hud/line {x:$(x),y:$(y3),origin:"$(origin)",align:"$(align)"}
