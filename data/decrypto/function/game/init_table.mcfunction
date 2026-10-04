# 回合上限属于当前牌桌的谍报风云设置；首次进入时使用原规则的8轮。
execute unless score @s dc_round_limit matches 1..32 run scoreboard players set @s dc_round_limit 8
execute unless score @s dc_input matches 0..1 run scoreboard players set @s dc_input 0

# 运行期状态在大厅初始化时归零，不覆盖牌桌设置。
scoreboard players set @s dc_round 0
