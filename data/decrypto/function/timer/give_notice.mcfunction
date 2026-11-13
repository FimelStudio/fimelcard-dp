clear @s minecraft:purple_dye[minecraft:custom_data~{decrypto:{tool:'timeout'}}]
$give @s minecraft:purple_dye[minecraft:item_name={text:"第 $(round) 回合加密超时（按Q查看）",color:"red"},minecraft:custom_data={decrypto:{tool:'timeout',round:$(round)}},minecraft:max_stack_size=1]
