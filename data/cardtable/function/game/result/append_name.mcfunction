# 将并列胜者的名字组合成一个副标题。path 由结算函数指定。
execute if data storage cardtable:result names.extra[0] run data modify storage cardtable:result names.extra append value {text:"、"}
$data modify storage cardtable:result names.extra append from entity @s $(path)
