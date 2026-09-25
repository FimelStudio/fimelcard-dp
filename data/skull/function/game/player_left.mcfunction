function skull:player/audience
tellraw @a[tag=sk.audience] {text:"[骷髅牌] 有玩家离线或离开，本局结束。",color:"yellow"}
function skull:log {text:"在线玩家不完整，中止本桌"}
function skull:game/abort
