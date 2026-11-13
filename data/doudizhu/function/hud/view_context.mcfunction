scoreboard players operation #hud_table dd_ctx = @s dd_id
scoreboard players operation #hud_viewer dd_ctx = @s dd_seat
scoreboard players operation #hud_pov dd_ctx = #hud_viewer dd_ctx
scoreboard players set #hud_out dd_ctx 0
execute if score @e[tag=dd.current,limit=1] dd_humans matches 4 run scoreboard players operation #hud_out dd_ctx = @e[tag=dd.current,limit=1] dd_out
# 轮空席可看所在分桌的地主手牌。观看者身份和操作权限保持独立。
execute if entity @e[tag=dd.current,scores={dd_state=3,dd_humans=4,dd_lord=1..8},limit=1] if score #hud_viewer dd_ctx = #hud_out dd_ctx run scoreboard players operation #hud_pov dd_ctx = @e[tag=dd.current,limit=1] dd_lord
