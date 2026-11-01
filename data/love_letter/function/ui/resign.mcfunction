function love_letter:ui/begin
data modify storage love_letter:ui title set value "情书 · 本轮认输"
data modify storage love_letter:ui phase set value {text:"确认退出本轮？下轮仍可继续。",color:"yellow"}
function love_letter:ui/button {code:6,label:"确认认输",color:"red"}
function love_letter:ui/button {code:2,label:"返回",color:"gray"}
function love_letter:ui/normalize
function love_letter:ui/show with storage love_letter:ui
