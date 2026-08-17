# 标题模板与动画库生成的正式实体都使用vertical，保证玩家从各座位观看时始终朝向视线
$summon minecraft:text_display ~ ~ ~ {data:{liars_holdem:{transition_template:1b}},text:[{text:"第 ",color:"red",bold:true},{text:"$(round)",color:"gold",bold:true},{text:" 局",color:"red",bold:true}],billboard:"vertical",see_through:0b}
function liars_holdem:transition/load_template
