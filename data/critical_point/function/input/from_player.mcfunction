# 仅分发当前物品，处理期间不再搜索玩家附近的其它物品。
execute if items entity @e[type=minecraft:item,tag=cp.input_drop,limit=1] contents minecraft:paper[minecraft:custom_data~{critical_point:{card:1b}}] run return run function critical_point:input/card
execute if items entity @e[type=minecraft:item,tag=cp.input_drop,limit=1] contents minecraft:paper[minecraft:custom_data~{critical_point:{card:2b}}] run return run function critical_point:input/card
execute if items entity @e[type=minecraft:item,tag=cp.input_drop,limit=1] contents minecraft:paper[minecraft:custom_data~{critical_point:{card:3b}}] run return run function critical_point:input/card
execute if items entity @e[type=minecraft:item,tag=cp.input_drop,limit=1] contents minecraft:paper[minecraft:custom_data~{critical_point:{card:4b}}] run return run function critical_point:input/card
execute if items entity @e[type=minecraft:item,tag=cp.input_drop,limit=1] contents minecraft:paper[minecraft:custom_data~{critical_point:{card:5b}}] run return run function critical_point:input/card
execute if items entity @e[type=minecraft:item,tag=cp.input_drop,limit=1] contents minecraft:red_dye[minecraft:custom_data~{critical_point:{tool:'vote'}}] run return run function critical_point:input/start_vote
execute if items entity @e[type=minecraft:item,tag=cp.input_drop,limit=1] contents minecraft:lime_dye[minecraft:custom_data~{critical_point:{tool:'ready'}}] run return run function critical_point:input/ready
execute if items entity @e[type=minecraft:item,tag=cp.input_drop,limit=1] contents minecraft:purple_dye[minecraft:custom_data~{critical_point:{tool:'vote_reopen'}}] run return run function critical_point:input/reopen_vote
execute if items entity @e[type=minecraft:item,tag=cp.input_drop,limit=1] contents minecraft:black_dye[minecraft:custom_data~{critical_point:{tool:'signal_big'}}] run return run function critical_point:input/signal_big
execute if items entity @e[type=minecraft:item,tag=cp.input_drop,limit=1] contents minecraft:white_dye[minecraft:custom_data~{critical_point:{tool:'signal_small'}}] run return run function critical_point:input/signal_small
