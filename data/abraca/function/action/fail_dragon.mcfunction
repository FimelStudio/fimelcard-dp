execute store result score #roll ab_ctx run random value 1..3
scoreboard players operation @a[tag=ab.actor,limit=1] ab_hp -= #roll ab_ctx
scoreboard players operation #ctx ab_ctx = @s ab_id
execute store result storage abraca:debug id int 1 run scoreboard players get @s ab_id
execute store result storage abraca:debug seat int 1 run scoreboard players get @a[tag=ab.actor,limit=1] ab_seat
execute store result storage abraca:debug damage int 1 run scoreboard players get #roll ab_ctx
function abraca:debug/log_fail_dragon with storage abraca:debug
tag @a[tag=ab.audience] remove ab.audience
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx run tag @s add ab.audience
tellraw @a[tag=ab.audience] [{text:'[古代巨龙] ',color:'red'},{selector:'@a[tag=ab.actor,limit=1]',color:'gold'},{text:'召唤失败！骰子为 ',color:'gray'},{score:{name:'#roll',objective:'ab_ctx'},color:'gold'},{text:'；该玩家失去等量生命。',color:'red'}]
function abraca:sound/fail
tag @a[tag=ab.audience] remove ab.audience
function abraca:hud/update
# 失败造成的击倒同样必须立即由控制器结算。
function abraca:turn/end
