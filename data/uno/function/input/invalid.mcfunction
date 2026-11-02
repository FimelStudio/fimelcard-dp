tellraw @s {text:"[UNO] 窗口已过期，请使用当前回合的操作入口。",color:"yellow"}
scoreboard players set @s un_action 0
scoreboard players enable @s un_action
scoreboard players set @s un_colorpick -1
tag @a[tag=un.actor] remove un.actor
