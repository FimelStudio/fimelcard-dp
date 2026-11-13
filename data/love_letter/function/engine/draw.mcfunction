# 普通牌库顶为 [0]；备用牌永远不在此函数自动补入。
scoreboard players set #draw ll_ctx -1
execute unless data entity @e[tag=ll.current,limit=1] data.love_letter.deck[0] run return 0
execute store result score #draw ll_ctx run data get entity @e[tag=ll.current,limit=1] data.love_letter.deck[0]
data remove entity @e[tag=ll.current,limit=1] data.love_letter.deck[0]
