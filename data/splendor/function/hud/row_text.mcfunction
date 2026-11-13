$data modify storage fimel_title:io text set value {"text":"","bold":false,"shadow_color":0,"extra":[{"text":"$(marker)","color":"$(color)"},$(name),{"text":" · $(vp)分 · 贵族$(nobles)","color":"gold"}]}
function splendor:hud/text
scoreboard players remove #hud_y sp_ctx 12
$data modify storage fimel_title:io text set value {"text":"宝石 ","color":"gray","bold":false,"shadow_color":0,"extra":[{"text":"","color":"white"},{"text":"$(t0) ","color":"white"},{"text":"","color":"white"},{"text":"$(t1) ","color":"white"},{"text":"","color":"white"},{"text":"$(t2) ","color":"white"},{"text":"","color":"white"},{"text":"$(t3) ","color":"white"},{"text":"","color":"white"},{"text":"$(t4) ","color":"white"},{"text":"","color":"white"},{"text":"$(t5) ","color":"white"}]}
function splendor:hud/text
scoreboard players remove #hud_y sp_ctx 12
$data modify storage fimel_title:io text set value {"text":"折扣 ","color":"gray","bold":false,"shadow_color":0,"extra":[{"text":"","color":"white"},{"text":"$(b0) ","color":"white"},{"text":"","color":"white"},{"text":"$(b1) ","color":"white"},{"text":"","color":"white"},{"text":"$(b2) ","color":"white"},{"text":"","color":"white"},{"text":"$(b3) ","color":"white"},{"text":"","color":"white"},{"text":"$(b4) ","color":"white"}]}
function splendor:hud/text
scoreboard players remove #hud_y sp_ctx 12
$data modify storage fimel_title:io text set value {text:"发展$(cards)张 · 预定$(reserved)/3",color:"gray",bold:false,shadow_color:0}
function splendor:hud/text
