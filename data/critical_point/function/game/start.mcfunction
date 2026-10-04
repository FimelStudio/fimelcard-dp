execute unless score @s ct_joined matches 3..6 run tellraw @a[tag=ct.start_actor,limit=1] [{text:'[临界点] ',color:'red'},{text:'需要3至6名玩家入座。',color:'red'}]
execute unless score @s ct_joined matches 3..6 run return fail
scoreboard players operation #ctx cp_ctx = @s ct_id
scoreboard players set #blocked cp_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #ctx cp_ctx run function critical_point:game/check_hotbar
execute if score #blocked cp_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] [{text:'[临界点] ',color:'red'},{text:'所有玩家必须先腾空快捷栏。',color:'red'}]
execute if score #blocked cp_ctx matches 1 run return fail
tag @s add cp.controller
scoreboard players operation @s cp_id = @s ct_id
scoreboard players set @s cp_state 1
scoreboard players set @s cp_round 1
scoreboard players set @s cp_vote_used 0
scoreboard players operation @s cp_threshold = @s ct_joined
scoreboard players operation @s cp_threshold *= #three cp_ctx
scoreboard players add @s cp_threshold 2
execute as @a[tag=ct.player] if score @s ct_id = #ctx cp_ctx run tag @s add cp.player
execute as @a[tag=cp.player] if score @s ct_id = #ctx cp_ctx run scoreboard players operation @s cp_id = @s ct_id
execute as @a[tag=cp.player] if score @s cp_id = #ctx cp_ctx run scoreboard players operation @s cp_seat = @s ct_seat
execute as @a[tag=cp.player] if score @s cp_id = #ctx cp_ctx run scoreboard players set @s cp_role 1
tag @a[tag=cp.wolf_pool] remove cp.wolf_pool
execute as @a[tag=cp.player] if score @s cp_id = #ctx cp_ctx run tag @s add cp.wolf_pool
tag @a[tag=cp.wolf_pool,sort=random,limit=1] add cp.wolf
scoreboard players set @a[tag=cp.wolf_pool,tag=cp.wolf,limit=1] cp_role 2
tag @a[tag=cp.wolf_pool] remove cp.wolf_pool
execute as @a[tag=cp.player] if score @s cp_id = #ctx cp_ctx run function critical_point:player/give_cards
function critical_point:player/mark_audience
tellraw @a[tag=cp.audience,scores={cp_role=1}] [{text:'[临界点] ',color:'red'},{text:'你的身份是村民。合作控制总点数，并找出狼人。',color:'green'}]
tellraw @a[tag=cp.audience,scores={cp_role=2}] [{text:'[临界点] ',color:'red'},{text:'你的身份是狼人。隐藏自己，并寻找制造危机的时机。',color:'dark_red',bold:true}]
tellraw @a[tag=cp.audience] [{text:'[临界点] ',color:'red'},{text:'当前人数：',color:'yellow'},{score:{name:'@s',objective:'ct_joined'}},{text:'；安全线：',color:'yellow'},{score:{name:'@s',objective:'cp_threshold'},color:'aqua'},{text:'点。',color:'yellow'}]
tag @a[tag=cp.audience] remove cp.audience
scoreboard players set @s ct_start 1
function critical_point:round/begin
