scoreboard players set @s wq_state 0
function wenfei:player/mark_audience
tellraw @a[tag=wq.audience] {text:"══ 问非所答·最终成绩 ══",color:"gold"}
scoreboard players set #best wq_ctx -1
execute as @a[tag=wq.audience] if score @s wq_score > #best wq_ctx run scoreboard players operation #best wq_ctx = @s wq_score
execute as @a[tag=wq.audience] run function wenfei:game/rank_player
execute as @a[tag=wq.audience] if score @s wq_score = #best wq_ctx run tellraw @a[tag=wq.audience] [{text:"获胜：",color:"gold"},{selector:"@s"},{text:"（并列最高分共同获胜）"}]
function wenfei:log {text:"正常完成全部回合"}
function wenfei:game/abort
