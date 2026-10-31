scoreboard players operation #ui_top_idx un_ctx = @e[tag=un.current,limit=1] un_top
scoreboard players set #ui_top_type un_ctx -1
execute as @e[type=minecraft:marker,tag=un.card] if score @s ct_id = #ui_table un_ctx if score @s un_idx = #ui_top_idx un_ctx run scoreboard players operation #ui_top_type un_ctx = @s un_card
data modify storage uno:ui top set value {text:"尚未翻开",color:"gray"}
function uno:ui/top
data modify storage uno:ui phase set value {text:"发牌中，请稍候。",color:"gray"}
execute if entity @e[tag=un.current,scores={un_state=2},limit=1] run data modify storage uno:ui phase set value {text:"等待其他玩家出牌。",color:"gray"}
execute if entity @e[tag=un.current,scores={un_state=2},limit=1] if score @s un_seat = @e[tag=un.current,limit=1] un_turn run data modify storage uno:ui phase set value {text:"轮到你：选一张牌出牌，或主动摸一张。",color:"green"}
execute if entity @e[tag=un.current,scores={un_state=2,un_drew=1},limit=1] if score @s un_seat = @e[tag=un.current,limit=1] un_turn run data modify storage uno:ui phase set value {text:"本回合已摸牌：只能打出刚摸到的牌，或选择不出。",color:"yellow"}
execute if entity @e[tag=un.current,scores={un_state=3},limit=1] run data modify storage uno:ui phase set value {text:"抓UNO阶段：漏喊者可补喊，其他玩家可抓UNO。",color:"yellow"}
execute if entity @e[tag=un.current,scores={un_state=4},limit=1] run data modify storage uno:ui phase set value {text:"等待受罚玩家接受或质疑变色+4。",color:"yellow"}
execute if entity @e[tag=un.current,scores={un_state=5..},limit=1] run data modify storage uno:ui phase set value {text:"本轮已结束，正在结算。",color:"gold"}
data modify storage uno:ui color set value {text:"红",color:"red"}
execute if entity @e[tag=un.current,scores={un_color=1},limit=1] run data modify storage uno:ui color set value {text:"黄",color:"yellow"}
execute if entity @e[tag=un.current,scores={un_color=2},limit=1] run data modify storage uno:ui color set value {text:"绿",color:"green"}
execute if entity @e[tag=un.current,scores={un_color=3},limit=1] run data modify storage uno:ui color set value {text:"蓝",color:"blue"}
data modify storage uno:ui direction set value "顺时针"
execute if entity @e[tag=un.current,scores={un_dir=-1},limit=1] run data modify storage uno:ui direction set value "逆时针"
