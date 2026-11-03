# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage magical_athlete:ui option.label set value "选项 $(target)"
$execute if predicate {condition:"minecraft:value_check",value:$(target),range:-1} run data modify storage magical_athlete:ui option.label set value "放弃技能"
execute if data storage magical_athlete:ui option{kind:"ready"} run data modify storage magical_athlete:ui option.label set value "投骰／开始移动"
execute if data storage magical_athlete:ui option{kind:"reroll",target:0} run data modify storage magical_athlete:ui option.label set value "接受骰值"
execute if data storage magical_athlete:ui option{kind:"reroll",target:1} run data modify storage magical_athlete:ui option.label set value "再掷一次"
execute if data storage magical_athlete:ui option{kind:"alchemist",target:0} run data modify storage magical_athlete:ui option.label set value "保留骰值"
execute if data storage magical_athlete:ui option{kind:"alchemist",target:1} run data modify storage magical_athlete:ui option.label set value "改为4点"
execute if data storage magical_athlete:ui option{kind:"rocket",target:0} run data modify storage magical_athlete:ui option.label set value "正常前进"
execute if data storage magical_athlete:ui option{kind:"rocket",target:1} run data modify storage magical_athlete:ui option.label set value "移动翻倍并绊倒"
execute if data storage magical_athlete:ui option{kind:"cheerleader",target:0} run data modify storage magical_athlete:ui option.label set value "不加油"
execute if data storage magical_athlete:ui option{kind:"cheerleader",target:1} run data modify storage magical_athlete:ui option.label set value "加油"
execute if data storage magical_athlete:ui option{kind:"legs",target:0} run data modify storage magical_athlete:ui option.label set value "正常投骰"
execute if data storage magical_athlete:ui option{kind:"legs",target:1} run data modify storage magical_athlete:ui option.label set value "直接前进5格"
execute if data storage magical_athlete:ui option{kind:"genius",target:0} run data modify storage magical_athlete:ui option.label set value "不预测"
execute if data storage magical_athlete:ui option{kind:"suckerfish",target:0} run data modify storage magical_athlete:ui option.label set value "不跟随"
execute if data storage magical_athlete:ui option{kind:"suckerfish",target:1} run data modify storage magical_athlete:ui option.label set value "跟随移动"
execute if data storage magical_athlete:ui option{kind:"hypnotist"} run function magical_athlete:ui/target_label with storage magical_athlete:ui option
execute if data storage magical_athlete:ui option{kind:"flip"} run function magical_athlete:ui/target_label with storage magical_athlete:ui option
execute if data storage magical_athlete:ui option{kind:"duel"} run function magical_athlete:ui/target_label with storage magical_athlete:ui option
execute if data storage magical_athlete:ui option{kind:"mastermind"} run function magical_athlete:ui/target_label with storage magical_athlete:ui option
execute if data storage magical_athlete:ui option{kind:"copycat"} run function magical_athlete:ui/target_label with storage magical_athlete:ui option
execute if data storage magical_athlete:ui option{kind:"egg"} run function magical_athlete:ui/character_label with storage magical_athlete:ui option
execute if data storage magical_athlete:ui option{kind:"twin"} run function magical_athlete:ui/character_label with storage magical_athlete:ui option
execute if data storage magical_athlete:ui option{kind:"genius"} unless score #option ma_ctx matches 0 run function magical_athlete:ui/guess_label with storage magical_athlete:ui option
execute if data storage magical_athlete:ui option{kind:"thirdwheel"} unless score #option ma_ctx matches -1 run function magical_athlete:ui/space_label with storage magical_athlete:ui option
function magical_athlete:ui/choice_button with storage magical_athlete:ui option
