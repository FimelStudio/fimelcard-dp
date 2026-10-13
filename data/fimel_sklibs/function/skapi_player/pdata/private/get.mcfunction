# 先清除输出，确保目标玩家或字段不存在时不会读到上一轮调用的残留值。

$data remove $(output)
$execute if data $(base_path).players[{uuid:$(uuid)}].data.$(path) run data modify $(output) set from $(base_path).players[{uuid:$(uuid)}].data.$(path)
