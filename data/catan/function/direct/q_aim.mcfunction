$scoreboard players set @s ca_mode $(build)
tag @s add ca.q_aim
function catan:input/aim
tag @s remove ca.q_aim
