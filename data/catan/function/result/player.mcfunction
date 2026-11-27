$data modify storage catan:result p set from entity @s data.catan.p$(side)
$data modify storage catan:result p.side set value $(side)
data modify storage catan:result p.mark set value ""
$execute unless data storage catan:result p.name run data modify storage catan:result p.name set value {text:"玩家$(side)",color:"white"}
data modify storage catan:result p.name.color set value "white"

$execute if data entity @s data.catan{winner:$(side)} run data modify storage catan:result p.mark set value " ★ 胜者"
scoreboard players set #result_longest ca_ctx 0
scoreboard players set #result_army ca_ctx 0
$execute if data entity @s data.catan{longest:$(side)} run scoreboard players set #result_longest ca_ctx 2
$execute if data entity @s data.catan{army:$(side)} run scoreboard players set #result_army ca_ctx 2
scoreboard players set #result_count ca_ctx 5
execute store result score #result_left ca_ctx run data get storage catan:result p.settlements_left
scoreboard players operation #result_count ca_ctx -= #result_left ca_ctx
execute store result storage catan:result p.settlements int 1 run scoreboard players get #result_count ca_ctx
scoreboard players set #result_count ca_ctx 4
execute store result score #result_left ca_ctx run data get storage catan:result p.cities_left
scoreboard players operation #result_count ca_ctx -= #result_left ca_ctx
execute store result storage catan:result p.cities int 1 run scoreboard players get #result_count ca_ctx
scoreboard players set #result_count ca_ctx 15
execute store result score #result_left ca_ctx run data get storage catan:result p.roads_left
scoreboard players operation #result_count ca_ctx -= #result_left ca_ctx
execute store result storage catan:result p.roads int 1 run scoreboard players get #result_count ca_ctx
execute store result score #result_hidden ca_ctx run data get storage catan:result p.vp
execute store result score #result_public ca_ctx run data get storage catan:result p.public_vp
scoreboard players operation #result_hidden ca_ctx -= #result_public ca_ctx
execute store result storage catan:result p.hidden int 1 run scoreboard players get #result_hidden ca_ctx
execute store result storage catan:result p.longest_points int 1 run scoreboard players get #result_longest ca_ctx
execute store result storage catan:result p.army_points int 1 run scoreboard players get #result_army ca_ctx
execute store result score #result_dev ca_ctx run data get storage catan:result p.dev[0]
execute store result score #result_fresh ca_ctx run data get storage catan:result p.fresh[0]
scoreboard players operation #result_dev ca_ctx += #result_fresh ca_ctx
execute store result storage catan:result p.d0 int 1 run scoreboard players get #result_dev ca_ctx
execute store result score #result_dev ca_ctx run data get storage catan:result p.dev[1]
execute store result score #result_fresh ca_ctx run data get storage catan:result p.fresh[1]
scoreboard players operation #result_dev ca_ctx += #result_fresh ca_ctx
execute store result storage catan:result p.d1 int 1 run scoreboard players get #result_dev ca_ctx
execute store result score #result_dev ca_ctx run data get storage catan:result p.dev[2]
execute store result score #result_fresh ca_ctx run data get storage catan:result p.fresh[2]
scoreboard players operation #result_dev ca_ctx += #result_fresh ca_ctx
execute store result storage catan:result p.d2 int 1 run scoreboard players get #result_dev ca_ctx
execute store result score #result_dev ca_ctx run data get storage catan:result p.dev[3]
execute store result score #result_fresh ca_ctx run data get storage catan:result p.fresh[3]
scoreboard players operation #result_dev ca_ctx += #result_fresh ca_ctx
execute store result storage catan:result p.d3 int 1 run scoreboard players get #result_dev ca_ctx
execute store result score #result_dev ca_ctx run data get storage catan:result p.dev[4]
execute store result score #result_fresh ca_ctx run data get storage catan:result p.fresh[4]
scoreboard players operation #result_dev ca_ctx += #result_fresh ca_ctx
execute store result storage catan:result p.d4 int 1 run scoreboard players get #result_dev ca_ctx
function catan:result/details with storage catan:result p
scoreboard players add #result_y ca_ctx 12
