$say $(text) $(log)
#dialog show @s {\
    type: "notice",\
    after_action:"none",\
    pause:false,\
    title:"Switch Card",\
    body:\
    [\
        {\
            type:"plain_message",\
            width: 300,\
            contents:\
            [\
                {\
                    text:"点击卡牌进行更换"\
                },\
                {\
                    text:"\n\n\n\n\n\n"\
                },\
                {\
                    text:"\u0102",\
                    font:"card:card",\
                    shadow_color:0,\
                    click_event:\
                    {\
                        action:"run_command",\
                        command:"tellraw @a \"1\""\
                    }\
                },\
                {\
                    text:"     "\
                },\
                {\
                    text:"\u0203",\
                    font:"card:card",\
                    shadow_color:0,\
                    click_event:\
                    {\
                        action:"run_command",\
                        command:"tellraw @a \"2\""\
                    }\
                },\
                {\
                    text:"     "\
                },\
                {\
                    text:"\u0404",\
                    font:"card:card",\
                    shadow_color:0,\
                    click_event:\
                    {\
                        action:"run_command",\
                        command:"tellraw @a \"3\""\
                    }\
                },\
                {\
                    text:"\n\n\n\n\n\n"\
                }\
            ]\
        }\
    ]\
}
