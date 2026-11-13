scoreboard players set @s ca_confirm -999
scoreboard players set @s ca_edit 0
scoreboard players set @s ca_step 0
scoreboard players set @s ca_dphase 0
function catan:direct/discard_reset
execute if entity @e[tag=ca.current,scores={ca_state=5},limit=1] run function catan:direct/discard_begin
execute as @e[tag=ca.current,limit=1] run function catan:visual/clear_selection
function catan:direct/controls
function catan:hud/notice {"text":{"text":"已取消当前选择。","color":"yellow"}}
