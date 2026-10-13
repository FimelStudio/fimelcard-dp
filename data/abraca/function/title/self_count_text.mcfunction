# 将本人的数字写成文字快照，避免共享临时记分被下一位玩家覆盖。
$data modify storage fimel_title:io text set value {text:"你手上有 $(self_count) 张牌",color:"gold",shadow_color:0}
