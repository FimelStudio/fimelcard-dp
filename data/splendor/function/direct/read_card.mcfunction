data modify storage splendor:direct card_id set value -1
execute if score @s sp_target matches 0 run data modify storage splendor:direct card_id set from entity @e[tag=sp.current,limit=1] data.splendor.market[0]
execute if score @s sp_target matches 1 run data modify storage splendor:direct card_id set from entity @e[tag=sp.current,limit=1] data.splendor.market[1]
execute if score @s sp_target matches 2 run data modify storage splendor:direct card_id set from entity @e[tag=sp.current,limit=1] data.splendor.market[2]
execute if score @s sp_target matches 3 run data modify storage splendor:direct card_id set from entity @e[tag=sp.current,limit=1] data.splendor.market[3]
execute if score @s sp_target matches 4 run data modify storage splendor:direct card_id set from entity @e[tag=sp.current,limit=1] data.splendor.market[4]
execute if score @s sp_target matches 5 run data modify storage splendor:direct card_id set from entity @e[tag=sp.current,limit=1] data.splendor.market[5]
execute if score @s sp_target matches 6 run data modify storage splendor:direct card_id set from entity @e[tag=sp.current,limit=1] data.splendor.market[6]
execute if score @s sp_target matches 7 run data modify storage splendor:direct card_id set from entity @e[tag=sp.current,limit=1] data.splendor.market[7]
execute if score @s sp_target matches 8 run data modify storage splendor:direct card_id set from entity @e[tag=sp.current,limit=1] data.splendor.market[8]
execute if score @s sp_target matches 9 run data modify storage splendor:direct card_id set from entity @e[tag=sp.current,limit=1] data.splendor.market[9]
execute if score @s sp_target matches 10 run data modify storage splendor:direct card_id set from entity @e[tag=sp.current,limit=1] data.splendor.market[10]
execute if score @s sp_target matches 11 run data modify storage splendor:direct card_id set from entity @e[tag=sp.current,limit=1] data.splendor.market[11]
execute if score @s sp_target matches 12 run data modify storage splendor:direct card_id set from storage splendor:direct hand.reserve[0]
execute if score @s sp_target matches 13 run data modify storage splendor:direct card_id set from storage splendor:direct hand.reserve[1]
execute if score @s sp_target matches 14 run data modify storage splendor:direct card_id set from storage splendor:direct hand.reserve[2]
scoreboard players set #card sp_ctx -1
execute store result score #card sp_ctx run data get storage splendor:direct card_id
execute if score #card sp_ctx matches 0..89 run function splendor:direct/card_data with storage splendor:direct
