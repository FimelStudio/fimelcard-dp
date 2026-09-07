$dialog show @a[tag=ct.settings_actor,limit=1] {\
    type:"minecraft:confirmation",\
    title:{text:"谍报风云游戏设置",color:"aqua",bold:true},\
    body:[\
        {type:"minecraft:plain_message",width:410,contents:{text:"回合上限仅用于四人模式。若双方都未提前达成标记胜负条件，完成设定轮数后本局立即结束；三人模式仍固定为五轮。",color:"gray"}}\
    ],\
    inputs:[\
        {type:"minecraft:number_range",key:"rounds",label:{text:"四人模式回合数"},start:1,end:32,step:1,initial:$(rounds_initial),width:320}\
    ],\
    pause:false,\
    yes:{label:{text:"保存",color:"green"},action:{type:"minecraft:dynamic/run_command",template:"trigger dc_settings set $(rounds)"}},\
    no:{label:{text:"取消"},action:{type:"minecraft:run_command",command:"trigger dc_settings set 0"}}\
}
