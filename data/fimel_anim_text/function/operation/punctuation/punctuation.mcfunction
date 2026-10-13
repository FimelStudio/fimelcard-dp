## 检测硬编码输入值
execute if data storage fimel_anim_text:runtime operation.punctuation.next.sound run function fimel_anim_text:operation/punctuation/delay/sound
execute if data storage fimel_anim_text:runtime operation.punctuation.next.delay run return run function fimel_anim_text:operation/punctuation/delay/time

## 组件检测
execute if data storage fimel_anim_text:runtime operation.punctuation.next.keybind run return run function fimel_anim_text:operation/punctuation/delay/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next.object run return run function fimel_anim_text:operation/punctuation/delay/3

execute if data storage fimel_anim_text:runtime operation.punctuation.next.translate run return run function fimel_anim_text:operation/punctuation/delay/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next.score run return run function fimel_anim_text:operation/punctuation/delay/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next.selector run return run function fimel_anim_text:operation/punctuation/delay/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next.nbt run return run function fimel_anim_text:operation/punctuation/delay/3

## 极强停顿
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"…"} run return run function fimel_anim_text:operation/punctuation/skip/20
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"。"} run return run function fimel_anim_text:operation/punctuation/skip/20
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"."} run return run function fimel_anim_text:operation/punctuation/skip/20
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"！"} run return run function fimel_anim_text:operation/punctuation/skip/20
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"!"} run return run function fimel_anim_text:operation/punctuation/skip/20
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"？"} run return run function fimel_anim_text:operation/punctuation/skip/20
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"?"} run return run function fimel_anim_text:operation/punctuation/skip/20

## 强停顿
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"；"} run return run function fimel_anim_text:operation/punctuation/skip/12
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:";"} run return run function fimel_anim_text:operation/punctuation/skip/12
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"："} run return run function fimel_anim_text:operation/punctuation/skip/12
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:":"} run return run function fimel_anim_text:operation/punctuation/skip/12

## 中停顿
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"，"} run return run function fimel_anim_text:operation/punctuation/skip/8
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:","} run return run function fimel_anim_text:operation/punctuation/skip/8

## 弱停顿
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"、"} run return run function fimel_anim_text:operation/punctuation/skip/5

## 无停顿
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:" "} run return run function fimel_anim_text:operation/punctuation/skip/3

# 点与连字符
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"·"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"-"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"_"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"~"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"——"} run return run function fimel_anim_text:operation/punctuation/skip/3

# 分隔线
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"/"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"\\"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"｜"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"｜"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"︱"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"︳"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"︴"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"¦"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"‖"} run return run function fimel_anim_text:operation/punctuation/skip/3

# 括号与引号
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"“"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"”"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"‘"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"’"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:'"'} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"'"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"「"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"」"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"『"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"』"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"["} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"]"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"{"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"}"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"("} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:")"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"《"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"》"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"【"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"】"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"〖"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"〗"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"〈"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"〉"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"〔"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"〕"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"﹙"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"﹚"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"﹛"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"﹜"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"﹝"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"﹞"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"﹞"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"‹"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"›"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"«"} run return run function fimel_anim_text:operation/punctuation/skip/3
execute if data storage fimel_anim_text:runtime operation.punctuation.next{text:"»"} run return run function fimel_anim_text:operation/punctuation/skip/3