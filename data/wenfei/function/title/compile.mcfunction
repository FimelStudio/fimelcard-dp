$execute unless data entity @s data.wenfei.answers.s$(seat) run return 0
data modify storage wenfei:wrap rows set value []
data modify storage wenfei:wrap line set value {text:"",color:"white",extra:[]}
$data modify storage wenfei:wrap remaining set from entity @s data.wenfei.answers.s$(seat).text
scoreboard players set #columns wq_ctx 0
execute unless data storage wenfei:wrap {remaining:""} run function wenfei:title/wrap/scan
execute if score #columns wq_ctx matches 1.. run function wenfei:title/wrap/flush
$data modify entity @s data.wenfei.answer_lines.s$(seat) set from storage wenfei:wrap rows
