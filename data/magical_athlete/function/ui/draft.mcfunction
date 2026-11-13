# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute unless score @s ma_side = @e[tag=ma.current,limit=1] ma_turn run return 0
data modify storage magical_athlete:ui title set value "胡闹运动会 · 选择队员"
data modify storage magical_athlete:ui detail.extra append value {text:"点击选手加入自己的队伍。\n\n",color:"yellow"}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[0]} run function magical_athlete:ui/character {id:0,code:100}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[1]} run function magical_athlete:ui/character {id:1,code:101}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[2]} run function magical_athlete:ui/character {id:2,code:102}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[3]} run function magical_athlete:ui/character {id:3,code:103}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[4]} run function magical_athlete:ui/character {id:4,code:104}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[5]} run function magical_athlete:ui/character {id:5,code:105}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[6]} run function magical_athlete:ui/character {id:6,code:106}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[7]} run function magical_athlete:ui/character {id:7,code:107}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[8]} run function magical_athlete:ui/character {id:8,code:108}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[9]} run function magical_athlete:ui/character {id:9,code:109}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[10]} run function magical_athlete:ui/character {id:10,code:110}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[11]} run function magical_athlete:ui/character {id:11,code:111}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[12]} run function magical_athlete:ui/character {id:12,code:112}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[13]} run function magical_athlete:ui/character {id:13,code:113}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[14]} run function magical_athlete:ui/character {id:14,code:114}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[15]} run function magical_athlete:ui/character {id:15,code:115}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[16]} run function magical_athlete:ui/character {id:16,code:116}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[17]} run function magical_athlete:ui/character {id:17,code:117}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[18]} run function magical_athlete:ui/character {id:18,code:118}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[19]} run function magical_athlete:ui/character {id:19,code:119}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[20]} run function magical_athlete:ui/character {id:20,code:120}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[21]} run function magical_athlete:ui/character {id:21,code:121}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[22]} run function magical_athlete:ui/character {id:22,code:122}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[23]} run function magical_athlete:ui/character {id:23,code:123}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[24]} run function magical_athlete:ui/character {id:24,code:124}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[25]} run function magical_athlete:ui/character {id:25,code:125}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[26]} run function magical_athlete:ui/character {id:26,code:126}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[27]} run function magical_athlete:ui/character {id:27,code:127}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[28]} run function magical_athlete:ui/character {id:28,code:128}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[29]} run function magical_athlete:ui/character {id:29,code:129}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[30]} run function magical_athlete:ui/character {id:30,code:130}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[31]} run function magical_athlete:ui/character {id:31,code:131}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[32]} run function magical_athlete:ui/character {id:32,code:132}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[33]} run function magical_athlete:ui/character {id:33,code:133}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[34]} run function magical_athlete:ui/character {id:34,code:134}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{pool:[35]} run function magical_athlete:ui/character {id:35,code:135}
