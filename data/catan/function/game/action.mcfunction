# 入口只接受绑定本桌、未失效的 UI/落点；引擎是最终裁判。
function catan:system/context
execute unless entity @a[tag=ca.actor,tag=ca.audience,limit=1] run return 0
function catan:game/online
execute unless score #live ca_ctx = #required ca_ctx run return 0
execute unless score @s ca_anim matches 0 run return run function catan:game/busy
execute if score @s ca_vtimer matches 1.. run return run function catan:game/busy
function catan:engine/action
execute unless score #ok ca_ctx matches 1 run return run function catan:game/illegal
function catan:game/after_action
