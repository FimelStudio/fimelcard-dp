scoreboard players set @s un_state 3
scoreboard players operation @s un_pending = @s un_offender
scoreboard players operation @s un_timer = @s un_window
scoreboard players set @s un_called 0
scoreboard players set @s un_drew 0
scoreboard players set @s un_drawn 0
tellraw @a[tag=un.audience] [{text:'[UNO] 有人只剩一张牌却没喊 UNO！按 Q 抓 UNO；本人可以补喊。',color:'yellow'}]
function uno:log {text:"暂停下家回合，开放抓 UNO 窗口"}
function uno:system/advance
