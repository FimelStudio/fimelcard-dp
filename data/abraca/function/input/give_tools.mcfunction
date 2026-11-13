# 八张操作牌与真实手牌无关；用give填入空位，绝不覆盖玩家的其他物品。
function abraca:input/clear_tools
execute unless entity @s[tag=ab.turn,tag=ab.player,tag=ct.player] run return 0
execute unless score @s ab_id = @s ct_id run return 0
scoreboard players add #input_nonce ab_ctx 1
execute if score #input_nonce ab_ctx matches 2000000000.. run scoreboard players set #input_nonce ab_ctx 1
scoreboard players operation @s ab_input = #input_nonce ab_ctx
execute store result storage abraca:input table int 1 run scoreboard players get @s ab_id
execute store result storage abraca:input epoch int 1 run scoreboard players get @s ab_input
function abraca:input/give_cards with storage abraca:input
function abraca:input/give_end with storage abraca:input
