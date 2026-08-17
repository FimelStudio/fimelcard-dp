$dialog show @a[tag=ct.settings_actor,limit=1] {\
    type:"minecraft:confirmation",\
    title:{text:"赌命德州扑克设置",color:"red"},\
    body:[{type:"minecraft:plain_message",contents:[{text:"开枪动画目前使用文字、粒子和音效占位。",color:"yellow"},{text:"以后接入Animated Java时只需替换gun/animation接口，判定逻辑无需修改。",color:"gray"}],width:380}],\
    inputs:[{type:"minecraft:number_range",key:"gun_time",label:{text:"扣动扳机到公布结果的等待时间（秒）"},start:1,end:5,step:1,initial:$(gun_time),width:320}],\
    pause:false,\
    yes:{label:{text:"保存",color:"green"},action:{type:"minecraft:dynamic/run_command",template:"trigger lh_settings set $(gun_time)"}},\
    no:{label:{text:"取消"},action:{type:"minecraft:run_command",command:"trigger lh_settings set 0"}}\
}
