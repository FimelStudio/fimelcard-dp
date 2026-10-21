dialog show @s \
{\
    "type": "minecraft:multi_action",\
    "title": {"text": "发送表情包/语音", "color": "white", "bold": true},\
    "body": [\
        {"type": "minecraft:plain_message", "contents": [\
            {"text": "表情包\n\n\n\n", "color": "gray"},\
            {"text":"\ue001","font":"meme:meme","click_event":{action:"run_command",command:"tellraw @a [{text:\"\\n\\n\\n\"},{text:\"\\ue001\",font:\"meme:meme\"},{text:\"\\n\\n\\n\"}]"}},\
            {"text":"\ue002","font":"meme:meme","click_event":{action:"run_command",command:"tellraw @a [{text:\"\\n\\n\\n\"},{text:\"\\ue002\",font:\"meme:meme\"},{text:\"\\n\\n\\n\"}]"}},\
            {"text":"\ue003","font":"meme:meme","click_event":{action:"run_command",command:"tellraw @a [{text:\"\\n\\n\\n\"},{text:\"\\ue003\",font:\"meme:meme\"},{text:\"\\n\\n\\n\"}]"}},\
            {"text":"\ue004","font":"meme:meme","click_event":{action:"run_command",command:"tellraw @a [{text:\"\\n\\n\\n\"},{text:\"\\ue004\",font:\"meme:meme\"},{text:\"\\n\\n\\n\"}]"}},\
            ],\
        "width": 480},\
        {"type": "minecraft:plain_message", "contents": [{"text": "\n\n语音", "color": "gray"}], "width": 100},\
        ],\
    "columns": 8,\
    "actions": [\
        {"label": {"text": "得得得得得"},action:{type:"run_command",command:"playsound meme:dedede player @a"}},\
        {"label": {"text": "奶龙大笑"},action:{type:"run_command",command:"playsound meme:nw_laugh player @a"}}\
    ],\
    "exit_action": {"label": "关闭"}\
}
