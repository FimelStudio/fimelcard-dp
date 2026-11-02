execute if score @s sk_state matches 1 run return run function skull:ui/place_hint
data modify storage skull:ui dialog set value {type:"minecraft:multi_action",title:{text:"骷髅牌",color:"gold",bold:true},body:[{type:"minecraft:plain_message",width:460,contents:{text:"花牌＝各自套装的花卉，骷髅＝糖骷髅。扣牌请关闭界面，选中要出的牌按Q。叫号、翻牌和弃牌点击按钮；紫色染料按Q可重开。",color:"gray"}}],actions:[],columns:4,exit_action:{label:{text:"关闭"}},pause:false}
scoreboard players operation #base sk_ctx = @s sk_epoch
scoreboard players operation #base sk_ctx *= #hundred sk_ctx
function skull:ui/load_hand with storage skull:ui view
execute if score @s sk_state matches 2..3 if score @s sk_turn = #view_seat sk_ctx run function skull:ui/bids
execute if score @s sk_state matches 4 if score @s sk_lead = #view_seat sk_ctx run function skull:ui/targets
execute if score @s sk_state matches 5 if score @s sk_lead = #view_seat sk_ctx run function skull:ui/discard
execute unless data storage skull:ui dialog.actions[0] run data modify storage skull:ui dialog.body append value {type:"minecraft:plain_message",contents:{text:"当前无需你操作，请等待聊天栏通知。",color:"yellow"}}
execute as @a[tag=sk.viewer,limit=1] run function skull:ui/show with storage skull:ui
