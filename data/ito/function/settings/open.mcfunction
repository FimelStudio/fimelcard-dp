execute unless score @s ct_state matches 0 run return 0
execute unless score @s it_input matches 0..1 run scoreboard players set @s it_input 0
scoreboard players add #settings_serial it_ctx 1
execute if score #settings_serial it_ctx matches 10000001.. run scoreboard players set #settings_serial it_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,limit=1] it_setnonce = #settings_serial it_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] it_settable = @s ct_id
scoreboard players set @a[tag=ct.settings_actor,limit=1] it_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] it_settings
execute store result storage ito:settings nonce int 1 run scoreboard players get #settings_serial it_ctx
data modify storage ito:settings input set value "$(input)"
data modify storage ito:settings book set value true
data modify storage ito:settings form set value false
execute if score @s it_input matches 1 run data modify storage ito:settings book set value false
execute if score @s it_input matches 1 run data modify storage ito:settings form set value true
function ito:settings/show with storage ito:settings
