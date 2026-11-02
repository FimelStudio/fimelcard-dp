# 为升级前已经开局的桌建立快照，尽量保留旧joined记录中的离线席位。
scoreboard players operation #legacy_joined ct_ctx = @s ct_joined
function cardtable:session/start
execute if score #legacy_joined ct_ctx > @s ct_expected run scoreboard players operation @s ct_expected = #legacy_joined ct_ctx
data modify entity @s data.cardtable.session_legacy set value 1b
