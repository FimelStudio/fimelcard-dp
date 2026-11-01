function love_letter:input/context
execute unless entity @s[tag=ll.actor] run return 0
function love_letter:ui/begin
function love_letter:ui/players
data modify storage love_letter:ui cards set value {text:"\n\n\n\n\n",shadow_color:0,extra:[]}
scoreboard players operation #ui_card ll_ctx = @e[tag=ll.me,limit=1] ll_hand
function love_letter:ui/card {slot:0,offset:10}
scoreboard players operation #ui_card ll_ctx = @e[tag=ll.me,limit=1] ll_extra
function love_letter:ui/card {slot:1,offset:11}
execute if entity @e[tag=ll.me,scores={ll_alive=0},limit=1] run data modify storage love_letter:ui phase set value {text:"本轮已淘汰，下一轮重新参加。",color:"gray"}
execute if entity @e[tag=ll.current,scores={ll_state=1},limit=1] run data modify storage love_letter:ui phase set value {text:"正在发牌。",color:"gray"}
execute if entity @e[tag=ll.current,scores={ll_state=3..4},limit=1] run data modify storage love_letter:ui phase set value {text:"本轮已结束。",color:"gold"}
scoreboard players set #ui_active ll_ctx 0
execute if entity @e[tag=ll.current,scores={ll_state=2,ll_anim=0},limit=1] if entity @e[tag=ll.me,scores={ll_alive=1},limit=1] run function love_letter:ui/active
execute if score #ui_active ll_ctx matches 1 run function love_letter:ui/choices
function love_letter:ui/button {code:3,label:"公开牌与积分",color:"aqua"}
function love_letter:ui/button {code:2,label:"对局菜单",color:"gray"}
function love_letter:ui/normalize
function love_letter:ui/show with storage love_letter:ui
