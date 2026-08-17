# 调用示例：function fast_card:log {text:"测试消息"}
# Fast Card日志由自行添加ct.debug标签的玩家全局开启
$execute if entity @a[tag=ct.debug] as @a[tag=ct.debug] run tellraw @s [{text:"[Fast Card Debug] $(text)"}]