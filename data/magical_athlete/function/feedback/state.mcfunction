$execute if score @s ma_state matches 1 run tellraw @a[tag=ma.audience] [{"text":"[胡闹运动会] 第$(round)/4场 · ","color":"gold"},{"nbt":"data.magical_athlete.p$(turn).name","entity":"@s","interpret":true},{"text":" · 请招募选手：右键桌面角色两次确认，左键取消","color":"yellow"}]
$execute if score @s ma_state matches 2 run tellraw @a[tag=ma.audience] [{"text":"[胡闹运动会] 第$(round)/4场 · ","color":"gold"},{"nbt":"data.magical_athlete.p$(turn).name","entity":"@s","interpret":true},{"text":" · 秘密选择本场阵容：手持角色按Q两次提交，全员完成后揭晓","color":"yellow"}]
$execute if score @s ma_state matches 3 run tellraw @a[tag=ma.audience] [{"text":"[胡闹运动会] 第$(round)/4场 · ","color":"gold"},{"nbt":"data.magical_athlete.p$(turn).name","entity":"@s","interpret":true},{"text":" · 比赛进行中：等待当前选手行动","color":"yellow"}]
$execute if score @s ma_state matches 4 run tellraw @a[tag=ma.audience] [{"text":"[胡闹运动会] 第$(round)/4场 · ","color":"gold"},{"nbt":"data.magical_athlete.p$(turn).name","entity":"@s","interpret":true},{"text":" · 本场结算完成，6秒后进入下一场","color":"yellow"}]
$execute if score @s ma_state matches 5 run tellraw @a[tag=ma.audience] [{"text":"[胡闹运动会] 第$(round)/4场 · ","color":"gold"},{"nbt":"data.magical_athlete.p$(turn).name","entity":"@s","interpret":true},{"text":" · 四场比赛结束，正在公布总分","color":"yellow"}]
execute if score @s ma_state matches 3 run function magical_athlete:feedback/reveal
execute if score @s ma_state matches 4..5 run function magical_athlete:feedback/scores
$execute if score @s ma_state matches 1 as @a[tag=ma.audience,scores={ma_side=$(turn)}] run function magical_athlete:feedback/subtitle {"text":{"text":"轮到你招募：右键选择一名角色","color":"aqua"}}
execute if score @s ma_state matches 2 as @a[tag=ma.audience] run function magical_athlete:feedback/subtitle {"text":{"text":"请选择本场阵容，手持角色按Q两次","color":"aqua"}}
execute if data entity @s data.magical_athlete.pending.options[0] run function magical_athlete:feedback/pending with entity @s data.magical_athlete.pending
execute as @a[tag=ma.audience] run function magical_athlete:hud/build
