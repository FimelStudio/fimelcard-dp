# 创建记分板

scoreboard objectives add fca_store dummy

scoreboard objectives add fca_timer dummy
scoreboard objectives add fca_timer_total dummy
scoreboard objectives add fca_timer_max dummy
scoreboard objectives add fca_timer_start dummy
scoreboard objectives add fca_style dummy
scoreboard objectives add fca_id dummy

scoreboard objectives add fca_player_id dummy

# 设置分数项

execute unless score #info.version fca_store matches 1 run function fimel_anim_text:_initialize_/score/value

# 版本校验

execute unless score #info.version fca_store matches 1 run function fimel_anim_text:_initialize_/version

# 加载设置

forceload add 1 1