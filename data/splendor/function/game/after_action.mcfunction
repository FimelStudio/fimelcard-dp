function splendor:game/sync
scoreboard players reset @a[tag=sp.audience] sp_nonce
execute as @a[tag=sp.audience] run dialog clear @s
function splendor:game/log_event with entity @s data.splendor.last
function splendor:visual/refresh
function splendor:visual/animate
scoreboard players set @s sp_anim 12
execute if data entity @s data.splendor.last{code:1} run function splendor:sound/take
execute if data entity @s data.splendor.last{code:2} run function splendor:sound/reserve
execute if data entity @s data.splendor.last{code:3} run function splendor:sound/buy
execute if data entity @s data.splendor.last{code:4} run function splendor:sound/return
execute if data entity @s data.splendor.last{code:5} run function splendor:sound/noble
scoreboard players set #visited sp_ctx -1
execute store result score #visited sp_ctx run data get entity @s data.splendor.last.noble
execute if score #visited sp_ctx matches 0..9 unless data entity @s data.splendor.last{code:5} run function splendor:sound/noble
execute if score @s sp_state matches 4 run function splendor:game/win
