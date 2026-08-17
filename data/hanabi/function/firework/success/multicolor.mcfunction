# 彩色牌同时使用白、红、蓝、黄、绿五种颜色，数字5完成时升级为双重星形爆炸
data modify storage hanabi:firework success_multi set value {life:17,shape:2,count:1,twinkle:true}
execute if score #played_rank hb_ctx matches 5 run data modify storage hanabi:firework success_multi merge value {life:24,shape:1,count:2,twinkle:true}
function hanabi:firework/success/multicolor_launch with storage hanabi:firework success_multi
