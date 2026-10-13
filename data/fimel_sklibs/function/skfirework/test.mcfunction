

give @p chicken_spawn_egg[entity_data={id:"marker",Tags:["fimel.skfirework.load"],data:\
{cmd:'function fimel_sklibs:skfirework/fx/launch {\
    config:{\
        life:30,\
        cmdv:[\
            {cmd:"playsound minecraft:entity.firework_rocket.large_blast ambient @a ~ ~ ~ 1000"},\
            {cmd:"function fimel_sklibs:skfirework/fx/spread",\
            args:{config:{\
                t:[40,70],\
                n:6,\
                v:1,\
                g:0.02,\
                tick_cmdv:[{cmd:"particle dragon_breath ~ ~ ~ 0 0 0 0 1 force"}],\
                cmdv:[\
                    {cmd:"playsound minecraft:entity.firework_rocket.large_blast ambient @a ~ ~ ~ 1000"},\
                    {cmd:"summon tnt ~ ~ ~ {fuse:0}"},\
                    {cmd:"function fimel_sklibs:skfirework/fx/spread",\
                    args:{config:{\
                        n:30,\
                        v:0.5,\
                        g:0.01,\
                        tick_cmdv:[{cmd:"particle flame ~ ~ ~ 0 0 0 0 1 force"}],\
                        cmdv:[\
                            {cmd:"function fimel_sklibs:skfirework/fx/firework",\
                            args:{config:{\
                            shape:0,\
                            twinkle: 1,\
                            colors:[{from:[I;13047173],to:[I;16761035]},{from:[I;16766720],to:[I;16777184]}],\
                            n:1\
                        }}}]\
                }}}]\
        }}}]\
    }\
}'}}] 1
