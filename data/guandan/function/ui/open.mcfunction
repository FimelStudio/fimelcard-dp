function guandan:input/context
execute unless entity @s[tag=gd.actor] run return 0
function guandan:ui/begin
function guandan:ui/players
function guandan:ui/hand
function guandan:ui/status
execute if entity @e[tag=gd.current,scores={gd_state=3,gd_anim=0},limit=1] if score @s gd_seat = @e[tag=gd.current,limit=1] gd_turn run function guandan:ui/play_buttons
execute if entity @e[tag=gd.current,scores={gd_state=2,gd_anim=0},limit=1] run function guandan:ui/tribute_buttons
function guandan:ui/button {code:22,label:"取消所选",color:"gray"}
function guandan:ui/button {code:2,label:"对局菜单",color:"gray"}
function guandan:hud/update
function guandan:ui/normalize
function guandan:ui/show with storage guandan:ui
