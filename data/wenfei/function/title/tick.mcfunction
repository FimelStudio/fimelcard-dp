scoreboard players add @s wq_ptick 1
execute unless score @s wq_ptick matches 100.. run return 0
scoreboard players set @s wq_ptick 0
scoreboard players add @s wq_page 1
function wenfei:title/render
