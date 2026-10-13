

$give @s minecraft:chicken_spawn_egg[minecraft:item_model="minecraft:firework_rocket",\
                            minecraft:item_name={text:"自定义烟花"},\
                            minecraft:entity_data={id:"minecraft:marker",Tags:["fimel.skfirework.load"],data:{cmd:'\
function fimel_sklibs:skfirework/fx/launch {\
    config:{\
        life:$(launch_time),\
        cmdv:[\
            {cmd:"playsound minecraft:entity.firework_rocket.large_blast ambient @a ~ ~ ~ 1000"},\
            {cmd:"$(tnt)"},\
            {cmd:"function fimel_sklibs:skfirework/fx/spread",\
            args:{config:{\
                pitch:[$(pitch_0),$(pitch_1)],\
                yaw:[$(yaw_0),$(yaw_1)],\
                t:[$(time_0),$(time_1)],\
                n:$(n_0),\
                v:$(v),\
                g:$(g),\
                tick_cmdv:[{cmd:"particle $(trail_color) ~ ~ ~ 0 0 0 0 1 force"}],\
                cmdv:[\
                    {cmd:"$(tnt)"},\
                    {cmd:"function fimel_sklibs:skfirework/fx/firework",\
                    args:{config:{\
                    n:$(n_1),\
                    trail:$(trail),\
                    twinkle:$(twinkle),\
                    shape:$(shape),\
                    colors:[\
                        {from:[I;$(color_1_from)],to:[I;$(color_1_to)]},\
                        {from:[I;$(color_2_from)],to:[I;$(color_2_to)]},\
                        {from:[I;$(color_3_from)],to:[I;$(color_3_to)]},\
                    ],\
                    n:1\
                }}}]\
        }}}]\
    }\
}\
'}}] 1
