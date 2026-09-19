# 取出后删除候选项，因此本队和跨队均不会重复。
$data modify storage decrypto:words selected append from storage decrypto:words remaining[$(index)]
$data remove storage decrypto:words remaining[$(index)]
