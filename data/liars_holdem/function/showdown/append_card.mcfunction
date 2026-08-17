$scoreboard players operation @s lh_card = @a[tag=lh.reveal_actor,limit=1] lh_b$(key)
function liars_holdem:card/load_definition

# 桌面展示使用白色自定义字体牌图
data modify storage liars_holdem:showdown card set value {text:"?",font:"card:card",color:"white",shadow_color:0}
data modify storage liars_holdem:showdown card.text set from storage liars_holdem:card def.glyph
data modify storage liars_holdem:showdown line append from storage liars_holdem:showdown card

# 聊天只输出“黑桃A”等普通牌名，不发送自定义字体图片
data modify storage liars_holdem:showdown chat_card set value {text:"?",color:"white"}
data modify storage liars_holdem:showdown chat_card.text set from storage liars_holdem:card def.name
data modify storage liars_holdem:showdown chat append from storage liars_holdem:showdown chat_card
$data modify storage liars_holdem:showdown chat append value {text:"$(separator)",color:"gray"}
