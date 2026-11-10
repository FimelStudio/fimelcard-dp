function decrypto:sync/bind
execute unless score #sync_ok dc_ctx matches 1 run return 0
execute unless entity @e[tag=dc.sync_controller,scores={dc_state=5},limit=1] run return 0
execute if score @s dc_sd matches 1 run return 0
scoreboard players set #t dc_ctx -1
scoreboard players set #n dc_ctx -1
execute store result score #t dc_ctx run data get storage decrypto:sync incoming.t
execute store result score #n dc_ctx run data get storage decrypto:sync incoming.n
execute unless score #t dc_ctx = @s dc_id run return 0
execute unless score #n dc_ctx = @e[tag=dc.sync_controller,limit=1] dc_form run return 0
function decrypto:sync/duties
execute unless score #duties dc_ctx matches 1.. run return 0
scoreboard players set #d_valid dc_ctx 0
data modify storage decrypto:sync d_answer set value []
execute if data storage decrypto:sync incoming{d:"123"} run scoreboard players set #d_valid dc_ctx 1
execute if data storage decrypto:sync incoming{d:"123"} run data modify storage decrypto:sync d_answer set value [1,2,3]
execute if data storage decrypto:sync incoming{d:"124"} run scoreboard players set #d_valid dc_ctx 1
execute if data storage decrypto:sync incoming{d:"124"} run data modify storage decrypto:sync d_answer set value [1,2,4]
execute if data storage decrypto:sync incoming{d:"132"} run scoreboard players set #d_valid dc_ctx 1
execute if data storage decrypto:sync incoming{d:"132"} run data modify storage decrypto:sync d_answer set value [1,3,2]
execute if data storage decrypto:sync incoming{d:"134"} run scoreboard players set #d_valid dc_ctx 1
execute if data storage decrypto:sync incoming{d:"134"} run data modify storage decrypto:sync d_answer set value [1,3,4]
execute if data storage decrypto:sync incoming{d:"142"} run scoreboard players set #d_valid dc_ctx 1
execute if data storage decrypto:sync incoming{d:"142"} run data modify storage decrypto:sync d_answer set value [1,4,2]
execute if data storage decrypto:sync incoming{d:"143"} run scoreboard players set #d_valid dc_ctx 1
execute if data storage decrypto:sync incoming{d:"143"} run data modify storage decrypto:sync d_answer set value [1,4,3]
execute if data storage decrypto:sync incoming{d:"213"} run scoreboard players set #d_valid dc_ctx 1
execute if data storage decrypto:sync incoming{d:"213"} run data modify storage decrypto:sync d_answer set value [2,1,3]
execute if data storage decrypto:sync incoming{d:"214"} run scoreboard players set #d_valid dc_ctx 1
execute if data storage decrypto:sync incoming{d:"214"} run data modify storage decrypto:sync d_answer set value [2,1,4]
execute if data storage decrypto:sync incoming{d:"231"} run scoreboard players set #d_valid dc_ctx 1
execute if data storage decrypto:sync incoming{d:"231"} run data modify storage decrypto:sync d_answer set value [2,3,1]
execute if data storage decrypto:sync incoming{d:"234"} run scoreboard players set #d_valid dc_ctx 1
execute if data storage decrypto:sync incoming{d:"234"} run data modify storage decrypto:sync d_answer set value [2,3,4]
execute if data storage decrypto:sync incoming{d:"241"} run scoreboard players set #d_valid dc_ctx 1
execute if data storage decrypto:sync incoming{d:"241"} run data modify storage decrypto:sync d_answer set value [2,4,1]
execute if data storage decrypto:sync incoming{d:"243"} run scoreboard players set #d_valid dc_ctx 1
execute if data storage decrypto:sync incoming{d:"243"} run data modify storage decrypto:sync d_answer set value [2,4,3]
execute if data storage decrypto:sync incoming{d:"312"} run scoreboard players set #d_valid dc_ctx 1
execute if data storage decrypto:sync incoming{d:"312"} run data modify storage decrypto:sync d_answer set value [3,1,2]
execute if data storage decrypto:sync incoming{d:"314"} run scoreboard players set #d_valid dc_ctx 1
execute if data storage decrypto:sync incoming{d:"314"} run data modify storage decrypto:sync d_answer set value [3,1,4]
execute if data storage decrypto:sync incoming{d:"321"} run scoreboard players set #d_valid dc_ctx 1
execute if data storage decrypto:sync incoming{d:"321"} run data modify storage decrypto:sync d_answer set value [3,2,1]
execute if data storage decrypto:sync incoming{d:"324"} run scoreboard players set #d_valid dc_ctx 1
execute if data storage decrypto:sync incoming{d:"324"} run data modify storage decrypto:sync d_answer set value [3,2,4]
execute if data storage decrypto:sync incoming{d:"341"} run scoreboard players set #d_valid dc_ctx 1
execute if data storage decrypto:sync incoming{d:"341"} run data modify storage decrypto:sync d_answer set value [3,4,1]
execute if data storage decrypto:sync incoming{d:"342"} run scoreboard players set #d_valid dc_ctx 1
execute if data storage decrypto:sync incoming{d:"342"} run data modify storage decrypto:sync d_answer set value [3,4,2]
execute if data storage decrypto:sync incoming{d:"412"} run scoreboard players set #d_valid dc_ctx 1
execute if data storage decrypto:sync incoming{d:"412"} run data modify storage decrypto:sync d_answer set value [4,1,2]
execute if data storage decrypto:sync incoming{d:"413"} run scoreboard players set #d_valid dc_ctx 1
execute if data storage decrypto:sync incoming{d:"413"} run data modify storage decrypto:sync d_answer set value [4,1,3]
execute if data storage decrypto:sync incoming{d:"421"} run scoreboard players set #d_valid dc_ctx 1
execute if data storage decrypto:sync incoming{d:"421"} run data modify storage decrypto:sync d_answer set value [4,2,1]
execute if data storage decrypto:sync incoming{d:"423"} run scoreboard players set #d_valid dc_ctx 1
execute if data storage decrypto:sync incoming{d:"423"} run data modify storage decrypto:sync d_answer set value [4,2,3]
execute if data storage decrypto:sync incoming{d:"431"} run scoreboard players set #d_valid dc_ctx 1
execute if data storage decrypto:sync incoming{d:"431"} run data modify storage decrypto:sync d_answer set value [4,3,1]
execute if data storage decrypto:sync incoming{d:"432"} run scoreboard players set #d_valid dc_ctx 1
execute if data storage decrypto:sync incoming{d:"432"} run data modify storage decrypto:sync d_answer set value [4,3,2]
execute if score #decode dc_ctx matches 1 unless score #d_valid dc_ctx matches 1 run return run tellraw @s {text:"请输入三个不同的1～4，例如123。",color:"red"}
scoreboard players set #i_valid dc_ctx 0
data modify storage decrypto:sync i_answer set value []
execute if data storage decrypto:sync incoming{i:"123"} run scoreboard players set #i_valid dc_ctx 1
execute if data storage decrypto:sync incoming{i:"123"} run data modify storage decrypto:sync i_answer set value [1,2,3]
execute if data storage decrypto:sync incoming{i:"124"} run scoreboard players set #i_valid dc_ctx 1
execute if data storage decrypto:sync incoming{i:"124"} run data modify storage decrypto:sync i_answer set value [1,2,4]
execute if data storage decrypto:sync incoming{i:"132"} run scoreboard players set #i_valid dc_ctx 1
execute if data storage decrypto:sync incoming{i:"132"} run data modify storage decrypto:sync i_answer set value [1,3,2]
execute if data storage decrypto:sync incoming{i:"134"} run scoreboard players set #i_valid dc_ctx 1
execute if data storage decrypto:sync incoming{i:"134"} run data modify storage decrypto:sync i_answer set value [1,3,4]
execute if data storage decrypto:sync incoming{i:"142"} run scoreboard players set #i_valid dc_ctx 1
execute if data storage decrypto:sync incoming{i:"142"} run data modify storage decrypto:sync i_answer set value [1,4,2]
execute if data storage decrypto:sync incoming{i:"143"} run scoreboard players set #i_valid dc_ctx 1
execute if data storage decrypto:sync incoming{i:"143"} run data modify storage decrypto:sync i_answer set value [1,4,3]
execute if data storage decrypto:sync incoming{i:"213"} run scoreboard players set #i_valid dc_ctx 1
execute if data storage decrypto:sync incoming{i:"213"} run data modify storage decrypto:sync i_answer set value [2,1,3]
execute if data storage decrypto:sync incoming{i:"214"} run scoreboard players set #i_valid dc_ctx 1
execute if data storage decrypto:sync incoming{i:"214"} run data modify storage decrypto:sync i_answer set value [2,1,4]
execute if data storage decrypto:sync incoming{i:"231"} run scoreboard players set #i_valid dc_ctx 1
execute if data storage decrypto:sync incoming{i:"231"} run data modify storage decrypto:sync i_answer set value [2,3,1]
execute if data storage decrypto:sync incoming{i:"234"} run scoreboard players set #i_valid dc_ctx 1
execute if data storage decrypto:sync incoming{i:"234"} run data modify storage decrypto:sync i_answer set value [2,3,4]
execute if data storage decrypto:sync incoming{i:"241"} run scoreboard players set #i_valid dc_ctx 1
execute if data storage decrypto:sync incoming{i:"241"} run data modify storage decrypto:sync i_answer set value [2,4,1]
execute if data storage decrypto:sync incoming{i:"243"} run scoreboard players set #i_valid dc_ctx 1
execute if data storage decrypto:sync incoming{i:"243"} run data modify storage decrypto:sync i_answer set value [2,4,3]
execute if data storage decrypto:sync incoming{i:"312"} run scoreboard players set #i_valid dc_ctx 1
execute if data storage decrypto:sync incoming{i:"312"} run data modify storage decrypto:sync i_answer set value [3,1,2]
execute if data storage decrypto:sync incoming{i:"314"} run scoreboard players set #i_valid dc_ctx 1
execute if data storage decrypto:sync incoming{i:"314"} run data modify storage decrypto:sync i_answer set value [3,1,4]
execute if data storage decrypto:sync incoming{i:"321"} run scoreboard players set #i_valid dc_ctx 1
execute if data storage decrypto:sync incoming{i:"321"} run data modify storage decrypto:sync i_answer set value [3,2,1]
execute if data storage decrypto:sync incoming{i:"324"} run scoreboard players set #i_valid dc_ctx 1
execute if data storage decrypto:sync incoming{i:"324"} run data modify storage decrypto:sync i_answer set value [3,2,4]
execute if data storage decrypto:sync incoming{i:"341"} run scoreboard players set #i_valid dc_ctx 1
execute if data storage decrypto:sync incoming{i:"341"} run data modify storage decrypto:sync i_answer set value [3,4,1]
execute if data storage decrypto:sync incoming{i:"342"} run scoreboard players set #i_valid dc_ctx 1
execute if data storage decrypto:sync incoming{i:"342"} run data modify storage decrypto:sync i_answer set value [3,4,2]
execute if data storage decrypto:sync incoming{i:"412"} run scoreboard players set #i_valid dc_ctx 1
execute if data storage decrypto:sync incoming{i:"412"} run data modify storage decrypto:sync i_answer set value [4,1,2]
execute if data storage decrypto:sync incoming{i:"413"} run scoreboard players set #i_valid dc_ctx 1
execute if data storage decrypto:sync incoming{i:"413"} run data modify storage decrypto:sync i_answer set value [4,1,3]
execute if data storage decrypto:sync incoming{i:"421"} run scoreboard players set #i_valid dc_ctx 1
execute if data storage decrypto:sync incoming{i:"421"} run data modify storage decrypto:sync i_answer set value [4,2,1]
execute if data storage decrypto:sync incoming{i:"423"} run scoreboard players set #i_valid dc_ctx 1
execute if data storage decrypto:sync incoming{i:"423"} run data modify storage decrypto:sync i_answer set value [4,2,3]
execute if data storage decrypto:sync incoming{i:"431"} run scoreboard players set #i_valid dc_ctx 1
execute if data storage decrypto:sync incoming{i:"431"} run data modify storage decrypto:sync i_answer set value [4,3,1]
execute if data storage decrypto:sync incoming{i:"432"} run scoreboard players set #i_valid dc_ctx 1
execute if data storage decrypto:sync incoming{i:"432"} run data modify storage decrypto:sync i_answer set value [4,3,2]
execute if score #intercept dc_ctx matches 1 unless score #i_valid dc_ctx matches 1 run return run tellraw @s {text:"请输入三个不同的1～4，例如123。",color:"red"}
scoreboard players set @s dc_sd 1
clear @s *[minecraft:custom_data~{decrypto:{tool:"guess"}}]
scoreboard players operation #sync_team dc_ctx = @s dc_team
tag @a[tag=dc.sync_submitter] remove dc.sync_submitter
tag @s add dc.sync_submitter
execute as @e[tag=dc.sync_controller,limit=1] run function decrypto:sync/store_answers
