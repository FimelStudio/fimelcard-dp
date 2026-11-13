execute unless score #players sp_ctx matches 2..4 run return run function splendor:engine/error {id:2}
data modify storage splendor:engine state set value {"version":1,"n":4,"phase":1,"turn":1,"epoch":1,"round":1,"final_round":0,"winners":[],"bank":[7,7,7,7,7,5],"market":[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],"deck1":[],"deck2":[],"deck3":[],"nobles":[-1,-1,-1,-1,-1],"eligible":[],"discard_due":0,"last":{"code":0,"actor":0,"target":-1,"card":-1,"take":[0,0,0,0,0,0],"pay":[0,0,0,0,0,0],"noble":-1},"p1":{"tokens":[0,0,0,0,0,0],"bonus":[0,0,0,0,0],"cards":[],"reserve":[],"nobles":[],"vp":0,"token_count":0,"card_count":0},"p2":{"tokens":[0,0,0,0,0,0],"bonus":[0,0,0,0,0],"cards":[],"reserve":[],"nobles":[],"vp":0,"token_count":0,"card_count":0},"p3":{"tokens":[0,0,0,0,0,0],"bonus":[0,0,0,0,0],"cards":[],"reserve":[],"nobles":[],"vp":0,"token_count":0,"card_count":0},"p4":{"tokens":[0,0,0,0,0,0],"bonus":[0,0,0,0,0],"cards":[],"reserve":[],"nobles":[],"vp":0,"token_count":0,"card_count":0}}
execute store result storage splendor:engine state.n int 1 run scoreboard players get #players sp_ctx
execute if score #players sp_ctx matches 2 run data modify storage splendor:engine state.bank set value [4,4,4,4,4,5]
execute if score #players sp_ctx matches 3 run data modify storage splendor:engine state.bank set value [5,5,5,5,5,5]
function splendor:engine/init_decks
data modify entity @s data.splendor set from storage splendor:engine state
scoreboard players set #ok sp_ctx 1
scoreboard players set #error sp_ctx 0
