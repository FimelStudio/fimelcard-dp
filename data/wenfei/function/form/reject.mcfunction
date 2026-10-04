tellraw @s {text:"[问非所答] 提交失败：窗口已过期，或答案不在1至64个字符范围内。请按Q重新打开填写。",color:"red"}
tag @e[tag=wq.form_controller] remove wq.form_controller
data remove storage wenfei:form incoming
