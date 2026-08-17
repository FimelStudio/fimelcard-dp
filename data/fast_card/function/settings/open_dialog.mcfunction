$dialog show @a[tag=ct.settings_actor,limit=1] {\
    "type": "minecraft:confirmation",\
    "title": {"text": "Fast Card 游戏设置", "color": "gold"},\
    "body": [\
        {\
            "type": "minecraft:plain_message",\
            "contents": {"text": "这些设置只属于当前牌桌的Fast Card游戏；切换到其他游戏不会覆盖它们。"},\
            "width": 360\
        }\
    ],\
    "inputs": [\
        {\
            "type": "minecraft:number_range",\
            "key": "rounds",\
            "label": {"text": "本场小局数"},\
            "start": 1,\
            "end": 32,\
            "step": 1,\
            "initial": $(rounds_initial),\
            "width": 300\
        },\
        {\
            "type": "minecraft:boolean",\
            "key": "false_press_penalty",\
            "label": {"text": "无有效牌型乱按时立即判负"},\
            "initial": $(false_press_initial),\
            "on_true": "2",\
            "on_false": "1"\
        }\
    ],\
    "pause": false,\
    "yes": {\
        "label": {"text": "保存", "color": "green"},\
        "action": {\
            "type": "minecraft:dynamic/run_command",\
            "template": "trigger fc_settings set $(false_press_penalty)$(rounds)"\
        }\
    },\
    "no": {\
        "label": {"text": "取消"},\
        "action": {\
            "type": "minecraft:run_command",\
            "command": "trigger fc_settings set 0"\
        }\
    }\
}
