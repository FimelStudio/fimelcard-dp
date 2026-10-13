# 当前执行者是观察者。屏幕左侧从上到下只显示最多另外四名参与者及其真实手牌。
execute unless score @s hb_panel matches 1.. run function hanabi:title/activate_player
scoreboard players operation #title_viewer hb_ctx = @s hb_seat
scoreboard players set #title_row hb_ctx 0

# BetterTitle接口使用公共缓冲区；每次完整构建前必须显式清空。
data modify storage fimel_title:io panel_buffer set value []
data modify storage fimel_title:io text_buffer set value []
data modify storage fimel_title:io neg_text_buffer set value []

function hanabi:title/append_owner {seat:1}
function hanabi:title/append_owner {seat:2}
function hanabi:title/append_owner {seat:3}
function hanabi:title/append_owner {seat:4}
function hanabi:title/append_owner {seat:5}
function hanabi:title/append_owner {seat:6}
function hanabi:title/append_owner {seat:7}
function hanabi:title/append_owner {seat:8}

scoreboard players operation panel_id fbt_io = @s hb_panel
function fimel_title:replace_panel
scoreboard players operation @s fbt_panel = @s hb_panel
tag @a[tag=hb.title_owner] remove hb.title_owner
