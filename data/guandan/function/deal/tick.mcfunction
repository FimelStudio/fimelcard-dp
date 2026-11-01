scoreboard players remove @s gd_timer 1
execute if score @s gd_timer matches 1.. run return 0
execute if score @s gd_dealt matches 108.. run return run function guandan:tribute/begin
function guandan:system/context
function guandan:cards/constants
scoreboard players operation #deal_order gd_ctx = @s gd_dealorder
execute as @e[tag=gd.board] if score @s gd_order = #deal_order gd_ctx run scoreboard players operation #deal_seat gd_ctx = @s gd_seat
tag @e[tag=gd.dealing] remove gd.dealing
tag @e[tag=gd.cards,scores={gd_owner=-1},sort=random,limit=1] add gd.dealing
scoreboard players operation @e[tag=gd.dealing,limit=1] gd_owner = #deal_seat gd_ctx
execute as @e[tag=gd.board] if score @s gd_seat = #deal_seat gd_ctx run scoreboard players add @s gd_count 1
function guandan:deal/launch
scoreboard players add @s gd_dealt 1
scoreboard players add @s gd_dealorder 3
scoreboard players operation @s gd_dealorder %= #four gd_ctx
scoreboard players set @s gd_timer 2
execute if score @s gd_dealt matches 108 run scoreboard players set @s gd_timer 8
tag @e[tag=gd.dealing] remove gd.dealing
