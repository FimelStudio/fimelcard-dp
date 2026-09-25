function skull:player/audience
data modify storage skull:hud text set value {text:"本轮出牌数量\n",color:"gold",bold:false,extra:[]}
execute as @a[tag=sk.audience] run function skull:hud/player
execute as @e[type=minecraft:text_display,tag=sk.board] if score @s sk_id = #ctx sk_ctx run data modify entity @s text set from storage skull:hud text
