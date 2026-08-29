# 调用示例：function abraca:log {text:"测试消息"}
# 只有自行添加 ct.debug 标签的玩家会收到出包魔法师调试日志。
$execute if entity @a[tag=ct.debug] as @a[tag=ct.debug] run tellraw @s [{text:"[出包魔法师 Debug] $(text)",color:"dark_gray"}]
