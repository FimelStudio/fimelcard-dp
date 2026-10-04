# Q键施法工具使用独立输入序号，不改变真实手牌或现有回合。
scoreboard objectives add ab_input dummy
scoreboard players set #input_nonce ab_ctx 0
scoreboard players set #version ab_ctx 6
