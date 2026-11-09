scoreboard players set @s ca_edit 3
scoreboard players set @s ca_step 0
scoreboard players set @s ca_batch 1
scoreboard players set @s ca_pay -1
scoreboard players set @s ca_receive -1
function catan:direct/resource_controls
function catan:hud/notice {"text":{"text":"先选择支付资源，再选择换取资源；确认兑换按Q两次。","color":"yellow"}}
