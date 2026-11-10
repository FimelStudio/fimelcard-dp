function catan:direct/main_guard
execute unless score #direct_ready ca_ctx matches 1 run return 0
scoreboard players set @s ca_edit 3
scoreboard players set @s ca_step 0
scoreboard players set @s ca_batch 1
scoreboard players set @s ca_pay -1
scoreboard players set @s ca_receive -1
function catan:direct/resource_controls
function catan:hud/notice {"text":{"text":"先选择支付资源，再选择换取资源；确认兑换按Q一次。","color":"yellow"}}
