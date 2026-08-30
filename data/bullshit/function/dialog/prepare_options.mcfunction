# Dialog不解析selector，先把本桌玩家ID固化为静态文本；按钮提交值仍采用固定座位编号。
scoreboard players operation #ctx bw_ctx = @s bw_id
data modify storage bullshit:dialog name1 set value {text:'空座位',color:'dark_gray'}
data modify storage bullshit:dialog name2 set value {text:'空座位',color:'dark_gray'}
data modify storage bullshit:dialog name3 set value {text:'空座位',color:'dark_gray'}
data modify storage bullshit:dialog name4 set value {text:'空座位',color:'dark_gray'}
execute as @a[tag=bw.player,scores={bw_seat=1}] if score @s bw_id = #ctx bw_ctx at @s run function hanabi:name/resolve
execute as @a[tag=bw.player,scores={bw_seat=1}] if score @s bw_id = #ctx bw_ctx run data modify storage bullshit:dialog name1 set from storage hanabi:name resolved
execute as @a[tag=bw.player,scores={bw_seat=2}] if score @s bw_id = #ctx bw_ctx at @s run function hanabi:name/resolve
execute as @a[tag=bw.player,scores={bw_seat=2}] if score @s bw_id = #ctx bw_ctx run data modify storage bullshit:dialog name2 set from storage hanabi:name resolved
execute as @a[tag=bw.player,scores={bw_seat=3}] if score @s bw_id = #ctx bw_ctx at @s run function hanabi:name/resolve
execute as @a[tag=bw.player,scores={bw_seat=3}] if score @s bw_id = #ctx bw_ctx run data modify storage bullshit:dialog name3 set from storage hanabi:name resolved
execute as @a[tag=bw.player,scores={bw_seat=4}] if score @s bw_id = #ctx bw_ctx at @s run function hanabi:name/resolve
execute as @a[tag=bw.player,scores={bw_seat=4}] if score @s bw_id = #ctx bw_ctx run data modify storage bullshit:dialog name4 set from storage hanabi:name resolved
