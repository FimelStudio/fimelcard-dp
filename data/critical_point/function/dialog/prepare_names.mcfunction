scoreboard players operation #ctx cp_ctx = @s cp_id
data modify storage critical_point:dialog name1 set value {text:'空座位',color:'dark_gray'}
data modify storage critical_point:dialog name2 set value {text:'空座位',color:'dark_gray'}
data modify storage critical_point:dialog name3 set value {text:'空座位',color:'dark_gray'}
data modify storage critical_point:dialog name4 set value {text:'空座位',color:'dark_gray'}
execute as @a[tag=cp.player,scores={cp_seat=1}] if score @s cp_id = #ctx cp_ctx at @s run function hanabi:name/resolve
execute as @a[tag=cp.player,scores={cp_seat=1}] if score @s cp_id = #ctx cp_ctx run data modify storage critical_point:dialog name1 set from storage hanabi:name resolved
execute as @a[tag=cp.player,scores={cp_seat=2}] if score @s cp_id = #ctx cp_ctx at @s run function hanabi:name/resolve
execute as @a[tag=cp.player,scores={cp_seat=2}] if score @s cp_id = #ctx cp_ctx run data modify storage critical_point:dialog name2 set from storage hanabi:name resolved
execute as @a[tag=cp.player,scores={cp_seat=3}] if score @s cp_id = #ctx cp_ctx at @s run function hanabi:name/resolve
execute as @a[tag=cp.player,scores={cp_seat=3}] if score @s cp_id = #ctx cp_ctx run data modify storage critical_point:dialog name3 set from storage hanabi:name resolved
execute as @a[tag=cp.player,scores={cp_seat=4}] if score @s cp_id = #ctx cp_ctx at @s run function hanabi:name/resolve
execute as @a[tag=cp.player,scores={cp_seat=4}] if score @s cp_id = #ctx cp_ctx run data modify storage critical_point:dialog name4 set from storage hanabi:name resolved

