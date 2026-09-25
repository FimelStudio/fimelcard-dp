# 任一倾向染料提交后，移除该玩家的两种倾向工具，避免同一回合重复或改口提示。
clear @s minecraft:black_dye[minecraft:custom_data~{critical_point:{tool:'signal_big'}}]
clear @s minecraft:white_dye[minecraft:custom_data~{critical_point:{tool:'signal_small'}}]
