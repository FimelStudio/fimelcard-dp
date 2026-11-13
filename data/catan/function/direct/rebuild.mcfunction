clear @s *[minecraft:custom_data~{catan:{control:1b}}]
execute unless score @s ca_cepoch = @e[tag=ca.current,limit=1] ca_epoch run scoreboard players set @s ca_confirm -999
scoreboard players set @s ca_edit 0
execute unless entity @e[tag=ca.current,scores={ca_state=5},limit=1] run scoreboard players set @s ca_dphase 0
scoreboard players operation @s ca_depoch = @e[tag=ca.current,limit=1] ca_epoch
execute if entity @e[tag=ca.current,scores={ca_state=5},limit=1] run function catan:direct/discard_begin
function catan:direct/controls
