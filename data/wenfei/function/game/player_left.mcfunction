function wenfei:player/mark_audience
tellraw @a[tag=wq.audience] {text:"[问非所答] 有玩家离线或离开，本局结束。",color:"yellow"}
function wenfei:log {text:"有人离线，清理本桌"}
function wenfei:game/abort
