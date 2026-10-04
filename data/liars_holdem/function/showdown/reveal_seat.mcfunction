scoreboard players operation #ctx_id lh_ctx = @s lh_id
tag @a[tag=lh.reveal_actor] remove lh.reveal_actor
$execute as @a[tag=lh.player,scores={lh_in_showdown=1,lh_shown=0,lh_seat=$(seat)}] if score @s lh_id = #ctx_id lh_ctx run tag @s add lh.reveal_actor
execute unless entity @a[tag=lh.reveal_actor,limit=1] run return 0

scoreboard players set @a[tag=lh.reveal_actor,limit=1] lh_shown 1
scoreboard players add @s lh_show_count 1
function liars_holdem:sound/reveal_hand
execute store result storage liars_holdem:showdown identity.table int 1 run scoreboard players get @s lh_id
execute store result storage liars_holdem:showdown identity.seat int 1 run scoreboard players get @a[tag=lh.reveal_actor,limit=1] lh_seat
function liars_holdem:showdown/init_identity with storage liars_holdem:showdown identity

function liars_holdem:showdown/append_card {key:1,separator:"、"}
function liars_holdem:showdown/append_card {key:2,separator:"、"}
function liars_holdem:showdown/append_card {key:3,separator:"、"}
function liars_holdem:showdown/append_card {key:4,separator:"、"}
function liars_holdem:showdown/append_card {key:5,separator:"　"}
data modify storage liars_holdem:showdown line append value {text:"　"}
execute as @a[tag=lh.reveal_actor,limit=1] run function liars_holdem:showdown/load_category
data modify storage liars_holdem:showdown line append from storage liars_holdem:showdown category
data modify storage liars_holdem:showdown chat append from storage liars_holdem:showdown category

# 中央实体和聊天都直接使用本桌、本座位玩家的名称；选择器包含桌号，不会串到其他牌桌
function liars_holdem:showdown/tell_line with storage liars_holdem:showdown
execute if score @s lh_show_count matches 1 run data modify storage liars_holdem:showdown spawn.y set value "1.55"
execute if score @s lh_show_count matches 2 run data modify storage liars_holdem:showdown spawn.y set value "2.10"
execute if score @s lh_show_count matches 3 run data modify storage liars_holdem:showdown spawn.y set value "2.65"
execute if score @s lh_show_count matches 4 run data modify storage liars_holdem:showdown spawn.y set value "3.20"
# 两种桌型统一在桌心单列排列，行距与四人桌相同。
execute if score @s lh_show_count matches 5 run data modify storage liars_holdem:showdown spawn.y set value "3.75"
execute if score @s lh_show_count matches 6 run data modify storage liars_holdem:showdown spawn.y set value "4.30"
execute if score @s lh_show_count matches 7 run data modify storage liars_holdem:showdown spawn.y set value "4.85"
execute if score @s lh_show_count matches 8 run data modify storage liars_holdem:showdown spawn.y set value "5.40"
data modify storage liars_holdem:showdown spawn.line set from storage liars_holdem:showdown line
scoreboard players set #display_rank lh_ctx 0
function liars_holdem:showdown/summon_line with storage liars_holdem:showdown spawn
tag @a[tag=lh.reveal_actor] remove lh.reveal_actor
