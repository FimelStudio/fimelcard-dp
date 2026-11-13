clear @s *[minecraft:custom_data~{magical_athlete:{choice:1b}}]
data modify storage magical_athlete:direct index set value 0
function magical_athlete:direct/page_slot {slot:0}
function magical_athlete:direct/page_slot {slot:1}
function magical_athlete:direct/page_slot {slot:2}
function magical_athlete:direct/page_slot {slot:3}
function magical_athlete:direct/page_slot {slot:4}
function magical_athlete:direct/page_slot {slot:5}
execute store result score #count ma_ctx run data get storage magical_athlete:direct options
scoreboard players operation #page_count ma_ctx = #count ma_ctx
scoreboard players operation #page_count ma_ctx -= @s ma_dpage
execute if score #page_count ma_ctx matches 7.. run scoreboard players set #page_count ma_ctx 6
scoreboard players operation @s ma_expected = #page_count ma_ctx
scoreboard players add @s ma_expected 2
execute if score #count ma_ctx matches 7.. run scoreboard players add @s ma_expected 1
execute if score #count ma_ctx matches 7.. run function magical_athlete:direct/page_tool with storage magical_athlete:direct
function magical_athlete:direct/cancel_tool with storage magical_athlete:direct
