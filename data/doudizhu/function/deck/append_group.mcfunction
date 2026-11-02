$data modify storage doudizhu:deck queue append from storage doudizhu:deck groups[$(index)].cards[]
$data remove storage doudizhu:deck groups[$(index)]
