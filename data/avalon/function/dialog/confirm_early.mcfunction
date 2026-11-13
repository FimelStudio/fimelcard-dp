scoreboard players operation #nonce av_ctx = @s av_ui_base
data modify storage avalon:ui dialog set value {"type":"minecraft:multi_action","title":{"text":"确认提前翻牌？","color":"red"},"body":[{"type":"minecraft:plain_message","contents":{"text":"确认后公开刺客身份并停止当前流程。刺杀不中梅林则好人立即获胜。"}}],"actions":[],"exit_action":{"label":{"text":"取消（Q重开）"}},"pause":false}
function avalon:dialog/button {code:41,label:"确认翻牌，进入刺杀"}
function avalon:dialog/button {code:99,label:"取消"}
scoreboard players set @s av_action 0
scoreboard players enable @s av_action
function avalon:dialog/show with storage avalon:ui
tag @s remove av.actor
tag @e[tag=av.current] remove av.current
