# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
data modify storage magical_athlete:ui title set value "胡闹运动会 · 秘密参赛阵容"
scoreboard players set #selected ma_ctx 0
execute store result score #selected ma_ctx run data get storage magical_athlete:ui hand.selected
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{n:2} if score #selected ma_ctx matches 2.. run return run function magical_athlete:ui/lineup_wait
execute unless data entity @e[tag=ma.current,limit=1] data.magical_athlete{n:2} if score #selected ma_ctx matches 1.. run return run function magical_athlete:ui/lineup_wait
data modify storage magical_athlete:ui detail.extra append value {text:"从尚未参赛的队员中选择，各队选好后一起公开。两人局每队选择两位，先选的角色先行动，此后本场顺序固定。\n\n",color:"yellow"}
execute if data storage magical_athlete:ui hand{hand:[0]} run function magical_athlete:ui/character {id:0,code:200}
execute if data storage magical_athlete:ui hand{hand:[1]} run function magical_athlete:ui/character {id:1,code:201}
execute if data storage magical_athlete:ui hand{hand:[2]} run function magical_athlete:ui/character {id:2,code:202}
execute if data storage magical_athlete:ui hand{hand:[3]} run function magical_athlete:ui/character {id:3,code:203}
execute if data storage magical_athlete:ui hand{hand:[4]} run function magical_athlete:ui/character {id:4,code:204}
execute if data storage magical_athlete:ui hand{hand:[5]} run function magical_athlete:ui/character {id:5,code:205}
execute if data storage magical_athlete:ui hand{hand:[6]} run function magical_athlete:ui/character {id:6,code:206}
execute if data storage magical_athlete:ui hand{hand:[7]} run function magical_athlete:ui/character {id:7,code:207}
execute if data storage magical_athlete:ui hand{hand:[8]} run function magical_athlete:ui/character {id:8,code:208}
execute if data storage magical_athlete:ui hand{hand:[9]} run function magical_athlete:ui/character {id:9,code:209}
execute if data storage magical_athlete:ui hand{hand:[10]} run function magical_athlete:ui/character {id:10,code:210}
execute if data storage magical_athlete:ui hand{hand:[11]} run function magical_athlete:ui/character {id:11,code:211}
execute if data storage magical_athlete:ui hand{hand:[12]} run function magical_athlete:ui/character {id:12,code:212}
execute if data storage magical_athlete:ui hand{hand:[13]} run function magical_athlete:ui/character {id:13,code:213}
execute if data storage magical_athlete:ui hand{hand:[14]} run function magical_athlete:ui/character {id:14,code:214}
execute if data storage magical_athlete:ui hand{hand:[15]} run function magical_athlete:ui/character {id:15,code:215}
execute if data storage magical_athlete:ui hand{hand:[16]} run function magical_athlete:ui/character {id:16,code:216}
execute if data storage magical_athlete:ui hand{hand:[17]} run function magical_athlete:ui/character {id:17,code:217}
execute if data storage magical_athlete:ui hand{hand:[18]} run function magical_athlete:ui/character {id:18,code:218}
execute if data storage magical_athlete:ui hand{hand:[19]} run function magical_athlete:ui/character {id:19,code:219}
execute if data storage magical_athlete:ui hand{hand:[20]} run function magical_athlete:ui/character {id:20,code:220}
execute if data storage magical_athlete:ui hand{hand:[21]} run function magical_athlete:ui/character {id:21,code:221}
execute if data storage magical_athlete:ui hand{hand:[22]} run function magical_athlete:ui/character {id:22,code:222}
execute if data storage magical_athlete:ui hand{hand:[23]} run function magical_athlete:ui/character {id:23,code:223}
execute if data storage magical_athlete:ui hand{hand:[24]} run function magical_athlete:ui/character {id:24,code:224}
execute if data storage magical_athlete:ui hand{hand:[25]} run function magical_athlete:ui/character {id:25,code:225}
execute if data storage magical_athlete:ui hand{hand:[26]} run function magical_athlete:ui/character {id:26,code:226}
execute if data storage magical_athlete:ui hand{hand:[27]} run function magical_athlete:ui/character {id:27,code:227}
execute if data storage magical_athlete:ui hand{hand:[28]} run function magical_athlete:ui/character {id:28,code:228}
execute if data storage magical_athlete:ui hand{hand:[29]} run function magical_athlete:ui/character {id:29,code:229}
execute if data storage magical_athlete:ui hand{hand:[30]} run function magical_athlete:ui/character {id:30,code:230}
execute if data storage magical_athlete:ui hand{hand:[31]} run function magical_athlete:ui/character {id:31,code:231}
execute if data storage magical_athlete:ui hand{hand:[32]} run function magical_athlete:ui/character {id:32,code:232}
execute if data storage magical_athlete:ui hand{hand:[33]} run function magical_athlete:ui/character {id:33,code:233}
execute if data storage magical_athlete:ui hand{hand:[34]} run function magical_athlete:ui/character {id:34,code:234}
execute if data storage magical_athlete:ui hand{hand:[35]} run function magical_athlete:ui/character {id:35,code:235}
