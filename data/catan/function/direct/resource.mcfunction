$scoreboard players set #resource ca_ctx $(id)
execute if entity @e[tag=ca.current,scores={ca_state=5},limit=1] run return run function catan:direct/discard_add
execute if score @s ca_edit matches 4 run scoreboard players operation @s ca_a = #resource ca_ctx
execute if score @s ca_edit matches 4 run return run function catan:direct/selected_resource
execute if score @s ca_edit matches 5 run return run function catan:direct/plenty_select
execute unless score @s ca_edit matches 3 run function catan:direct/bank_begin
execute if score @s ca_step matches 0 run return run function catan:direct/pay_select
scoreboard players operation @s ca_receive = #resource ca_ctx
scoreboard players set @s ca_step 0
function catan:direct/bank_quote
