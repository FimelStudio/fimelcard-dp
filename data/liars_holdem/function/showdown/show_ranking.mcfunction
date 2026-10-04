scoreboard players set @s lh_show_phase 1
scoreboard players set @s lh_timer 0
scoreboard players operation #ctx_id lh_ctx = @s lh_id
tag @a[tag=lh.rank_member] remove lh.rank_member
execute as @a[tag=lh.player,scores={lh_in_showdown=1}] if score @s lh_id = #ctx_id lh_ctx run tag @s add lh.rank_member
data modify storage liars_holdem:showdown line set value [{text:"最终牌型排名",color:"gold",bold:true}]
execute store result storage liars_holdem:showdown rank.table int 1 run scoreboard players get @s lh_id
data modify storage liars_holdem:showdown rank.place set value 1
function liars_holdem:showdown/append_place with storage liars_holdem:showdown rank
data modify storage liars_holdem:showdown rank.place set value 2
function liars_holdem:showdown/append_place with storage liars_holdem:showdown rank
data modify storage liars_holdem:showdown rank.place set value 3
function liars_holdem:showdown/append_place with storage liars_holdem:showdown rank
data modify storage liars_holdem:showdown rank.place set value 4
function liars_holdem:showdown/append_place with storage liars_holdem:showdown rank
data modify storage liars_holdem:showdown rank.place set value 5
function liars_holdem:showdown/append_place with storage liars_holdem:showdown rank
data modify storage liars_holdem:showdown rank.place set value 6
function liars_holdem:showdown/append_place with storage liars_holdem:showdown rank
data modify storage liars_holdem:showdown rank.place set value 7
function liars_holdem:showdown/append_place with storage liars_holdem:showdown rank
data modify storage liars_holdem:showdown rank.place set value 8
function liars_holdem:showdown/append_place with storage liars_holdem:showdown rank
# 最终排名固定在桌面上方、第一行摊牌下方，不随人数升高。
data modify storage liars_holdem:showdown spawn.y set value "1.05"
scoreboard players set #display_rank lh_ctx 1
data modify storage liars_holdem:showdown spawn.line set from storage liars_holdem:showdown line
function liars_holdem:showdown/summon_line with storage liars_holdem:showdown spawn
function liars_holdem:sound/ranking

tag @a[tag=lh.audience] remove lh.audience
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run tag @s add lh.audience
tellraw @a[tag=lh.audience] [{text:'—— 最终牌型排名 ——',color:'gold',bold:true}]
execute as @a[tag=lh.rank_member,scores={lh_place=1}] run function liars_holdem:showdown/announce_place {place:1}
execute as @a[tag=lh.rank_member,scores={lh_place=2}] run function liars_holdem:showdown/announce_place {place:2}
execute as @a[tag=lh.rank_member,scores={lh_place=3}] run function liars_holdem:showdown/announce_place {place:3}
execute as @a[tag=lh.rank_member,scores={lh_place=4}] run function liars_holdem:showdown/announce_place {place:4}
execute as @a[tag=lh.rank_member,scores={lh_place=5}] run function liars_holdem:showdown/announce_place {place:5}
execute as @a[tag=lh.rank_member,scores={lh_place=6}] run function liars_holdem:showdown/announce_place {place:6}
execute as @a[tag=lh.rank_member,scores={lh_place=7}] run function liars_holdem:showdown/announce_place {place:7}
execute as @a[tag=lh.rank_member,scores={lh_place=8}] run function liars_holdem:showdown/announce_place {place:8}
tag @a[tag=lh.audience] remove lh.audience
tag @a[tag=lh.rank_member] remove lh.rank_member
function liars_holdem:log {text:"最佳五张牌展示完毕，已输出最终牌型排名"}
