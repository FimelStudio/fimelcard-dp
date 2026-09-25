function wenfei:player/mark_audience
tellraw @a[tag=wq.audience] {text:"[问非所答] 结束投票通过，本局提前结束。",color:"yellow"}
function wenfei:log {text:"结束投票通过"}
function wenfei:game/abort
