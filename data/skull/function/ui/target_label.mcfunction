# 对话框不会解析selector组件，先沿用现有名字解析入口得到静态文本。
$data modify storage skull:ui target_name set value {text:"座位$(seat)"}
$execute as @a[tag=sk.player,scores={sk_id=$(table),sk_seat=$(seat)},limit=1] at @s run function hanabi:name/resolve
$execute if entity @a[tag=sk.player,scores={sk_id=$(table),sk_seat=$(seat)},limit=1] run data modify storage skull:ui target_name set from storage hanabi:name resolved
$data modify storage skull:ui dialog.actions append value {label:{text:"翻 ",extra:[]},action:{type:"minecraft:run_command",command:"trigger sk_action set $(value)"}}
data modify storage skull:ui dialog.actions[-1].label.extra append from storage skull:ui target_name
