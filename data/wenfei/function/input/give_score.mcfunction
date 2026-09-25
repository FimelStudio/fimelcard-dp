$data modify storage wenfei:io score_item.points set value $(points)
$data modify storage wenfei:io score_item.item set value "$(item)"
$data modify storage wenfei:io score_item.color set value "$(color)"
execute as @a[tag=wq.actor,limit=1] run function wenfei:input/give_score_item with storage wenfei:io score_item
