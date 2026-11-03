tag @s add ma.controller
function magical_athlete:settings/defaults
execute if score @s ct_state matches 0 run return run function magical_athlete:game/preview
function magical_athlete:system/context
execute unless data entity @s data.magical_athlete.version run return run function magical_athlete:game/abort
# 丢弃未播放的表现，规则已提交的角色、骰值、得分及待选技能不变。
scoreboard players set @s ma_anim 0
data remove entity @s data.magical_athlete.visual_queue
function magical_athlete:game/sync
function magical_athlete:visual/refresh
function magical_athlete:sound/reload
execute as @a[tag=ma.audience] run function magical_athlete:input/give
