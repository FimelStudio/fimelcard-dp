# 局数过场完成，先生成由小变大的牌盒
scoreboard players set @s fc_phase 1
scoreboard players set @s fc_timer 0
scoreboard players set @s fc_deal 0
function fast_card:deal/clear_legacy_box
function cardtable:animation/deal/box/clear
function cardtable:animation/deal/box/spawn
function fast_card:log {text:"局数过场结束，开始播放牌盒出现动画"}
