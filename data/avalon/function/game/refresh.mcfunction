scoreboard players set #manual_ui av_ctx 0
scoreboard players add @s av_epoch 1
function avalon:context
clear @a[tag=av.audience] *[minecraft:custom_data~{avalon:{head:1b}}]
function avalon:player/heads
execute if score @s av_state matches 1 if score #head_blocked av_ctx matches 1 as @a[tag=av.audience] if score @s av_seat = #leader av_ctx run tellraw @s {text:"背包已满，请为快捷栏前面的选人头颅腾出空间。",color:"yellow"}
execute if score @s av_state matches 1 run tellraw @a[tag=av.audience] {text:"队长：对玩家头颅按Q选中／取消；选好后对第9格身份卡按Q确认队伍。",color:"yellow"}
function avalon:game/announce
dialog clear @a[tag=av.audience]
function avalon:hud/update
tag @e[tag=av.current] remove av.current
tag @s add av.current
execute as @a[tag=av.audience] run function avalon:dialog/open
tag @s remove av.current
