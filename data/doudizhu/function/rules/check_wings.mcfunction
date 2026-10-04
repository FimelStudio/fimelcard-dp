# 主体以外的单翅最多两张同点数，不能把三张或炸弹当成单翅。
scoreboard players set #bad_wing dd_ctx 0
scoreboard players set #wing_rank dd_ctx 3
execute if score #r3 dd_ctx matches 3.. if score #wing_rank dd_ctx < #body_low dd_ctx run scoreboard players set #bad_wing dd_ctx 1
execute if score #r3 dd_ctx matches 3.. if score #wing_rank dd_ctx > #body_high dd_ctx run scoreboard players set #bad_wing dd_ctx 1
scoreboard players set #wing_rank dd_ctx 4
execute if score #r4 dd_ctx matches 3.. if score #wing_rank dd_ctx < #body_low dd_ctx run scoreboard players set #bad_wing dd_ctx 1
execute if score #r4 dd_ctx matches 3.. if score #wing_rank dd_ctx > #body_high dd_ctx run scoreboard players set #bad_wing dd_ctx 1
scoreboard players set #wing_rank dd_ctx 5
execute if score #r5 dd_ctx matches 3.. if score #wing_rank dd_ctx < #body_low dd_ctx run scoreboard players set #bad_wing dd_ctx 1
execute if score #r5 dd_ctx matches 3.. if score #wing_rank dd_ctx > #body_high dd_ctx run scoreboard players set #bad_wing dd_ctx 1
scoreboard players set #wing_rank dd_ctx 6
execute if score #r6 dd_ctx matches 3.. if score #wing_rank dd_ctx < #body_low dd_ctx run scoreboard players set #bad_wing dd_ctx 1
execute if score #r6 dd_ctx matches 3.. if score #wing_rank dd_ctx > #body_high dd_ctx run scoreboard players set #bad_wing dd_ctx 1
scoreboard players set #wing_rank dd_ctx 7
execute if score #r7 dd_ctx matches 3.. if score #wing_rank dd_ctx < #body_low dd_ctx run scoreboard players set #bad_wing dd_ctx 1
execute if score #r7 dd_ctx matches 3.. if score #wing_rank dd_ctx > #body_high dd_ctx run scoreboard players set #bad_wing dd_ctx 1
scoreboard players set #wing_rank dd_ctx 8
execute if score #r8 dd_ctx matches 3.. if score #wing_rank dd_ctx < #body_low dd_ctx run scoreboard players set #bad_wing dd_ctx 1
execute if score #r8 dd_ctx matches 3.. if score #wing_rank dd_ctx > #body_high dd_ctx run scoreboard players set #bad_wing dd_ctx 1
scoreboard players set #wing_rank dd_ctx 9
execute if score #r9 dd_ctx matches 3.. if score #wing_rank dd_ctx < #body_low dd_ctx run scoreboard players set #bad_wing dd_ctx 1
execute if score #r9 dd_ctx matches 3.. if score #wing_rank dd_ctx > #body_high dd_ctx run scoreboard players set #bad_wing dd_ctx 1
scoreboard players set #wing_rank dd_ctx 10
execute if score #r10 dd_ctx matches 3.. if score #wing_rank dd_ctx < #body_low dd_ctx run scoreboard players set #bad_wing dd_ctx 1
execute if score #r10 dd_ctx matches 3.. if score #wing_rank dd_ctx > #body_high dd_ctx run scoreboard players set #bad_wing dd_ctx 1
scoreboard players set #wing_rank dd_ctx 11
execute if score #r11 dd_ctx matches 3.. if score #wing_rank dd_ctx < #body_low dd_ctx run scoreboard players set #bad_wing dd_ctx 1
execute if score #r11 dd_ctx matches 3.. if score #wing_rank dd_ctx > #body_high dd_ctx run scoreboard players set #bad_wing dd_ctx 1
scoreboard players set #wing_rank dd_ctx 12
execute if score #r12 dd_ctx matches 3.. if score #wing_rank dd_ctx < #body_low dd_ctx run scoreboard players set #bad_wing dd_ctx 1
execute if score #r12 dd_ctx matches 3.. if score #wing_rank dd_ctx > #body_high dd_ctx run scoreboard players set #bad_wing dd_ctx 1
scoreboard players set #wing_rank dd_ctx 13
execute if score #r13 dd_ctx matches 3.. if score #wing_rank dd_ctx < #body_low dd_ctx run scoreboard players set #bad_wing dd_ctx 1
execute if score #r13 dd_ctx matches 3.. if score #wing_rank dd_ctx > #body_high dd_ctx run scoreboard players set #bad_wing dd_ctx 1
scoreboard players set #wing_rank dd_ctx 14
execute if score #r14 dd_ctx matches 3.. if score #wing_rank dd_ctx < #body_low dd_ctx run scoreboard players set #bad_wing dd_ctx 1
execute if score #r14 dd_ctx matches 3.. if score #wing_rank dd_ctx > #body_high dd_ctx run scoreboard players set #bad_wing dd_ctx 1
scoreboard players set #wing_rank dd_ctx 15
execute if score #r15 dd_ctx matches 3.. if score #wing_rank dd_ctx < #body_low dd_ctx run scoreboard players set #bad_wing dd_ctx 1
execute if score #r15 dd_ctx matches 3.. if score #wing_rank dd_ctx > #body_high dd_ctx run scoreboard players set #bad_wing dd_ctx 1
scoreboard players set #wing_rank dd_ctx 16
execute if score #r16 dd_ctx matches 3.. if score #wing_rank dd_ctx < #body_low dd_ctx run scoreboard players set #bad_wing dd_ctx 1
execute if score #r16 dd_ctx matches 3.. if score #wing_rank dd_ctx > #body_high dd_ctx run scoreboard players set #bad_wing dd_ctx 1
scoreboard players set #wing_rank dd_ctx 17
execute if score #r17 dd_ctx matches 3.. if score #wing_rank dd_ctx < #body_low dd_ctx run scoreboard players set #bad_wing dd_ctx 1
execute if score #r17 dd_ctx matches 3.. if score #wing_rank dd_ctx > #body_high dd_ctx run scoreboard players set #bad_wing dd_ctx 1
