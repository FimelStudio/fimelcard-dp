scoreboard players operation #actor it_ctx = @s it_seat
scoreboard players set #slot it_ctx 1
function ito:input/focus
execute unless entity @e[tag=it.focus,limit=1] run clear @s *[minecraft:custom_data~{ito:{tool:1b,kind:1,slot:1}}]
scoreboard players set #slot it_ctx 2
function ito:input/focus
execute unless entity @e[tag=it.focus,limit=1] run clear @s *[minecraft:custom_data~{ito:{tool:1b,kind:1,slot:2}}]
scoreboard players set #slot it_ctx 3
function ito:input/focus
execute unless entity @e[tag=it.focus,limit=1] run clear @s *[minecraft:custom_data~{ito:{tool:1b,kind:1,slot:3}}]
