$execute as @e[type=minecraft:text_display,tag=ct.vote] if score @s ct_id = #vote_table ct_ctx run data modify entity @s text set value {text:"结束游戏 $(votes)/$(need)",color:"red"}
