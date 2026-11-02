tellraw @a[tag=ca.actor] {"text": "[卡坦岛] 该操作目前不合法：请检查轮次、位置、费用或是否仍有棋子。", "color": "red"}
function catan:sound/illegal
execute as @a[tag=ca.actor] run function catan:ui/open
