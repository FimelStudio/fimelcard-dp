execute unless score @s ab_panel matches 1.. run function abraca:title/activate_player
scoreboard players operation #ctx ab_ctx = @s ab_id
scoreboard players operation #viewer ab_ctx = @s ab_seat
scoreboard players set #row ab_ctx 0
data modify storage fimel_title:io panel_buffer set value []
data modify storage fimel_title:io text_buffer set value []
data modify storage fimel_title:io neg_text_buffer set value []
function abraca:title/append_owner {seat:1}
function abraca:title/append_owner {seat:2}
function abraca:title/append_owner {seat:3}
function abraca:title/append_owner {seat:4}
function abraca:title/append_owner {seat:5}
function abraca:title/append_owner {seat:6}
function abraca:title/append_owner {seat:7}
function abraca:title/append_owner {seat:8}
function abraca:title/append_self_count
scoreboard players operation panel_id fbt_io = @s ab_panel
function fimel_title:replace_panel
scoreboard players operation @s fbt_panel = @s ab_panel
