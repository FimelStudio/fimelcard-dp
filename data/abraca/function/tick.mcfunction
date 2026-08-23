# Trigger在客户端提交后可能被锁定；当前回合内持续启用，确保每次都能选择咒语。
execute as @a[tag=ab.turn] run scoreboard players enable @s ab_action
execute as @a[tag=ab.turn,scores={ab_action=1..}] at @s run function abraca:action/handle
