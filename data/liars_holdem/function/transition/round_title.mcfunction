# 把局数先写入宏参数，标题作为一个动画实例生成，避免分离后的score组件失去控制器上下文
execute store result storage liars_holdem:transition round int 1 run scoreboard players get @s lh_round
function liars_holdem:transition/round_title_render with storage liars_holdem:transition
function liars_holdem:sound/round_start
