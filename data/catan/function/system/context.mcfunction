scoreboard players operation #table ca_ctx = @s ct_id
tag @e[tag=ca.current] remove ca.current
tag @a[tag=ca.audience] remove ca.audience
tag @s add ca.current
execute as @a[tag=ca.player,tag=ct.player] if score @s ca_table = #table ca_ctx if score @s ct_id = #table ca_ctx run tag @s add ca.audience
