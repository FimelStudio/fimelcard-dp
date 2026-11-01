data modify storage fimel_title:io text set value {text:"",shadow_color:0,extra:[]}
execute if entity @e[tag=ll.hud_part,scores={ll_hand=0},limit=1] run data modify storage fimel_title:io text.extra append value {"text":"","color":"white"}
execute if entity @e[tag=ll.hud_part,scores={ll_hand=1},limit=1] run data modify storage fimel_title:io text.extra append value {"text":"","color":"white"}
execute if entity @e[tag=ll.hud_part,scores={ll_hand=2},limit=1] run data modify storage fimel_title:io text.extra append value {"text":"","color":"white"}
execute if entity @e[tag=ll.hud_part,scores={ll_hand=3},limit=1] run data modify storage fimel_title:io text.extra append value {"text":"","color":"white"}
execute if entity @e[tag=ll.hud_part,scores={ll_hand=4},limit=1] run data modify storage fimel_title:io text.extra append value {"text":"","color":"white"}
execute if entity @e[tag=ll.hud_part,scores={ll_hand=5},limit=1] run data modify storage fimel_title:io text.extra append value {"text":"","color":"white"}
execute if entity @e[tag=ll.hud_part,scores={ll_hand=6},limit=1] run data modify storage fimel_title:io text.extra append value {"text":"","color":"white"}
execute if entity @e[tag=ll.hud_part,scores={ll_hand=7},limit=1] run data modify storage fimel_title:io text.extra append value {"text":"","color":"white"}
execute if entity @e[tag=ll.hud_part,scores={ll_hand=8},limit=1] run data modify storage fimel_title:io text.extra append value {"text":"","color":"white"}
execute if entity @e[tag=ll.hud_part,scores={ll_hand=9},limit=1] run data modify storage fimel_title:io text.extra append value {"text":"","color":"white"}
execute if entity @e[tag=ll.hud_part,scores={ll_extra=0..9},limit=1] run data modify storage fimel_title:io text.extra append value {"text":""}
execute if entity @e[tag=ll.hud_part,scores={ll_extra=0},limit=1] run data modify storage fimel_title:io text.extra append value {"text":"","color":"white"}
execute if entity @e[tag=ll.hud_part,scores={ll_extra=1},limit=1] run data modify storage fimel_title:io text.extra append value {"text":"","color":"white"}
execute if entity @e[tag=ll.hud_part,scores={ll_extra=2},limit=1] run data modify storage fimel_title:io text.extra append value {"text":"","color":"white"}
execute if entity @e[tag=ll.hud_part,scores={ll_extra=3},limit=1] run data modify storage fimel_title:io text.extra append value {"text":"","color":"white"}
execute if entity @e[tag=ll.hud_part,scores={ll_extra=4},limit=1] run data modify storage fimel_title:io text.extra append value {"text":"","color":"white"}
execute if entity @e[tag=ll.hud_part,scores={ll_extra=5},limit=1] run data modify storage fimel_title:io text.extra append value {"text":"","color":"white"}
execute if entity @e[tag=ll.hud_part,scores={ll_extra=6},limit=1] run data modify storage fimel_title:io text.extra append value {"text":"","color":"white"}
execute if entity @e[tag=ll.hud_part,scores={ll_extra=7},limit=1] run data modify storage fimel_title:io text.extra append value {"text":"","color":"white"}
execute if entity @e[tag=ll.hud_part,scores={ll_extra=8},limit=1] run data modify storage fimel_title:io text.extra append value {"text":"","color":"white"}
execute if entity @e[tag=ll.hud_part,scores={ll_extra=9},limit=1] run data modify storage fimel_title:io text.extra append value {"text":"","color":"white"}
data modify storage fimel_title:io font set value "card:love_letter/hud"
data modify storage fimel_title:io neg_font set value "card:love_letter/hud_neg"
data modify storage fimel_title:io y set value 20.0d
function love_letter:hud/text
