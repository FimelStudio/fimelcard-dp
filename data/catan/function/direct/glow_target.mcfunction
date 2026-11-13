$execute if entity @e[tag=ca.current,scores={ca_state=7},limit=1] unless data entity @e[tag=ca.current,limit=1] data.catan{eligible:[$(target)]} run return 0
$effect give @a[tag=ca.audience,scores={ca_side=$(target)}] minecraft:glowing 1 0 true
