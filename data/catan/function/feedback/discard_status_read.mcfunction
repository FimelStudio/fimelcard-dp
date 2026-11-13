$execute store result score #due ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.p$(side).discard_due
execute if score #due ca_ctx matches 0 run data modify storage fimel_title:io text.text set value "你无需弃牌：等待其他玩家完成"
execute if score #due ca_ctx matches 1.. run data modify storage fimel_title:io text.text set value "你需要弃牌：资源按Q加入，选满自动提交"
