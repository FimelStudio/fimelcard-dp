function love_letter:system/context
tellraw @a[tag=ll.audience] {text:"[情书] 有参与者离开牌桌，本场中止。",color:"yellow"}
function love_letter:game/cleanup
