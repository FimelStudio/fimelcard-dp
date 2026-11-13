function weiqi:system/context
tellraw @a[tag=go.audience] {"text": "[围棋] 座椅骑乘失败，请重新入座后开始。", "color": "red"}
execute as @a[tag=go.audience] run function weiqi:player/clear_state
