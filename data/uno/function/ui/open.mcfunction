# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function uno:input/context
execute unless entity @s[tag=un.actor] run return 0
execute if score @e[tag=un.current,limit=1] un_state matches 3..4 run return run function uno:ui/response_open
execute unless score @e[tag=un.current,limit=1] un_state matches 2 run return run function uno:ui/close
execute unless score @s un_seat = @e[tag=un.current,limit=1] un_turn run return run function uno:ui/close
scoreboard players set @s un_colorpick -1
scoreboard players operation @s un_seen = @e[tag=un.current,limit=1] un_epoch
scoreboard players operation #ui_base un_ctx = @s un_seen
scoreboard players set #ui_1000 un_ctx 1000
scoreboard players operation #ui_base un_ctx *= #ui_1000 un_ctx
scoreboard players operation #ui_seat un_ctx = @s un_seat
execute store result storage uno:ui table int 1 run scoreboard players get @s un_table
tag @e[tag=un.uihand] remove un.uihand
execute as @e[type=minecraft:marker,tag=un.card] if score @s ct_id = #ui_table un_ctx if score @s un_owner = #ui_seat un_ctx run tag @s add un.uihand
# 牌面向基线上方延伸50px，六个空行给首行留足空间。
data modify storage uno:ui grid set value {text:"\n\n\n\n\n\n",shadow_color:0,extra:[]}
data modify storage uno:ui selected set value {text:"未选择",color:"gray"}
scoreboard players set #ui_col un_ctx 0
function uno:ui/build
# 最后一行最多向基线下方延伸34px，补四行以免遮住底部操作按钮。
data modify storage uno:ui grid.extra append value {text:"\n\n\n\n"}
tag @e[tag=un.uihand] remove un.uihand
function uno:ui/status
function uno:ui/controls
scoreboard players operation #ui_code un_ctx = #ui_base un_ctx
scoreboard players add #ui_code un_ctx 10
execute store result storage uno:ui close int 1 run scoreboard players get #ui_code un_ctx
function uno:ui/show with storage uno:ui
scoreboard players set @s un_action 0
scoreboard players enable @s un_action
function uno:hud/update
tag @a[tag=un.actor] remove un.actor
