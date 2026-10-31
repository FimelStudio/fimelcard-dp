# 到此才提交牌权与张数；不合法操作不会先改手牌。
scoreboard players set #ui_played un_ctx 1
scoreboard players operation @s un_say = #u_say un_ctx
scoreboard players operation @s un_chosen = #u_chosen un_ctx
scoreboard players operation @s un_wildbad = #u_wildbad un_ctx
scoreboard players operation @s un_offender = #u_actor un_ctx
scoreboard players operation @s un_top = @e[tag=un.selected,limit=1] un_idx
scoreboard players operation @s un_value = @e[tag=un.selected,limit=1] un_value
scoreboard players operation @s un_color = @e[tag=un.selected,limit=1] un_color
execute if score #u_pick un_ctx matches 52..53 run scoreboard players operation @s un_color = @s un_chosen
scoreboard players set @e[tag=un.selected,limit=1] un_owner -1
scoreboard players operation @e[tag=un.selected,limit=1] un_order = @s un_epoch
scoreboard players remove @e[tag=un.actor,limit=1] un_count 1
scoreboard players set @e[tag=un.actor,limit=1] un_pick -1
scoreboard players set @s un_effect 0
execute if score @s un_value matches 10 run scoreboard players set @s un_effect 1
execute if score @s un_value matches 11 run scoreboard players set @s un_effect 2
execute if score @s un_value matches 12 run scoreboard players set @s un_effect 3
execute if score @s un_value matches 14 run scoreboard players set @s un_effect 4
scoreboard players set @s un_winner 0
execute if score @e[tag=un.actor,limit=1] un_count matches 0 run scoreboard players operation @s un_winner = #u_actor un_ctx
scoreboard players operation #card un_ctx = #u_pick un_ctx
scoreboard players operation #seat un_ctx = #u_actor un_ctx
function uno:message/play
function uno:visual/play
function uno:log {text:"合法出牌已提交，处理 UNO、功能牌及胜利判定"}
execute if score @e[tag=un.actor,limit=1] un_count matches 1 if score @s un_auto matches 0 unless score @s un_say matches 1 run return run function uno:round/offer_uno
execute if score @a[tag=un.actor,limit=1] un_count matches 1 run tellraw @a[tag=un.audience] [{text:'[UNO] ',color:'gold'},{selector:'@a[tag=un.actor,limit=1]',color:'aqua'},{text:'：UNO！',color:'yellow'}]
function uno:round/resolve_play
