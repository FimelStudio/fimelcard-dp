tag @s add gd.controller
execute if score @s ct_state matches 0 run return run function guandan:game/init_table
function guandan:system/context
function guandan:game/bump_epoch
function guandan:visual/refresh
execute as @a[tag=gd.audience] run function guandan:input/give
function guandan:hud/refresh
# 活跃牌库、选中的贡还牌、计时和发牌进度全部保留。
