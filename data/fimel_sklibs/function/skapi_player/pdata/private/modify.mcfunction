# 每个 base_path 内维护独立的玩家记录表，使用原生 UUID 整数数组作为稳定主键。

$execute unless data $(base_path) run data modify $(base_path) set value {}
$execute unless data $(base_path).players run data modify $(base_path).players set value []
$execute unless data $(base_path).players[{uuid:$(uuid)}] run data modify $(base_path).players append value {uuid:$(uuid),data:{}}
$data modify $(base_path).players[{uuid:$(uuid)}].data.$(path) set value $(value)
