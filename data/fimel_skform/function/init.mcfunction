

scoreboard objectives add fcs_form_submit trigger

data modify storage fimel_skform:runtime reg.form.test set value [\
    {type:"text",text:"请输入数字:"},{type:"int",key:"int1"},\
    {type:"text",text:"\n请输入数字:"},{type:"int",key:"int2",fg:"#39C5BB",max:10,min:1},\
    {type:"text",text:"\n选择选项: "},{type:"radio",key:"radio1",values:["选项1","选项2","选项3"]},\
    {type:"text",text:"\n复选框: "},{type:"checkbox",key:"ckb1",values:["选项1","选项2","选项3"]},\
    {type:"text",text:"\n颜色按钮: "},{type:"color",key:"col"},\
    {type:"text",text:"\n[Submit]",click_event:{action:"run_command",command:"/trigger fcs_form_submit set 1"}}\
]
