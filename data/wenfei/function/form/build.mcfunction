# @s 为本桌控制器，只通过授权后的玩家入口调用。
data modify storage wenfei:form dialog set value {"type":"minecraft:confirmation","title":{"text":"问非所答·秘密回答","color":"gold"},"body":[{"type":"minecraft:plain_message","width":430,"contents":{"text":""}},{"type":"minecraft:plain_message","width":430,"contents":{"text":"只写答案，不抄问题。最多64个字符；全部回答者提交后才公开。关闭不保存，提交需要OP权限。","color":"gray"}}],"inputs":[{"type":"minecraft:text","key":"a","label":{"text":"你的答案"},"width":360,"max_length":64,"initial":""}],"pause":false,"yes":{"label":{"text":"锁定答案","color":"green"},"action":{"type":"minecraft:dynamic/run_command","template":""}},"no":{"label":{"text":"关闭"}}}
data modify storage wenfei:form dialog.body[0].contents.text set from entity @s data.wenfei.correct.text
data modify storage wenfei:form a set value "$(a)"
function wenfei:form/template with storage wenfei:form
