# 只根据本桌当前参赛玩家动态生成提示对象；空座位和操作者本人不会进入Dialog
# 提示操作物在进入Dialog时立即归还；即使玩家通过界面返回键直接退出，也能在本回合重新按Q进入
function hanabi:input/give_hint
scoreboard players set @s hb_action 0
scoreboard players enable @s hb_action
scoreboard players operation #ctx_id hb_ctx = @s hb_id
scoreboard players operation #actor_seat hb_ctx = @s hb_seat
scoreboard players set #option_added hb_ctx 0
tag @a[tag=hb.hint_option] remove hb.hint_option
data modify storage hanabi:dialog target_body set value {text:"点击一名其他玩家。提示必须指出其所有同色牌或所有同数字牌。\n\n",color:"gray",extra:[]}

function hanabi:dialog/hint/append_option {seat:1,action:301}
function hanabi:dialog/hint/append_option {seat:2,action:302}
function hanabi:dialog/hint/append_option {seat:3,action:303}
function hanabi:dialog/hint/append_option {seat:4,action:304}
function hanabi:dialog/hint/append_option {seat:5,action:305}
function hanabi:dialog/hint/append_option {seat:6,action:306}
function hanabi:dialog/hint/append_option {seat:7,action:307}
function hanabi:dialog/hint/append_option {seat:8,action:308}

execute unless score #option_added hb_ctx matches 1.. run data modify storage hanabi:dialog target_body.extra append value {text:"当前没有可提示的其他参与者。",color:"red"}
function hanabi:dialog/hint/show_target with storage hanabi:dialog
tag @a[tag=hb.hint_option] remove hb.hint_option
