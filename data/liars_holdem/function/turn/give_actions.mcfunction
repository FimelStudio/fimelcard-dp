# 当前执行者是本回合行动玩家，#turn_state由控制器在同步函数链中写入
function liars_holdem:util/clear_items_actions
execute store result storage liars_holdem:action table int 1 run scoreboard players get @s lh_id
execute if score #turn_state lh_ctx matches 5 run function liars_holdem:turn/give_normal with storage liars_holdem:action
execute if score #turn_state lh_ctx matches 7 run function liars_holdem:turn/give_normal with storage liars_holdem:action
execute if score #turn_state lh_ctx matches 9 run function liars_holdem:turn/give_normal with storage liars_holdem:action
execute if score #turn_state lh_ctx matches 11 run function liars_holdem:turn/give_allin with storage liars_holdem:action
execute if score #turn_state lh_ctx matches 12 run function liars_holdem:turn/give_follow with storage liars_holdem:action
function liars_holdem:turn/give_fold with storage liars_holdem:action
function liars_holdem:sound/turn_start

execute if score #turn_state lh_ctx matches 5 if score @s lh_swap matches 1 run title @s actionbar [{text:'轮到你：',color:'gold'},{text:'Q跟注　F全押　Q弃牌　Q丢手牌换牌',color:'yellow'}]
execute if score #turn_state lh_ctx matches 7 if score @s lh_swap matches 1 run title @s actionbar [{text:'轮到你：',color:'gold'},{text:'Q跟注　F全押　Q弃牌　Q丢手牌换牌',color:'yellow'}]
execute if score #turn_state lh_ctx matches 9 if score @s lh_swap matches 1 run title @s actionbar [{text:'轮到你：',color:'gold'},{text:'Q跟注　F全押　Q弃牌　Q丢手牌换牌',color:'yellow'}]
execute if score #turn_state lh_ctx matches 5 unless score @s lh_swap matches 1 run title @s actionbar [{text:'轮到你：',color:'gold'},{text:'Q跟注　F全押　Q弃牌',color:'yellow'}]
execute if score #turn_state lh_ctx matches 7 unless score @s lh_swap matches 1 run title @s actionbar [{text:'轮到你：',color:'gold'},{text:'Q跟注　F全押　Q弃牌',color:'yellow'}]
execute if score #turn_state lh_ctx matches 9 unless score @s lh_swap matches 1 run title @s actionbar [{text:'轮到你：',color:'gold'},{text:'Q跟注　F全押　Q弃牌',color:'yellow'}]
execute if score #turn_state lh_ctx matches 11 run title @s actionbar [{text:'轮到你：',color:'gold'},{text:'F全押（也可Q丢绿色物品）　或Q弃牌',color:'red'}]
execute if score #turn_state lh_ctx matches 12 run title @s actionbar [{text:'轮到你：',color:'gold'},{text:'Q跟随ALL IN　或Q弃牌',color:'red'}]
tellraw @s [{text:'[赌命德州扑克] ',color:'red'},{text:'轮到你行动。操作物品位于快捷栏最右两格。',color:'yellow'}]
