function uno:system/context
function uno:visual/clear_cards
function uno:animation/clear
function uno:visual/ensure_box
kill @e[type=minecraft:marker,tag=un.cards]
scoreboard players add @s un_round 1
scoreboard players set @s un_state 1
scoreboard players set @s un_timer 20
scoreboard players set @s un_dealt 0
scoreboard players set @s un_dir 1
scoreboard players set @s un_pending 0
scoreboard players set @s un_top 0
scoreboard players set @s un_drew 0
scoreboard players set @s un_drawn 0
scoreboard players set @s un_winner 0
scoreboard players set @s un_called 0
scoreboard players set @s un_matchend 0
execute as @e[tag=un.audience] run scoreboard players set @s un_count 0
execute as @e[tag=un.audience] run scoreboard players set @s un_pick -1
scoreboard players operation @s un_turn = @e[tag=un.audience,sort=random,limit=1] un_seat
function uno:deck/create
function uno:system/advance
tellraw @a[tag=un.audience] [{text:'[UNO] 第 ',color:'gold'},{score:{name:'@s',objective:'un_round'}},{text:' 局：每人七张牌。'}]
function uno:log {text:"开始新小局及公共逐张发牌动画"}
