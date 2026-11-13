data modify entity @s data.guandan.exchange set value []
execute as @e[tag=gd.board,scores={gd_return=2}] run function guandan:tribute/give_return
function guandan:deck/recount
function guandan:visual/tribute
function guandan:sound/tribute
scoreboard players set @e[tag=gd.board] gd_tribute 0
scoreboard players set @e[tag=gd.board] gd_return 0
scoreboard players set @s gd_anim 8
function guandan:game/first_turn
