# 执行者是控制器；一次性从剩余牌库移出三张牌并绑定当前玩家
scoreboard players operation #ctx_id lh_ctx = @s lh_id
scoreboard players operation #swap_seat lh_ctx = @a[tag=lh.swap_actor,limit=1] lh_seat
scoreboard players operation #swap_old_slot lh_ctx = @a[tag=lh.swap_actor,limit=1] lh_swap_slot
function liars_holdem:deck/select_random
tag @e[tag=lh.drawn,limit=1] add lh.swap_drawn
tag @e[tag=lh.swap_drawn,limit=1] remove lh.deck
tag @e[tag=lh.swap_drawn,limit=1] add lh.swap_candidate
scoreboard players set @e[tag=lh.swap_drawn,limit=1] lh_slot 1
scoreboard players operation @e[tag=lh.swap_drawn,limit=1] lh_seat = #swap_seat lh_ctx
tag @e[tag=lh.swap_drawn] remove lh.swap_drawn
tag @e[tag=lh.drawn] remove lh.drawn

function liars_holdem:deck/select_random
tag @e[tag=lh.drawn,limit=1] add lh.swap_drawn
tag @e[tag=lh.swap_drawn,limit=1] remove lh.deck
tag @e[tag=lh.swap_drawn,limit=1] add lh.swap_candidate
scoreboard players set @e[tag=lh.swap_drawn,limit=1] lh_slot 2
scoreboard players operation @e[tag=lh.swap_drawn,limit=1] lh_seat = #swap_seat lh_ctx
tag @e[tag=lh.swap_drawn] remove lh.swap_drawn
tag @e[tag=lh.drawn] remove lh.drawn

function liars_holdem:deck/select_random
tag @e[tag=lh.drawn,limit=1] add lh.swap_drawn
tag @e[tag=lh.swap_drawn,limit=1] remove lh.deck
tag @e[tag=lh.swap_drawn,limit=1] add lh.swap_candidate
scoreboard players set @e[tag=lh.swap_drawn,limit=1] lh_slot 3
scoreboard players operation @e[tag=lh.swap_drawn,limit=1] lh_seat = #swap_seat lh_ctx
tag @e[tag=lh.swap_drawn] remove lh.swap_drawn
tag @e[tag=lh.drawn] remove lh.drawn

# 构造三个带自定义字体和点击事件的候选牌组件
data modify storage liars_holdem:dialog card1 set value {text:"?",font:"card:card",shadow_color:0,click_event:{action:"run_command",command:"trigger lh_swap_pick set 1"}}
data modify storage liars_holdem:dialog card2 set value {text:"?",font:"card:card",shadow_color:0,click_event:{action:"run_command",command:"trigger lh_swap_pick set 2"}}
data modify storage liars_holdem:dialog card3 set value {text:"?",font:"card:card",shadow_color:0,click_event:{action:"run_command",command:"trigger lh_swap_pick set 3"}}
execute as @e[tag=lh.swap_candidate,scores={lh_slot=1}] if score @s lh_id = #ctx_id lh_ctx if score @s lh_seat = #swap_seat lh_ctx run function liars_holdem:swap/load_option {key:"card1"}
execute as @e[tag=lh.swap_candidate,scores={lh_slot=2}] if score @s lh_id = #ctx_id lh_ctx if score @s lh_seat = #swap_seat lh_ctx run function liars_holdem:swap/load_option {key:"card2"}
execute as @e[tag=lh.swap_candidate,scores={lh_slot=3}] if score @s lh_id = #ctx_id lh_ctx if score @s lh_seat = #swap_seat lh_ctx run function liars_holdem:swap/load_option {key:"card3"}

# 显示没有被丢出的另一张手牌；权威手牌标记在换牌提交前仍完整保留
data modify storage liars_holdem:dialog other_hand set value {text:"?",font:"card:card",color:"white",shadow_color:0}
execute as @e[type=minecraft:marker,tag=lh.hand_card] if score @s lh_id = #ctx_id lh_ctx if score @s lh_seat = #swap_seat lh_ctx unless score @s lh_slot = #swap_old_slot lh_ctx run function liars_holdem:swap/load_option {key:"other_hand"}

# 只显示当前已经翻开的公共牌，未翻开的牌面不能通过Dialog提前泄露
data modify storage liars_holdem:dialog public1 set value {text:"",font:"card:card",color:"white",shadow_color:0}
data modify storage liars_holdem:dialog public2 set value {text:"",font:"card:card",color:"white",shadow_color:0}
data modify storage liars_holdem:dialog public3 set value {text:"",font:"card:card",color:"white",shadow_color:0}
data modify storage liars_holdem:dialog public4 set value {text:"",font:"card:card",color:"white",shadow_color:0}
data modify storage liars_holdem:dialog public5 set value {text:"",font:"card:card",color:"white",shadow_color:0}
data modify storage liars_holdem:dialog public_empty set value {text:"尚无已翻开的公共牌",color:"dark_gray"}
scoreboard players set #swap_public_count lh_ctx 0
execute as @e[type=minecraft:item_display,tag=lh.community,scores={lh_slot=1,lh_flipped=1}] if score @s lh_id = #ctx_id lh_ctx run function liars_holdem:swap/load_public {key:"public1"}
execute as @e[type=minecraft:item_display,tag=lh.community,scores={lh_slot=2,lh_flipped=1}] if score @s lh_id = #ctx_id lh_ctx run function liars_holdem:swap/load_public {key:"public2"}
execute as @e[type=minecraft:item_display,tag=lh.community,scores={lh_slot=3,lh_flipped=1}] if score @s lh_id = #ctx_id lh_ctx run function liars_holdem:swap/load_public {key:"public3"}
execute as @e[type=minecraft:item_display,tag=lh.community,scores={lh_slot=4,lh_flipped=1}] if score @s lh_id = #ctx_id lh_ctx run function liars_holdem:swap/load_public {key:"public4"}
execute as @e[type=minecraft:item_display,tag=lh.community,scores={lh_slot=5,lh_flipped=1}] if score @s lh_id = #ctx_id lh_ctx run function liars_holdem:swap/load_public {key:"public5"}
execute if score #swap_public_count lh_ctx matches 1.. run data modify storage liars_holdem:dialog public_empty.text set value ""

scoreboard players set @a[tag=lh.swap_actor,limit=1] lh_swap_pick 0
scoreboard players enable @a[tag=lh.swap_actor,limit=1] lh_swap_pick
function liars_holdem:swap/open_dialog with storage liars_holdem:dialog
function liars_holdem:sound/swap_open
function liars_holdem:log {text:"已锁定三张换牌候选并打开换牌Dialog"}
