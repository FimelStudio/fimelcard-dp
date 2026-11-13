# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function guandan:input/context
execute unless entity @s[tag=gd.actor] run return 0
function guandan:ui/begin
function guandan:ui/players
function guandan:ui/hand
function guandan:ui/status
execute if entity @e[tag=gd.current,scores={gd_state=3,gd_hint=1..},limit=1] if score @s gd_seat = @e[tag=gd.current,limit=1] gd_turn run function guandan:hint/status
function guandan:ui/last_play
execute if entity @e[tag=gd.current,scores={gd_state=3,gd_anim=0},limit=1] if score @s gd_seat = @e[tag=gd.current,limit=1] gd_turn run function guandan:ui/play_buttons
execute if entity @e[tag=gd.current,scores={gd_state=2,gd_anim=0},limit=1] run function guandan:ui/tribute_buttons
function guandan:ui/button {code:22,label:"取消所选",color:"gray"}
function guandan:hud/update
function guandan:ui/normalize
function guandan:ui/hand_show with storage guandan:ui
