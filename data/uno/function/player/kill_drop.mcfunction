# 实体关系用于补充刚刚丢出、尚未来得及处理的 Q 操作物。
scoreboard players set #u_killdrop un_ctx 0
execute if score @s ct_id = #table un_ctx run scoreboard players set #u_killdrop un_ctx 1
execute on origin if entity @s[tag=un.audience] run scoreboard players set #u_killdrop un_ctx 1
execute if score #u_killdrop un_ctx matches 1 run kill @s
