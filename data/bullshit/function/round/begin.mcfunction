# 依座位向左寻找下一名大聪明，空座位自动跳过。
scoreboard players operation #ctx bw_ctx = @s bw_id
tag @a[tag=bw.next_smart] remove bw.next_smart
scoreboard players set #found bw_ctx 0
function bullshit:round/scan_smart
execute if score #found bw_ctx matches 0 run function bullshit:round/scan_smart
execute if score #found bw_ctx matches 0 run function bullshit:round/scan_smart
execute if score #found bw_ctx matches 0 run function bullshit:round/scan_smart
execute unless entity @a[tag=bw.next_smart,limit=1] run function bullshit:game/abort
execute unless entity @a[tag=bw.next_smart,limit=1] run return 0
tag @a[tag=bw.smart] remove bw.smart
tag @a[tag=bw.honest] remove bw.honest
tag @a[tag=bw.bluffer] remove bw.bluffer
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run scoreboard players set @s bw_role 3
scoreboard players set @a[tag=bw.next_smart,limit=1] bw_role 1
tag @a[tag=bw.player,tag=!bw.next_smart] add bw.honest_pool
tag @a[tag=bw.honest_pool,sort=random,limit=1] add bw.honest
tag @a[tag=bw.honest] remove bw.honest_pool
tag @a[tag=bw.honest_pool] remove bw.honest_pool
scoreboard players set @a[tag=bw.honest,limit=1] bw_role 2
tag @a[tag=bw.honest] remove bw.honest
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run scoreboard players set @s bw_used 0
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run scoreboard players set @s bw_bs 0
scoreboard players set @s bw_timer 0
scoreboard players set @s bw_state 1
execute store result score @s bw_question run random value 1..64
function bullshit:question/show
tellraw @a[tag=bw.player] [{text:'[瞎掰王] ',color:'yellow'},{text:'身份将在20秒阅读结束后公布，请先阅读题目。',color:'gray'}]
