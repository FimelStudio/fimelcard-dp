# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
data modify storage magical_athlete:ui detail.extra append value {text:"请选择技能选项。\n\n",color:"yellow"}
execute if data storage magical_athlete:ui pending{kind:"ready"} run data modify storage magical_athlete:ui detail.extra append value {"text":"开始主要移动\n\n","color":"aqua"}
execute if data storage magical_athlete:ui pending{kind:"reroll"} run data modify storage magical_athlete:ui detail.extra append value {"text":"是否重掷？接受后按当前骰值前进；重掷必须使用新的结果。\n\n","color":"aqua"}
execute if data storage magical_athlete:ui pending{kind:"alchemist"} run data modify storage magical_athlete:ui detail.extra append value {"text":"炼金术士：将本次1或2改为4？\n\n","color":"aqua"}
execute if data storage magical_athlete:ui pending{kind:"rocket"} run data modify storage magical_athlete:ui detail.extra append value {"text":"火箭科学家：移动翻倍，随后绊倒？\n\n","color":"aqua"}
execute if data storage magical_athlete:ui pending{kind:"cheerleader"} run data modify storage magical_athlete:ui detail.extra append value {"text":"啦啦队长：给末位选手加油？\n\n","color":"aqua"}
execute if data storage magical_athlete:ui pending{kind:"hypnotist"} run data modify storage magical_athlete:ui detail.extra append value {"text":"催眠师：选择传送到自己位置的选手。\n\n","color":"aqua"}
execute if data storage magical_athlete:ui pending{kind:"flip"} run data modify storage magical_athlete:ui detail.extra append value {"text":"翻转者：选择交换位置的选手。\n\n","color":"aqua"}
execute if data storage magical_athlete:ui pending{kind:"duel"} run data modify storage magical_athlete:ui detail.extra append value {"text":"决斗者：选择同格对手决斗。\n\n","color":"aqua"}
execute if data storage magical_athlete:ui pending{kind:"mastermind"} run data modify storage magical_athlete:ui detail.extra append value {"text":"谋划者：预测本场冠军。\n\n","color":"aqua"}
execute if data storage magical_athlete:ui pending{kind:"copycat"} run data modify storage magical_athlete:ui detail.extra append value {"text":"模仿者：选择本场要复制的能力。\n\n","color":"aqua"}
execute if data storage magical_athlete:ui pending{kind:"genius"} run data modify storage magical_athlete:ui detail.extra append value {"text":"天才：选择要预测的骰值（0表示放弃）。\n\n","color":"aqua"}
execute if data storage magical_athlete:ui pending{kind:"legs"} run data modify storage magical_athlete:ui detail.extra append value {"text":"大长腿：选择正常掷骰，或直接前进5格。\n\n","color":"aqua"}
execute if data storage magical_athlete:ui pending{kind:"egg"} run data modify storage magical_athlete:ui detail.extra append value {"text":"蛋：选择孵化后的角色。\n\n","color":"aqua"}
execute if data storage magical_athlete:ui pending{kind:"twin"} run data modify storage magical_athlete:ui detail.extra append value {"text":"双胞胎：选择附带的角色能力。\n\n","color":"aqua"}
execute if data storage magical_athlete:ui pending{kind:"suckerfish"} run data modify storage magical_athlete:ui detail.extra append value {"text":"吸盘鱼：跟随目标一起移动？\n\n","color":"aqua"}
execute if data storage magical_athlete:ui pending{kind:"thirdwheel"} run data modify storage magical_athlete:ui detail.extra append value {"text":"电灯泡：选择要插入的格子，或放弃。\n\n","color":"aqua"}
