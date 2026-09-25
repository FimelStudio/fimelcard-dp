execute if items entity @e[tag=wq.drop,limit=1] contents minecraft:purple_dye[minecraft:custom_data~{wenfei:{tool:"menu"}}] run return run function wenfei:input/reopen_category
execute if items entity @e[tag=wq.drop,limit=1] contents *[minecraft:custom_data~{wenfei:{tool:"score"}}] run return run function wenfei:input/score
execute unless score @s wq_guess matches 0 run return 0
execute unless score @s wq_done matches 0 run return 0
scoreboard players operation #ctx wq_ctx = @s wq_id
tag @e[tag=wq.current] remove wq.current
execute as @e[type=minecraft:marker,tag=wq.controller,scores={wq_state=2}] if score @s wq_id = #ctx wq_ctx run tag @s add wq.current
execute unless entity @e[tag=wq.current,limit=1] run return 0
execute if items entity @e[tag=wq.drop,limit=1] contents minecraft:writable_book[minecraft:custom_data~{wenfei:{tool:"answer"}}] run function wenfei:input/accept_answer
execute if items entity @e[tag=wq.drop,limit=1] contents minecraft:written_book[minecraft:custom_data~{wenfei:{tool:"answer"}}] run function wenfei:input/signed_answer
tag @e[tag=wq.current] remove wq.current
