function liars_holdem:transition/cleanup
# 临时模板和动画库正式实体都声明vertical，确保只绕垂直轴朝向观察者
summon minecraft:text_display ~ ~ ~ {data:{liars_holdem:{transition_template:1b}},text:{text:'摊　牌',color:'gold',bold:true},billboard:"vertical",see_through:0b}
function liars_holdem:transition/load_template
