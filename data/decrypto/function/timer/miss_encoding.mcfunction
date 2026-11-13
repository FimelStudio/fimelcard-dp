$scoreboard players add @s $(error) 1
$data modify entity @s data.decrypto.sync.$(side).timed_out set value 1b
# 只填入针对超时队密码的两项答案，另一队密码照常解密和拦截。
$data modify entity @s data.decrypto.sync.answers.p$(decode) set value [-1,-1,-1]
$data modify entity @s data.decrypto.sync.answers.p$(intercept) set value [-1,-1,-1]
$tellraw @a[tag=dc.audience] {text:"[谍报风云] $(name)加密超时，记1次失误。该队密码的解密及对手对该密码的拦截取消。",color:"red"}
$execute as @a[tag=dc.audience,scores={dc_team=$(team),dc_encoder=1}] run function decrypto:timer/clear_encoding
$execute as @a[tag=dc.audience,scores={dc_team=$(team)}] run function decrypto:timer/give_notice with storage decrypto:timer notice
$execute if score @s dc_round matches 2.. as @a[tag=dc.audience,scores={dc_team=$(opponent),dc_role=3}] run function decrypto:timer/give_notice with storage decrypto:timer notice
$execute if score @s dc_round matches 2.. as @a[tag=dc.audience,scores={dc_team=$(opponent),dc_role=1,dc_size=2}] run function decrypto:timer/give_notice with storage decrypto:timer notice
