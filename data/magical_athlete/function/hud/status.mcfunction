data modify storage fimel_title:io text set value {"text":"等待其他玩家行动","color":"yellow","bold":false}
execute if entity @e[tag=ma.current,scores={ma_state=1},limit=1] run data modify storage fimel_title:io text set value {"text":"招募：右键角色选择／确认，左键取消","color":"yellow","bold":false}
execute if entity @e[tag=ma.current,scores={ma_state=2},limit=1] run data modify storage fimel_title:io text set value {"text":"秘密出场：角色按Q选中，再按Q确认","color":"yellow","bold":false}
execute if entity @e[tag=ma.current,scores={ma_state=3},limit=1] run data modify storage fimel_title:io text set value {"text":"行动：骰子按Q；技能选项按Q或右键目标","color":"yellow","bold":false}
execute if entity @e[tag=ma.current,scores={ma_state=4},limit=1] run data modify storage fimel_title:io text set value {"text":"本场已结算，即将进入下一场","color":"yellow","bold":false}
execute if entity @e[tag=ma.current,scores={ma_state=5},limit=1] run data modify storage fimel_title:io text set value {"text":"四场比赛结束","color":"yellow","bold":false}
function magical_athlete:hud/status_turn with entity @e[tag=ma.current,limit=1] data.magical_athlete
execute if entity @e[tag=ma.current,scores={ma_pending=1},limit=1] run data modify storage fimel_title:io text.extra append value {"text":" · 待回应：","color":"aqua","extra":[{"nbt":"data.magical_athlete.p1.name","entity":"@e[tag=ma.current,limit=1]","interpret":true}]}
execute if entity @e[tag=ma.current,scores={ma_pending=2},limit=1] run data modify storage fimel_title:io text.extra append value {"text":" · 待回应：","color":"aqua","extra":[{"nbt":"data.magical_athlete.p2.name","entity":"@e[tag=ma.current,limit=1]","interpret":true}]}
execute if entity @e[tag=ma.current,scores={ma_pending=3},limit=1] run data modify storage fimel_title:io text.extra append value {"text":" · 待回应：","color":"aqua","extra":[{"nbt":"data.magical_athlete.p3.name","entity":"@e[tag=ma.current,limit=1]","interpret":true}]}
execute if entity @e[tag=ma.current,scores={ma_pending=4},limit=1] run data modify storage fimel_title:io text.extra append value {"text":" · 待回应：","color":"aqua","extra":[{"nbt":"data.magical_athlete.p4.name","entity":"@e[tag=ma.current,limit=1]","interpret":true}]}
execute if entity @e[tag=ma.current,scores={ma_pending=5},limit=1] run data modify storage fimel_title:io text.extra append value {"text":" · 待回应：","color":"aqua","extra":[{"nbt":"data.magical_athlete.p5.name","entity":"@e[tag=ma.current,limit=1]","interpret":true}]}
execute if entity @e[tag=ma.current,scores={ma_pending=6},limit=1] run data modify storage fimel_title:io text.extra append value {"text":" · 待回应：","color":"aqua","extra":[{"nbt":"data.magical_athlete.p6.name","entity":"@e[tag=ma.current,limit=1]","interpret":true}]}
function magical_athlete:hud/center
