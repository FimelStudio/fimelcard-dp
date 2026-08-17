$dialog show @a[tag=lh.swap_actor,limit=1] {\
    type:"minecraft:notice",\
    title:{text:"选择新手牌",color:"gold"},\
    after_action:"close",\
    can_close_with_escape:false,\
    pause:false,\
    body:[\
        {type:"minecraft:plain_message",width:600,contents:[{text:"选择一张新牌：\n\n\n\n\n",color:"white"},$(card1),{text:"   "},$(card2),{text:"   "},$(card3),{text:"\n\n\n\n\n"}]},\
        {type:"minecraft:plain_message",width:600,contents:{text:"点击候选牌完成更换；三张候选与被换掉的手牌都会离开本局牌库。",color:"white"}},\
        {type:"minecraft:plain_message",width:600,contents:[{text:"手牌                         ",color:"aqua"},{text:"当前已翻开的公共牌\n\n\n\n\n",color:"gold"},$(other_hand),{text:"        ",color:"white"},$(public_empty),$(public1),{text:"  "},$(public2),{text:"  "},$(public3),{text:"  "},$(public4),{text:"  "},$(public5),{text:"\n\n\n\n\n"}]}\
    ],\
    action:{label:{text:"退出并默认选择第一张",color:"gray"},action:{type:"minecraft:run_command",command:"trigger lh_swap_pick set 1"}}\
}
