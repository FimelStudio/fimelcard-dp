# 控制器执行；窗口只交给本次点击者，触发指令无需OP。
scoreboard players add #pick_nonce ct_ctx 100
execute if score #pick_nonce ct_ctx matches 2000000000.. run scoreboard players set #pick_nonce ct_ctx 10
scoreboard players operation @a[tag=ct.switch_actor,limit=1] ct_pick_table = @s ct_id
scoreboard players operation @a[tag=ct.switch_actor,limit=1] ct_pick_base = #pick_nonce ct_ctx
scoreboard players set @a[tag=ct.switch_actor,limit=1] ct_game_pick 0
scoreboard players enable @a[tag=ct.switch_actor,limit=1] ct_game_pick
scoreboard players operation #pick_button ct_ctx = #pick_nonce ct_ctx
scoreboard players add #pick_button ct_ctx 1
execute store result storage cardtable:picker p1 int 1 run scoreboard players get #pick_button ct_ctx
scoreboard players add #pick_button ct_ctx 1
execute store result storage cardtable:picker p2 int 1 run scoreboard players get #pick_button ct_ctx
scoreboard players add #pick_button ct_ctx 1
execute store result storage cardtable:picker p3 int 1 run scoreboard players get #pick_button ct_ctx
scoreboard players add #pick_button ct_ctx 1
execute store result storage cardtable:picker p4 int 1 run scoreboard players get #pick_button ct_ctx
scoreboard players add #pick_button ct_ctx 1
execute store result storage cardtable:picker p5 int 1 run scoreboard players get #pick_button ct_ctx
scoreboard players add #pick_button ct_ctx 1
execute store result storage cardtable:picker p6 int 1 run scoreboard players get #pick_button ct_ctx
scoreboard players add #pick_button ct_ctx 1
execute store result storage cardtable:picker p7 int 1 run scoreboard players get #pick_button ct_ctx
scoreboard players add #pick_button ct_ctx 1
execute store result storage cardtable:picker p8 int 1 run scoreboard players get #pick_button ct_ctx
scoreboard players add #pick_button ct_ctx 1
execute store result storage cardtable:picker p9 int 1 run scoreboard players get #pick_button ct_ctx
scoreboard players add #pick_button ct_ctx 1
execute store result storage cardtable:picker p10 int 1 run scoreboard players get #pick_button ct_ctx
scoreboard players add #pick_button ct_ctx 1
execute store result storage cardtable:picker p11 int 1 run scoreboard players get #pick_button ct_ctx
scoreboard players add #pick_button ct_ctx 1
execute store result storage cardtable:picker p12 int 1 run scoreboard players get #pick_button ct_ctx
scoreboard players add #pick_button ct_ctx 1
execute store result storage cardtable:picker p13 int 1 run scoreboard players get #pick_button ct_ctx
scoreboard players add #pick_button ct_ctx 1
execute store result storage cardtable:picker p14 int 1 run scoreboard players get #pick_button ct_ctx
scoreboard players add #pick_button ct_ctx 1
execute store result storage cardtable:picker p15 int 1 run scoreboard players get #pick_button ct_ctx
execute if score @s ct_capacity matches 8 run return run function cardtable:menu/picker/show8 with storage cardtable:picker
function cardtable:menu/picker/show4 with storage cardtable:picker
