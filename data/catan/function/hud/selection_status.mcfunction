execute if score @s ca_edit matches 3 if score @s ca_step matches 0 run data modify storage fimel_title:io text.text set value "银行兑换：资源按Q选择支付，再选换取种类；确认兑换按Q一次"
execute if score @s ca_edit matches 3 if score @s ca_step matches 1 run data modify storage fimel_title:io text.text set value "已选支付资源：对要换取的资源按Q，然后确认兑换按Q一次"
execute if score @s ca_edit matches 4 run data modify storage fimel_title:io text.text set value "垄断：资源按Q选择种类，确认垄断按Q一次"
execute if score @s ca_edit matches 5 run data modify storage fimel_title:io text.text set value "丰收：资源按Q选择两张，确认丰收按Q一次"
