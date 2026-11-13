# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function magical_athlete:ui/begin
data modify storage magical_athlete:ui title set value "胡闹运动会 · 我的队员"
data modify storage magical_athlete:ui detail.extra append value {text:"尚未参赛：\n\n",color:"gold"}
execute if data storage magical_athlete:ui hand{hand:[0]} run function magical_athlete:ui/character {id:0,code:1}
execute if data storage magical_athlete:ui hand{hand:[1]} run function magical_athlete:ui/character {id:1,code:1}
execute if data storage magical_athlete:ui hand{hand:[2]} run function magical_athlete:ui/character {id:2,code:1}
execute if data storage magical_athlete:ui hand{hand:[3]} run function magical_athlete:ui/character {id:3,code:1}
execute if data storage magical_athlete:ui hand{hand:[4]} run function magical_athlete:ui/character {id:4,code:1}
execute if data storage magical_athlete:ui hand{hand:[5]} run function magical_athlete:ui/character {id:5,code:1}
execute if data storage magical_athlete:ui hand{hand:[6]} run function magical_athlete:ui/character {id:6,code:1}
execute if data storage magical_athlete:ui hand{hand:[7]} run function magical_athlete:ui/character {id:7,code:1}
execute if data storage magical_athlete:ui hand{hand:[8]} run function magical_athlete:ui/character {id:8,code:1}
execute if data storage magical_athlete:ui hand{hand:[9]} run function magical_athlete:ui/character {id:9,code:1}
execute if data storage magical_athlete:ui hand{hand:[10]} run function magical_athlete:ui/character {id:10,code:1}
execute if data storage magical_athlete:ui hand{hand:[11]} run function magical_athlete:ui/character {id:11,code:1}
execute if data storage magical_athlete:ui hand{hand:[12]} run function magical_athlete:ui/character {id:12,code:1}
execute if data storage magical_athlete:ui hand{hand:[13]} run function magical_athlete:ui/character {id:13,code:1}
execute if data storage magical_athlete:ui hand{hand:[14]} run function magical_athlete:ui/character {id:14,code:1}
execute if data storage magical_athlete:ui hand{hand:[15]} run function magical_athlete:ui/character {id:15,code:1}
execute if data storage magical_athlete:ui hand{hand:[16]} run function magical_athlete:ui/character {id:16,code:1}
execute if data storage magical_athlete:ui hand{hand:[17]} run function magical_athlete:ui/character {id:17,code:1}
execute if data storage magical_athlete:ui hand{hand:[18]} run function magical_athlete:ui/character {id:18,code:1}
execute if data storage magical_athlete:ui hand{hand:[19]} run function magical_athlete:ui/character {id:19,code:1}
execute if data storage magical_athlete:ui hand{hand:[20]} run function magical_athlete:ui/character {id:20,code:1}
execute if data storage magical_athlete:ui hand{hand:[21]} run function magical_athlete:ui/character {id:21,code:1}
execute if data storage magical_athlete:ui hand{hand:[22]} run function magical_athlete:ui/character {id:22,code:1}
execute if data storage magical_athlete:ui hand{hand:[23]} run function magical_athlete:ui/character {id:23,code:1}
execute if data storage magical_athlete:ui hand{hand:[24]} run function magical_athlete:ui/character {id:24,code:1}
execute if data storage magical_athlete:ui hand{hand:[25]} run function magical_athlete:ui/character {id:25,code:1}
execute if data storage magical_athlete:ui hand{hand:[26]} run function magical_athlete:ui/character {id:26,code:1}
execute if data storage magical_athlete:ui hand{hand:[27]} run function magical_athlete:ui/character {id:27,code:1}
execute if data storage magical_athlete:ui hand{hand:[28]} run function magical_athlete:ui/character {id:28,code:1}
execute if data storage magical_athlete:ui hand{hand:[29]} run function magical_athlete:ui/character {id:29,code:1}
execute if data storage magical_athlete:ui hand{hand:[30]} run function magical_athlete:ui/character {id:30,code:1}
execute if data storage magical_athlete:ui hand{hand:[31]} run function magical_athlete:ui/character {id:31,code:1}
execute if data storage magical_athlete:ui hand{hand:[32]} run function magical_athlete:ui/character {id:32,code:1}
execute if data storage magical_athlete:ui hand{hand:[33]} run function magical_athlete:ui/character {id:33,code:1}
execute if data storage magical_athlete:ui hand{hand:[34]} run function magical_athlete:ui/character {id:34,code:1}
execute if data storage magical_athlete:ui hand{hand:[35]} run function magical_athlete:ui/character {id:35,code:1}
data modify storage magical_athlete:ui detail.extra append value {text:"本场参赛阵容（仅本人）：\n\n",color:"gold"}
execute if data storage magical_athlete:ui hand{selected:[0]} run function magical_athlete:ui/character {id:0,code:1}
execute if data storage magical_athlete:ui hand{selected:[1]} run function magical_athlete:ui/character {id:1,code:1}
execute if data storage magical_athlete:ui hand{selected:[2]} run function magical_athlete:ui/character {id:2,code:1}
execute if data storage magical_athlete:ui hand{selected:[3]} run function magical_athlete:ui/character {id:3,code:1}
execute if data storage magical_athlete:ui hand{selected:[4]} run function magical_athlete:ui/character {id:4,code:1}
execute if data storage magical_athlete:ui hand{selected:[5]} run function magical_athlete:ui/character {id:5,code:1}
execute if data storage magical_athlete:ui hand{selected:[6]} run function magical_athlete:ui/character {id:6,code:1}
execute if data storage magical_athlete:ui hand{selected:[7]} run function magical_athlete:ui/character {id:7,code:1}
execute if data storage magical_athlete:ui hand{selected:[8]} run function magical_athlete:ui/character {id:8,code:1}
execute if data storage magical_athlete:ui hand{selected:[9]} run function magical_athlete:ui/character {id:9,code:1}
execute if data storage magical_athlete:ui hand{selected:[10]} run function magical_athlete:ui/character {id:10,code:1}
execute if data storage magical_athlete:ui hand{selected:[11]} run function magical_athlete:ui/character {id:11,code:1}
execute if data storage magical_athlete:ui hand{selected:[12]} run function magical_athlete:ui/character {id:12,code:1}
execute if data storage magical_athlete:ui hand{selected:[13]} run function magical_athlete:ui/character {id:13,code:1}
execute if data storage magical_athlete:ui hand{selected:[14]} run function magical_athlete:ui/character {id:14,code:1}
execute if data storage magical_athlete:ui hand{selected:[15]} run function magical_athlete:ui/character {id:15,code:1}
execute if data storage magical_athlete:ui hand{selected:[16]} run function magical_athlete:ui/character {id:16,code:1}
execute if data storage magical_athlete:ui hand{selected:[17]} run function magical_athlete:ui/character {id:17,code:1}
execute if data storage magical_athlete:ui hand{selected:[18]} run function magical_athlete:ui/character {id:18,code:1}
execute if data storage magical_athlete:ui hand{selected:[19]} run function magical_athlete:ui/character {id:19,code:1}
execute if data storage magical_athlete:ui hand{selected:[20]} run function magical_athlete:ui/character {id:20,code:1}
execute if data storage magical_athlete:ui hand{selected:[21]} run function magical_athlete:ui/character {id:21,code:1}
execute if data storage magical_athlete:ui hand{selected:[22]} run function magical_athlete:ui/character {id:22,code:1}
execute if data storage magical_athlete:ui hand{selected:[23]} run function magical_athlete:ui/character {id:23,code:1}
execute if data storage magical_athlete:ui hand{selected:[24]} run function magical_athlete:ui/character {id:24,code:1}
execute if data storage magical_athlete:ui hand{selected:[25]} run function magical_athlete:ui/character {id:25,code:1}
execute if data storage magical_athlete:ui hand{selected:[26]} run function magical_athlete:ui/character {id:26,code:1}
execute if data storage magical_athlete:ui hand{selected:[27]} run function magical_athlete:ui/character {id:27,code:1}
execute if data storage magical_athlete:ui hand{selected:[28]} run function magical_athlete:ui/character {id:28,code:1}
execute if data storage magical_athlete:ui hand{selected:[29]} run function magical_athlete:ui/character {id:29,code:1}
execute if data storage magical_athlete:ui hand{selected:[30]} run function magical_athlete:ui/character {id:30,code:1}
execute if data storage magical_athlete:ui hand{selected:[31]} run function magical_athlete:ui/character {id:31,code:1}
execute if data storage magical_athlete:ui hand{selected:[32]} run function magical_athlete:ui/character {id:32,code:1}
execute if data storage magical_athlete:ui hand{selected:[33]} run function magical_athlete:ui/character {id:33,code:1}
execute if data storage magical_athlete:ui hand{selected:[34]} run function magical_athlete:ui/character {id:34,code:1}
execute if data storage magical_athlete:ui hand{selected:[35]} run function magical_athlete:ui/character {id:35,code:1}
function magical_athlete:ui/button {"code":1,"label":"返回比赛菜单","color":"white"}
function magical_athlete:ui/show with storage magical_athlete:ui
