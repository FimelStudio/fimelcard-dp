data modify storage wenfei:io pages set value []
data modify storage wenfei:io pages set from entity @e[tag=wq.drop,limit=1] Item.components."minecraft:writable_book_content".pages
execute store result score #pages wq_ctx run data get storage wenfei:io pages
execute unless score #pages wq_ctx matches 1 run return run function wenfei:input/reject_answer
data modify storage wenfei:io answer set value {text:""}
data modify storage wenfei:io answer.text set from storage wenfei:io pages[0]
execute if data storage wenfei:io pages[0].raw run data modify storage wenfei:io answer.text set from storage wenfei:io pages[0].raw
execute if data storage wenfei:io answer{text:""} run return run function wenfei:input/reject_answer
execute store result storage wenfei:io submit.seat int 1 run scoreboard players get @s wq_seat
execute as @e[tag=wq.current,limit=1] run function wenfei:input/save_answer with storage wenfei:io submit
kill @e[tag=wq.drop,limit=1]
scoreboard players set @s wq_done 1
tellraw @s {text:"[问非所答] 答案已锁定，等待其他玩家。",color:"green"}
execute as @e[tag=wq.current,limit=1] at @s run function wenfei:round/check_answers
