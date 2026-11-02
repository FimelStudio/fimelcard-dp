function catan:input/context
execute unless entity @s[tag=ca.actor] run return 0
function catan:ui/begin
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=1..2},limit=1] run function catan:ui/button {"code":100,"label":"瞄准放置","color":"green"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=3,ca_anim=0},limit=1] run function catan:ui/button {"code":10,"label":"投骰子","color":"gold"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=4,ca_anim=0},limit=1] run function catan:ui/button {"code":102,"label":"建村庄 · 木砖羊粮","color":"white"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=4,ca_anim=0},limit=1] run function catan:ui/button {"code":103,"label":"修道路 · 木砖","color":"white"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=4,ca_anim=0},limit=1] run function catan:ui/button {"code":104,"label":"升级城市 · 2粮3矿","color":"white"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=4,ca_anim=0},limit=1] run function catan:ui/button {"code":23,"label":"买开发牌 · 羊粮矿","color":"white"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=4,ca_anim=0},limit=1] run function catan:ui/button {"code":210,"label":"银行与港口","color":"white"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=4,ca_anim=0},limit=1] run function catan:ui/button {"code":220,"label":"使用开发牌","color":"white"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=4,ca_anim=0},limit=1] run function catan:ui/button {"code":29,"label":"结束回合","color":"white"}
execute if entity @e[tag=ca.current,scores={ca_state=4,ca_anim=0},limit=1] run function catan:ui/button {"code":200,"label":"玩家交易","color":"aqua"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=3},limit=1] run function catan:ui/button {"code":220,"label":"使用开发牌","color":"aqua"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=6},limit=1] run function catan:ui/button {"code":100,"label":"选择强盗地块","color":"red"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=8},limit=1] run function catan:ui/button {"code":103,"label":"免费修路","color":"green"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=8},limit=1] run function catan:ui/button {"code":31,"label":"放弃剩余免费道路","color":"gray"}
execute if entity @e[tag=ca.current,scores={ca_state=5,ca_anim=0},limit=1] unless data storage catan:ui hand{discard_due:0} run function catan:ui/button {"code":230,"label":"选择弃牌","color":"red"}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=7,ca_anim=0},limit=1] if data entity @e[tag=ca.current,limit=1] data.catan{eligible:[1]} run function catan:ui/named_button {code:401,side:1}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=7,ca_anim=0},limit=1] if data entity @e[tag=ca.current,limit=1] data.catan{eligible:[2]} run function catan:ui/named_button {code:402,side:2}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=7,ca_anim=0},limit=1] if data entity @e[tag=ca.current,limit=1] data.catan{eligible:[3]} run function catan:ui/named_button {code:403,side:3}
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=7,ca_anim=0},limit=1] if data entity @e[tag=ca.current,limit=1] data.catan{eligible:[4]} run function catan:ui/named_button {code:404,side:4}
execute if data entity @e[tag=ca.current,limit=1] data.catan.trade run function catan:ui/button {"code":240,"label":"查看交易请求","color":"aqua"}
function catan:ui/button {"code":250,"label":"音乐开关","color":"gray"}
function catan:ui/button {"code":260,"label":"规则","color":"gray"}
function catan:ui/show with storage catan:ui
