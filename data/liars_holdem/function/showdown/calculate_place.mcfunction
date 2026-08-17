# 名次为“比自己大的牌型数量+1”，并列玩家因此会得到相同名次
scoreboard players operation #place_value lh_ctx = @s lh_value
scoreboard players set #place lh_ctx 1
execute as @a[tag=lh.player,scores={lh_in_showdown=1}] if score @s lh_id = #ctx_id lh_ctx if score @s lh_value > #place_value lh_ctx run scoreboard players add #place lh_ctx 1
scoreboard players operation @s lh_place = #place lh_ctx
