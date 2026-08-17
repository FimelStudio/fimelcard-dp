# 判负规则下，乱按者立即减1分并结束本局；本局没有胜利加分
function fast_card:log {text:"检测到无有效牌型乱按，按配置立即判负"}
scoreboard players remove @a[tag=fc.clicker,limit=1] fc_score 1
scoreboard players set @s fc_mode 3
scoreboard players operation #ctx_id fc_ctx = @s fc_id
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx at @s run playsound minecraft:entity.villager.no master @s ~ ~ ~ 1.0 0.7
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run tellraw @s [{text:'[Fast Card] ',color:'gold'},{selector:'@a[tag=fc.clicker,limit=1]',color:'red'},{text:' 在没有有效牌型时乱按按钮，本局判负并扣1分！',color:'red'}]
function fast_card:round/end
