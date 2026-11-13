$data modify storage splendor:runtime actor_name set from entity @s data.splendor.p$(actor).name
data modify storage splendor:runtime event_label set value "完成操作"
$execute if predicate {type:"minecraft:int_value_check",value:$(code),test:1} run data modify storage splendor:runtime event_label set value "拿取宝石"
$execute if predicate {type:"minecraft:int_value_check",value:$(code),test:2} run data modify storage splendor:runtime event_label set value "预约开发卡"
$execute if predicate {type:"minecraft:int_value_check",value:$(code),test:3} run data modify storage splendor:runtime event_label set value "购买开发卡"
$execute if predicate {type:"minecraft:int_value_check",value:$(code),test:4} run data modify storage splendor:runtime event_label set value "退回超限筹码"
$execute if predicate {type:"minecraft:int_value_check",value:$(code),test:5} run data modify storage splendor:runtime event_label set value "获得贵族来访"
function splendor:game/log_show with storage splendor:runtime
