# Animated Java接入点：以后可替换本函数的表现，但不得在动画中重新随机lh_gun_result
function liars_holdem:transition/gun
function liars_holdem:sound/gun_ready
execute as @a[tag=lh.gun_target,limit=1] run title @s actionbar [{text:'左轮中有 ',color:'gray'},{score:{name:'@s',objective:'lh_bullets'},color:'red'},{text:' 发子弹……',color:'gray'}]
