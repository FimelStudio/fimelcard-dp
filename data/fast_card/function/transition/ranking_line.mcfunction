# 正分、负分与不变使用不同颜色
execute if score @a[tag=fc.rank_pick,limit=1] fc_delta matches 1.. run function fast_card:transition/ranking_line_positive with storage fast_card:transition line
execute if score @a[tag=fc.rank_pick,limit=1] fc_delta matches ..-1 run function fast_card:transition/ranking_line_negative with storage fast_card:transition line
execute if score @a[tag=fc.rank_pick,limit=1] fc_delta matches 0 run function fast_card:transition/ranking_line_zero with storage fast_card:transition line

# typewriter实例只有一个展示实体，直接记录其牌桌编号即可
scoreboard players operation #ctx_id fc_ctx = @s fc_id
scoreboard players operation @e[type=minecraft:text_display,tag=cgt_anim_text.positional.typewriter,tag=!fc.transition,distance=..0.05,sort=nearest,limit=1] fc_id = #ctx_id fc_ctx
tag @e[type=minecraft:text_display,tag=cgt_anim_text.positional.typewriter,tag=!fc.transition,distance=..0.05,sort=nearest,limit=1] add fc.transition
tag @e[type=minecraft:text_display,tag=cgt_anim_text.positional.typewriter,tag=fc.transition,distance=..0.05,sort=nearest,limit=1] add fc.transition.root

execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx at @s run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 0.35 1.3
