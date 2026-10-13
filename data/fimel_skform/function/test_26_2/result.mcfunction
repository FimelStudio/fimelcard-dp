# 提交后保存并输出本次表单数据。

$data modify storage fimel_skform:runtime temp.test_26_2_result set value $(storage)
tellraw @s [{text:"[SK Form 26.2 测试] ",color:"aqua"},{text:"提交成功，返回数据：",color:"green"},{nbt:"temp.test_26_2_result",storage:"fimel_skform:runtime",color:"white"}]
