# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function splendor:input/context
execute unless entity @s[tag=sp.actor] run return 0
scoreboard players set @s sp_panel 0
function splendor:ui/begin
function splendor:ui/button {"code":2,"label":"查看开发卡","color":"aqua"}
function splendor:ui/button {"code":5,"label":"我的预约牌","color":"aqua"}
function splendor:ui/button {"code":6,"label":"玩家资产","color":"aqua"}
function splendor:ui/button {"code":7,"label":"查看贵族","color":"yellow"}
execute if score @s sp_side = @e[tag=sp.current,limit=1] sp_turn if entity @e[tag=sp.current,scores={sp_state=1,sp_anim=0},limit=1] run function splendor:ui/button {"code":3,"label":"拿取宝石","color":"green"}
execute if score @s sp_side = @e[tag=sp.current,limit=1] sp_turn if entity @e[tag=sp.current,scores={sp_state=1,sp_anim=0},limit=1] run function splendor:ui/button {"code":4,"label":"盲抽预约","color":"gold"}
execute if score @s sp_side = @e[tag=sp.current,limit=1] sp_turn if entity @e[tag=sp.current,scores={sp_state=2,sp_anim=0},limit=1] run function splendor:ui/button {"code":20,"label":"退回超限筹码","color":"red"}
execute if score @s sp_side = @e[tag=sp.current,limit=1] sp_turn if entity @e[tag=sp.current,scores={sp_state=3,sp_anim=0},limit=1] run function splendor:ui/button {"code":7,"label":"选择来访贵族","color":"green"}
function splendor:ui/button {"code":8,"label":"游戏规则","color":"gray"}
function splendor:ui/button {"code":9,"label":"音乐开关","color":"gray"}
function splendor:ui/show with storage splendor:ui
