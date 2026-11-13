$data modify storage avalon:ui dialog.body append value {type:"minecraft:plain_message",width:440,contents:{text:"出征$(need)人 · 队长：",extra:[]}}
data modify storage avalon:ui dialog.body[-1].contents.extra append from storage avalon:names leader
data modify storage avalon:ui dialog.body[-1].contents.extra append value {text:"\n当前队员："}
data modify storage avalon:ui dialog.body[-1].contents.extra append from storage avalon:names team[]
execute if score #state av_ctx matches 1 run data modify storage avalon:ui dialog.body[-1].contents.extra append value {text:"\n组队讨论阶段：队长选人后请讨论，再开始投票。"}
execute if score #state av_ctx matches 2 run data modify storage avalon:ui dialog.body[-1].contents.extra append value {text:"\n组队投票阶段：关闭窗口，Q丢出绿色染料同意、红色染料反对；提交后不能修改。"}
execute if score #state av_ctx matches 3 run data modify storage avalon:ui dialog.body[-1].contents.extra append value {text:"\n秘密任务阶段：队员关闭窗口，Q丢出绿色染料成功、红色染料失败；好人只能成功。"}
execute if score #state av_ctx matches 4 run data modify storage avalon:ui dialog.body[-1].contents.extra append value {text:"\n刺杀阶段：等待刺客选择并确认目标。"}
execute if score #state av_ctx matches 4 if score #role av_ctx matches 5 run data modify storage avalon:ui dialog.body[-1].contents.extra append value {text:"\n当前刺杀目标：",color:"red"}
execute if score #state av_ctx matches 4 if score #role av_ctx matches 5 run data modify storage avalon:ui dialog.body[-1].contents.extra append from storage avalon:names target
