clear @s *[minecraft:custom_data~{love_letter:{head:1b}}]
scoreboard players set @s ll_hintwait 40
title @s actionbar {text:"选人操作已过期，请重新 Q 出手牌。",color:"yellow"}
function love_letter:input/give
