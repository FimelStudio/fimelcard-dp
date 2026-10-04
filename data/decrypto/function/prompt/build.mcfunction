# 每次打开生成新令牌，拒绝旧窗口和上一回合的提交。
scoreboard players add #form_sequence dc_ctx 1
scoreboard players operation @s dc_form = #form_sequence dc_ctx
execute store result storage decrypto:form table int 1 run scoreboard players get @s dc_id
execute store result storage decrypto:form token int 1 run scoreboard players get @s dc_form
data modify storage decrypto:form dialog set value {"type":"minecraft:confirmation","title":{"text":"谍报风云·填写提示","color":"aqua","bold":true},"body":[{"type":"minecraft:plain_message","width":430,"contents":{"text":""}},{"type":"minecraft:plain_message","width":430,"contents":{"text":""}},{"type":"minecraft:plain_message","width":430,"contents":{"text":"每个数字对应一条提示。每条最多24个字符，不能为空；关闭不保存。提交需要OP权限。","color":"gray"}}],"inputs":[{"type":"minecraft:text","key":"a","label":{"text":""},"width":360,"max_length":24,"initial":""},{"type":"minecraft:text","key":"b","label":{"text":""},"width":360,"max_length":24,"initial":""},{"type":"minecraft:text","key":"c","label":{"text":""},"width":360,"max_length":24,"initial":""}],"pause":false,"yes":{"label":{"text":"提交三条提示","color":"green"},"action":{"type":"minecraft:dynamic/run_command","template":""}},"no":{"label":{"text":"关闭"}}}
execute if score @s dc_state matches 2 store result storage decrypto:form d1 int 1 run scoreboard players get @s dc_w1
execute if score @s dc_state matches 2 store result storage decrypto:form d2 int 1 run scoreboard players get @s dc_w2
execute if score @s dc_state matches 2 store result storage decrypto:form d3 int 1 run scoreboard players get @s dc_w3
execute if score @s dc_state matches 2 run data modify storage decrypto:form dialog.body[1].contents set from entity @s data.decrypto.keywords.white
execute if score @s dc_state matches 4 store result storage decrypto:form d1 int 1 run scoreboard players get @s dc_b1
execute if score @s dc_state matches 4 store result storage decrypto:form d2 int 1 run scoreboard players get @s dc_b2
execute if score @s dc_state matches 4 store result storage decrypto:form d3 int 1 run scoreboard players get @s dc_b3
execute if score @s dc_state matches 4 run data modify storage decrypto:form dialog.body[1].contents set from entity @s data.decrypto.keywords.black
data modify storage decrypto:form a set value "$(a)"
data modify storage decrypto:form b set value "$(b)"
data modify storage decrypto:form c set value "$(c)"
function decrypto:prompt/labels with storage decrypto:form
