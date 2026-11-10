scoreboard players set #can_roll ma_ctx 0
execute unless entity @e[tag=ma.current,scores={ma_state=3,ma_anim=0},limit=1] run return 0
execute if entity @e[tag=ma.current,scores={ma_pending=0},limit=1] if score @s ma_side = @e[tag=ma.current,limit=1] ma_turn run scoreboard players set #can_roll ma_ctx 1
execute if score @s ma_side = @e[tag=ma.current,limit=1] ma_pending if data entity @e[tag=ma.current,limit=1] data.magical_athlete.pending{kind:"ready"} run scoreboard players set #can_roll ma_ctx 1
