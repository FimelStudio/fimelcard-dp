tellraw @s {text:"[UNO] 这个窗口已过期或当前操作不可用，请按Q重新打开手牌。",color:"yellow"}
scoreboard players set @s un_action 0
scoreboard players enable @s un_action
scoreboard players set @s un_colorpick -1
tag @a[tag=un.actor] remove un.actor
