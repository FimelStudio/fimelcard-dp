$execute as @e[type=minecraft:text_display,tag=go.clock] if score @s ct_id = #table go_ctx run data modify entity @s text set value [{text:"围棋 · $(status)\n",color:"gold"},{text:"不限时",color:"gray"}]
