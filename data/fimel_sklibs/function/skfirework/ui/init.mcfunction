
data modify storage fimel_skform:runtime reg.form.skfirework_ui set value [\
    {text:"\n\u00a76———————★颜色选择页面★———————\u00a7r"},\
    {text:"\n\u00a77提示：点击下方颜色块即可复制颜色代码\u00a7r\n"},\
    {text:"█",color:"#AA0000",click_event:{action:"copy_to_clipboard",value:"11141120"}},\
    {text:"█",color:"#FF5555",click_event:{action:"copy_to_clipboard",value:"16733525"}},\
    {text:"█",color:"#FFAA00",click_event:{action:"copy_to_clipboard",value:"16755200"}},\
    {text:"█",color:"#EB7114",click_event:{action:"copy_to_clipboard",value:"15429908"}},\
    {text:"█",color:"#DDD605",click_event:{action:"copy_to_clipboard",value:"14538245"}},\
    {text:"█",color:"#FFFF55",click_event:{action:"copy_to_clipboard",value:"16777045"}},\
    {text:"█",color:"#55FF55",click_event:{action:"copy_to_clipboard",value:"5635925"}},\
    {text:"█",color:"#47A036",click_event:{action:"copy_to_clipboard",value:"4694070"}},\
    {text:"█",color:"#00AA00",click_event:{action:"copy_to_clipboard",value:"43520"}},\
    {text:"█",color:"#55FFFF",click_event:{action:"copy_to_clipboard",value:"5636095"}},\
    {text:"█",color:"#00AAAA",click_event:{action:"copy_to_clipboard",value:"43690"}},\
    {text:"█",color:"#5555FF",click_event:{action:"copy_to_clipboard",value:"5592575"}},\
    {text:"█",color:"#0000AA",click_event:{action:"copy_to_clipboard",value:"170"}},\
    {text:"█",color:"#AA00AA",click_event:{action:"copy_to_clipboard",value:"11141290"}},\
    {text:"█",color:"#FF55FF",click_event:{action:"copy_to_clipboard",value:"16733695"}},\
    {text:"█",color:"#9A5CC6",click_event:{action:"copy_to_clipboard",value:"10116294"}},\
    {text:"█",color:"#FFFFFF",click_event:{action:"copy_to_clipboard",value:"16777215"}},\
    {text:"█",color:"#E3D4D1",click_event:{action:"copy_to_clipboard",value:"14931153"}},\
    {text:"█",color:"#CECACA",click_event:{action:"copy_to_clipboard",value:"13552330"}},\
    {text:"█",color:"#AAAAAA",click_event:{action:"copy_to_clipboard",value:"11184810"}},\
    {text:"█",color:"#443A3B",click_event:{action:"copy_to_clipboard",value:"4471355"}},\
    {text:"█",color:"#000000",click_event:{action:"copy_to_clipboard",value:"0"}},\
    {text:"\n\u00a76———————★烟花配置页面★———————\u00a7r"},\
    {text:"\n\u00a77提示：点击黄色数字即可输入数字\n点击颜色块然后粘贴颜色代码即可输入颜色\u00a7r"},\
    {text:"\n☆升空时间(tick):"},{type:"int",key:"launch_time",min:1,default:30},\
    {text:"\n☆分散枝数:"},{type:"int",key:"n_0",min:1,max:100,default:20},\
    {text:"\n☆烟花叠加数量:"},{type:"int",key:"n_1",min:1,max:10,default:1},\
    {text:"\n☆偏航角/俯仰角随机区间:["},{type:"int",key:"pitch_0",min:-180,max:180,default:-180},{text:", "},{type:"int",key:"pitch_1",min:-180,max:180,default:180},{text:"] "},\
    {text:"["},{type:"int",key:"yaw_0",min:-90,max:90,default:-90},{text:", "},{type:"int",key:"yaw_1",min:-90,max:90,default:-20},{text:"] "},\
    {text:"\n☆爆炸延时随机区间:["},{type:"int",key:"time_0",min:1,max:90,default:20},{text:", "},{type:"int",key:"time_1",min:1,max:90,default:60},{text:"] "},\
    {text:"\n☆初速度/重力加速度 v="},{type:"int",key:"v",min:0,max:2000,default:400},\
    {text:"*10^-3 b/tick, g="},{type:"int",key:"g",min:0,max:200,default:10},{text:"*10^-3 b/tick^2"},\
    {text:"\n☆随机烟花颜色",hover_event:{action:"show_text",value:[{text:"提示: 一共有三组渐变色，烟花爆炸时会随机选择一组颜色\n点击颜色块然后粘贴颜色代码即可输入颜色"}]}},\
    {text:" 1:["},{type:"color",key:"color_1_from"},{text:", "},{type:"color",key:"color_1_to"},{text:"]"},\
    {text:" 2:["},{type:"color",key:"color_2_from"},{text:", "},{type:"color",key:"color_2_to"},{text:"]"},\
    {text:" 3:["},{type:"color",key:"color_3_from"},{text:", "},{type:"color",key:"color_3_to"},{text:"]"},\
    {text:"\n☆烟花形状:"},{type:"radio",key:"shape",values:["[小球]","[大球]","[星状]","[苦力怕]","[爆发状]"],fg_0:"#FFB6C1",fg_1:"#FF1493"},\
    {text:"\n☆轨迹粒子:"},{type:"radio",key:"trail_color",values:["[末地烛(白色)]","[火焰(橙色)]","[龙息(紫色)]"],fg_0:"#FFB6C1",fg_1:"#FF1493"},\
    {text:"\n☆额外效果:"},{type:"checkbox",key:"effect",values:["[闪烁]","[踪迹]","[TNT爆炸效果]"],fg_0:"#FFB6C1",fg_1:"#FF1493"},\
    {text:"\n[☆点击获得烟花]",color:"#E3D4D1",click_event:{action:"run_command",command:"/trigger fcs_fw_trigger set 1"}},\
    {text:"\n[☆点击获得烟花并关闭菜单]",color:"#E3D4D1",click_event:{action:"run_command",command:"/trigger fcs_form_submit set 1"}},\
    {text:"\n\u00a76——————————————————————\u00a7r"},\
]

