execute store result storage weiqi:ray distance double 0.000244140625 run scoreboard players get #ray_mid go_ctx
function weiqi:input/ray_position with storage weiqi:ray
scoreboard players set #ray_below go_ctx 0
# dx/dy/dz选择器的正向边界额外包含一格，所以顶面为1.025。
execute at @e[tag=go.current,limit=1] positioned ~-8 ~-6.975 ~-8 if entity @e[type=minecraft:marker,tag=go.ray,dx=15,dy=7,dz=15,limit=1] run scoreboard players set #ray_below go_ctx 1
