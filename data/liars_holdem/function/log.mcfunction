# 调用示例：function liars_holdem:log {text:"测试消息"}
# 只要有玩家自行添加ct.debug标签，就向聊天和服务端控制台输出
$execute if entity @a[tag=ct.debug] as @a[tag=ct.debug] run tellraw @s [{text:"[赌命德州扑克 Debug] $(text)"}]