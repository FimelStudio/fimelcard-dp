# hb_reason：1达到本桌失误上限，2牌库与所有普通手牌耗尽，3全部烟花序列完成
execute if score @s hb_state matches 3 run return 0
scoreboard players set @s hb_state 3
scoreboard players set @s hb_timer 0
scoreboard players operation #ctx_id hb_ctx = @s hb_id
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run dialog clear @s
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run title @s actionbar {text:""}
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run function hanabi:input/clear_actions
function hanabi:result/announce
function hanabi:log {text:"花火进入最终结算等待"}
