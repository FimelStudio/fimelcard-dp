function doudizhu:player/audience
tellraw @a[tag=dd.audience] {text:"[斗地主] 玩家离开，本局结束。",color:"yellow"}
function doudizhu:game/abort
tag @a[tag=dd.audience] remove dd.audience
tag @e[tag=dd.actors] remove dd.actors
