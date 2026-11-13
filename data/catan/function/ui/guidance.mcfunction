# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute store result storage catan:ui side int 1 run scoreboard players get @s ca_side
data modify storage catan:ui guide_due set value 0
data modify storage catan:ui guide_free set value 0
function catan:ui/guidance_private with storage catan:ui
data modify storage catan:ui guidance set value {text:"等待当前行动者；第9格按 Q 查看资源与菜单。",color:"gray"}
data modify storage catan:ui hud_guidance set value {text:"等待行动者 · 第9格 Q 菜单",color:"gray"}
scoreboard players set #guide_step ca_ctx 0
scoreboard players set #guide_n ca_ctx 4
execute store result score #guide_step ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.setup_step
execute store result score #guide_n ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.n
execute if entity @e[tag=ca.current,scores={ca_state=1..2},limit=1] if score #guide_step ca_ctx < #guide_n ca_ctx run data modify storage catan:ui phase set value "初始布置 · 第一轮（顺序）"
execute if entity @e[tag=ca.current,scores={ca_state=1..2},limit=1] if score #guide_step ca_ctx >= #guide_n ca_ctx run data modify storage catan:ui phase set value "初始布置 · 第二轮（逆序）"
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=1},limit=1] run data modify storage catan:ui guidance set value {"text":"轮到你：第1格按 Q 瞄准交点，确认免费放村庄。","color":"aqua"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=2},limit=1] run data modify storage catan:ui guidance set value {"text":"轮到你：第1格按 Q 瞄准刚放村庄旁的边，确认免费放道路。","color":"aqua"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=3},limit=1] run data modify storage catan:ui guidance set value {"text":"轮到你：第9格按 Q 打开菜单，点击「投骰子」。","color":"aqua"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=4},limit=1] run data modify storage catan:ui guidance set value {"text":"轮到你：第9格 Q 选择建造／交易；完成后点「结束回合」。","color":"aqua"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=6},limit=1] run data modify storage catan:ui guidance set value {"text":"轮到你：第1格按 Q 瞄准另一块六边形地块，确认移动强盗。","color":"aqua"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=7},limit=1] run data modify storage catan:ui guidance set value {"text":"轮到你：第9格 Q 打开菜单，点击可偷取玩家的姓名。","color":"aqua"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=8},limit=1] run data modify storage catan:ui guidance set value {"text":"轮到你：第1格 Q 瞄准边免费修路；也可在菜单放弃剩余道路。","color":"aqua"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=1},limit=1] run data modify storage catan:ui hud_guidance set value {"text":"放村庄 · 第1格 Q 选交点","color":"aqua"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=2},limit=1] run data modify storage catan:ui hud_guidance set value {"text":"放相邻道路 · 第1格 Q 选边","color":"aqua"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=3},limit=1] run data modify storage catan:ui hud_guidance set value {"text":"请投骰 · 第9格 Q 菜单","color":"aqua"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=4},limit=1] run data modify storage catan:ui hud_guidance set value {"text":"建造／交易 · 第9格 Q 菜单","color":"aqua"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=6},limit=1] run data modify storage catan:ui hud_guidance set value {"text":"移动强盗 · 第1格 Q 选地块","color":"aqua"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=7},limit=1] run data modify storage catan:ui hud_guidance set value {"text":"选偷取对象 · 第9格 Q 菜单","color":"aqua"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=8},limit=1] run data modify storage catan:ui hud_guidance set value {"text":"免费修路 · 第1格 Q 选边","color":"aqua"}
execute if entity @e[tag=ca.current,scores={ca_state=4},limit=1] unless score @s ca_side = @e[tag=ca.current,limit=1] ca_turn run data modify storage catan:ui guidance set value {text:"等待当前行动者；第9格 Q 可与其交易，或回应自己的报价。",color:"gray"}
execute if entity @e[tag=ca.current,scores={ca_state=5},limit=1] run data modify storage catan:ui guidance set value {text:"你无需再弃牌；等待所有须弃牌的玩家完成，随后移动强盗。",color:"gray"}
execute if entity @e[tag=ca.current,scores={ca_state=5},limit=1] run data modify storage catan:ui hud_guidance set value {text:"等待其他玩家弃牌",color:"gray"}
execute if entity @e[tag=ca.current,scores={ca_state=5},limit=1] unless data storage catan:ui {guide_due:0} run function catan:ui/guidance_discard with storage catan:ui
execute if entity @e[tag=ca.current,scores={ca_state=8},limit=1] if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn run function catan:ui/guidance_roads with storage catan:ui
execute if data entity @e[tag=ca.current,limit=1] data.catan.trade run function catan:ui/guidance_trade with entity @e[tag=ca.current,limit=1] data.catan.trade
execute if entity @e[tag=ca.current,scores={ca_state=10},limit=1] run data modify storage catan:ui guidance set value {text:"正在计算最长道路，请稍候；无需重复点击。",color:"gray"}
execute if entity @e[tag=ca.current,scores={ca_state=11},limit=1] run data modify storage catan:ui guidance set value {text:"对局已结束，稍后返回大厅并保留公开棋面。",color:"gold"}
execute if entity @e[tag=ca.current,scores={ca_anim=1..},limit=1] run data modify storage catan:ui guidance set value {text:"动画进行中，请稍候；结果已经保存，无需重复操作。",color:"gray"}
execute if entity @e[tag=ca.current,scores={ca_vtimer=1..},limit=1] run data modify storage catan:ui guidance set value {text:"动画进行中，请稍候；结果已经保存，无需重复操作。",color:"gray"}
execute if entity @e[tag=ca.current,scores={ct_paused=1},limit=1] run data modify storage catan:ui guidance set value {text:"对局暂停：等待原参与者重连，或使用牌桌结束投票。",color:"yellow"}
execute if entity @e[tag=ca.current,scores={ca_state=10},limit=1] run data modify storage catan:ui hud_guidance set value {"text":"计算最长道路，请稍候","color":"gray"}
execute if entity @e[tag=ca.current,scores={ca_state=11},limit=1] run data modify storage catan:ui hud_guidance set value {"text":"对局结束，稍后返回大厅","color":"gray"}
execute if entity @e[tag=ca.current,scores={ca_anim=1..},limit=1] run data modify storage catan:ui hud_guidance set value {"text":"动画中，请稍候","color":"gray"}
execute if entity @e[tag=ca.current,scores={ca_vtimer=1..},limit=1] run data modify storage catan:ui hud_guidance set value {"text":"动画中，请稍候","color":"gray"}
execute if entity @e[tag=ca.current,scores={ct_paused=1},limit=1] run data modify storage catan:ui hud_guidance set value {"text":"已暂停，等待原玩家重连","color":"gray"}
