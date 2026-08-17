# 17张牌飞出后先让牌盒由大变小，留出时间让最后一张牌完成拾取
function fast_card:log {text:"17张牌已经飞出，开始播放牌盒消失动画"}
scoreboard players set @s fc_phase 3
scoreboard players set @s fc_timer 0
function cardtable:animation/deal/box/shrink
