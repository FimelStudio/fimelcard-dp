data modify storage love_letter:ui cards set value {text:"\n\n\n\n\n",shadow_color:0,extra:[]}
data modify storage love_letter:ui info set value {text:"",extra:[]}
data modify storage love_letter:ui phase set value {text:"选择保留的手牌。",color:"green"}
execute if entity @e[tag=ll.current,scores={ll_phase=5},limit=1] run data modify storage love_letter:ui phase set value {text:"选择先放回牌库底的牌。",color:"green"}
function love_letter:ui/buffer_card {index:0}
function love_letter:ui/buffer_card {index:1}
function love_letter:ui/buffer_card {index:2}
