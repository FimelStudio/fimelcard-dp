scoreboard players operation #ctx cp_ctx = @s cp_id
scoreboard players set @s cp_state 1
execute as @a[tag=cp.player] if score @s cp_id = #ctx cp_ctx run scoreboard players set @s cp_play 0
execute as @a[tag=cp.player] if score @s cp_id = #ctx cp_ctx run scoreboard players set @s cp_locked 0
execute as @a[tag=cp.player] if score @s cp_id = #ctx cp_ctx run scoreboard players set @s cp_ready 0
execute as @a[tag=cp.player] if score @s cp_id = #ctx cp_ctx run function critical_point:input/give_signal_tools
function critical_point:player/mark_audience
tellraw @a[tag=cp.audience] [{text:'════ 第 ',color:'gold',bold:true},{score:{name:'@s',objective:'cp_round'},color:'gold'},{text:' 轮 ════',color:'gold',bold:true}]
tellraw @a[tag=cp.audience] [{text:'讨论后，从剩余的数字牌中选择一张按Q。黑色/白色染料按Q可分别表示本轮倾向出偏大/偏小的牌。所有人锁定后才会统一公开。',color:'yellow'}]
tag @a[tag=cp.audience] remove cp.audience
