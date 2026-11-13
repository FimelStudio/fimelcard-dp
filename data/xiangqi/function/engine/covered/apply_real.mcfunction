$scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=$(from)},limit=1] xq_hidden 0
$scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=$(from)},limit=1] xq_covered 0
$scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=$(to)},limit=1] xq_hidden = #placed xq_ctx
$scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=$(to)},limit=1] xq_covered 0
