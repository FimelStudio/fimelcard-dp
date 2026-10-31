# 认输在行棋、动画、升变阶段均可使用；始终经过确认按钮。
function chess:ui/begin
data modify storage chess:ui phase set value "确认认输？"
function chess:ui/button {code:1,label:"确认认输",color:"red"}
function chess:ui/show with storage chess:ui
tag @a[tag=ch.actor] remove ch.actor
