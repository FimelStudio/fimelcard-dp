execute if score @s sp_finish matches 1.. run return 0
scoreboard players set @s sp_finish 100
function splendor:sound/result
tellraw @a[tag=sp.audience] {text:"[璀璨宝石] 本轮结束，按声望优先、已购开发卡更少者优先结算：",color:"gold"}
data modify storage cardtable:result names set value {text:"",extra:[]}
execute if data entity @s data.splendor{winners:[1]} run function splendor:game/announce {side:1}
execute if data entity @s data.splendor{winners:[2]} run function splendor:game/announce {side:2}
execute if data entity @s data.splendor{winners:[3]} run function splendor:game/announce {side:3}
execute if data entity @s data.splendor{winners:[4]} run function splendor:game/announce {side:4}
function cardtable:game/result/title {audience:"@a[tag=sp.audience]",title:{text:"最终胜利者",color:"gold",bold:true},subtitle:{nbt:"names",storage:"cardtable:result",interpret:true}}
