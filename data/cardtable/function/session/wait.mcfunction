function cardtable:session/discard_paused_inputs
scoreboard players add @s ct_wait 1
scoreboard players operation #missing ct_ctx = @s ct_expected
scoreboard players operation #missing ct_ctx -= #session_online ct_ctx
execute if score @s ct_wait matches 1 as @a[tag=ct.player] if score @s ct_id = #session_table ct_ctx run title @s actionbar [{text:"对局暂停 · 等待 ",color:"yellow"},{score:{name:"#missing",objective:"ct_ctx"}},{text:" 位玩家重连 · 可投票结束",color:"gray"}]
execute if score @s ct_wait matches 20.. run scoreboard players set @s ct_wait 0
