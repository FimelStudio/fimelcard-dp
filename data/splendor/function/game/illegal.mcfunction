tellraw @a[tag=sp.actor] {text:"[璀璨宝石] 操作未完成：请检查库存、支付数量、当前回合和待完成事项。",color:"red"}
function splendor:sound/illegal
execute as @a[tag=sp.actor] run function splendor:ui/open
