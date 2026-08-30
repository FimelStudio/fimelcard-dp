scoreboard players set @s bw_state 2
scoreboard players set @s bw_timer 0
scoreboard players operation #ctx bw_ctx = @s bw_id
execute as @a[tag=bw.smart] if score @s bw_id = #ctx bw_ctx run function bullshit:input/give_tools
tellraw @a[tag=bw.player] [{text:'[瞎掰王] ',color:'yellow'},{text:'阅读结束，开始问答。大聪明可在准备好后Q键使用“结束问答并指认”。',color:'gray'}]
