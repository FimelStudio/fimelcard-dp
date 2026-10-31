execute unless entity @s[tag=un.controller] run return fail
function uno:system/context
scoreboard players set #u_best un_ctx -1
execute as @e[tag=un.audience] if score @s un_score > #u_best un_ctx run scoreboard players operation #u_best un_ctx = @s un_score
tellraw @a[tag=un.audience] [{text:'[UNO] 本场结束，最高总分 ',color:'gold'},{score:{name:'#u_best',objective:'un_ctx'},color:'yellow'},{text:'。'}]
scoreboard players operation #u_winner un_ctx = @s un_winner
execute if score @s un_mode matches 0 as @a[tag=un.audience] if score @s un_seat = #u_winner un_ctx run tellraw @a[tag=un.audience] [{text:'本场胜者：',color:'gold'},{selector:'@s',color:'aqua'}]
execute unless score @s un_mode matches 0 as @a[tag=un.audience] if score @s un_score = #u_best un_ctx run tellraw @a[tag=un.audience] [{text:'本场胜者：',color:'gold'},{selector:'@s',color:'aqua'}]
execute as @a[tag=un.audience] run tellraw @a[tag=un.audience] [{selector:'@s',color:'aqua'},{text:'：'},{score:{name:'@s',objective:'un_score'},color:'yellow'},{text:' 分'}]
function uno:log {text:"完成整场结算，返回大厅"}
function uno:game/cleanup
