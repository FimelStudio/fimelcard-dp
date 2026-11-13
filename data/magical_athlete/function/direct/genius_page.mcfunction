clear @s *[minecraft:custom_data~{magical_athlete:{choice:1b}}]
scoreboard players set @s ma_dpage 0
data modify storage magical_athlete:direct options set value [1,2,3,4,5,6,0]
function magical_athlete:direct/page_slot {slot:0}
function magical_athlete:direct/page_slot {slot:1}
function magical_athlete:direct/page_slot {slot:2}
function magical_athlete:direct/page_slot {slot:3}
function magical_athlete:direct/page_slot {slot:4}
function magical_athlete:direct/page_slot {slot:5}
function magical_athlete:direct/page_slot {slot:6}
scoreboard players set @s ma_expected 9
function magical_athlete:direct/cancel_tool with storage magical_athlete:direct
