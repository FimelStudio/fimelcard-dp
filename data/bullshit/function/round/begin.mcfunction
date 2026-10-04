# 依座位向左寻找下一名大聪明，空座位自动跳过。
scoreboard players operation #ctx bw_ctx = @s bw_id
tag @a[tag=bw.next_smart] remove bw.next_smart
scoreboard players set #found bw_ctx 0
function bullshit:round/scan_smart
execute if score #found bw_ctx matches 0 run function bullshit:round/scan_smart
execute if score #found bw_ctx matches 0 run function bullshit:round/scan_smart
execute if score #found bw_ctx matches 0 run function bullshit:round/scan_smart
execute if score #found bw_ctx matches 0 run function bullshit:round/scan_smart
execute if score #found bw_ctx matches 0 run function bullshit:round/scan_smart
execute if score #found bw_ctx matches 0 run function bullshit:round/scan_smart
execute if score #found bw_ctx matches 0 run function bullshit:round/scan_smart
execute unless entity @a[tag=bw.next_smart,limit=1] run function bullshit:game/abort
execute unless entity @a[tag=bw.next_smart,limit=1] run return 0
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run tag @s remove bw.smart
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run tag @s remove bw.honest
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run tag @s remove bw.bluffer
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run scoreboard players set @s bw_role 3
scoreboard players set @a[tag=bw.next_smart,limit=1] bw_role 1
tag @a[tag=bw.honest_pool] remove bw.honest_pool
execute as @a[tag=bw.player,tag=!bw.next_smart] if score @s bw_id = #ctx bw_ctx run tag @s add bw.honest_pool
scoreboard players set @a[tag=bw.honest_pool,sort=random,limit=1] bw_role 2
tag @a[tag=bw.honest_pool] remove bw.honest_pool
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run scoreboard players set @s bw_used 0
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run scoreboard players set @s bw_bs 0
scoreboard players set @s bw_timer 0
scoreboard players set @s bw_state 1
execute store result score @s bw_question run random value 1..64
function bullshit:question/show
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run tellraw @s [{text:'[瞎掰王] ',color:'yellow'},{text:'请阅读题目，20秒后公布大聪明。老实人请阅读私密对话框，期间可按Q丢出紫色染料重开；公布身份后不能再查看。',color:'gray'}]
execute as @a[tag=bw.player,scores={bw_role=2}] if score @s bw_id = #ctx bw_ctx run tellraw @s [{text:'[瞎掰王] ',color:'yellow'},{text:'你是本轮老实人。请记住对话框中的私密答案。',color:'green'}]
function bullshit:question/resume_reading
