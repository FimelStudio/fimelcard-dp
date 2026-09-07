scoreboard players operation #ctx cp_ctx = @s cp_id
scoreboard players set @s cp_state 3
scoreboard players set @s cp_vote_used 1
function critical_point:input/clear_tools
execute as @a[tag=cp.player] if score @s cp_id = #ctx cp_ctx run scoreboard players set @s cp_vote 0
execute as @a[tag=cp.player] if score @s cp_id = #ctx cp_ctx run scoreboard players set @s cp_locked 0
function critical_point:player/mark_audience
tellraw @a[tag=cp.audience] [{text:'════ 最终投票 ════',color:'red',bold:true}]
tellraw @a[tag=cp.audience] [{text:'秘密选择一名其他玩家。请按Q丢出紫色染料打开投票；不可弃权、不可投自己，最高票平票或处决村民均为狼人获胜。',color:'yellow'}]
execute as @a[tag=cp.audience] run function critical_point:input/give_vote_reopen
tag @a[tag=cp.audience] remove cp.audience
