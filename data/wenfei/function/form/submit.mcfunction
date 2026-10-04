# 用整个复合标签序列化传递文字，避免直接拼接玩家输入。
$data modify storage wenfei:form incoming set value $(p)
function wenfei:form/receive
