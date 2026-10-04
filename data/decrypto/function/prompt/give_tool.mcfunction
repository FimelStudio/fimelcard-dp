clear @s minecraft:purple_dye[minecraft:custom_data~{decrypto:{tool:'prompt'}}]
give @s minecraft:purple_dye[minecraft:item_name='填写电报提示（Q打开）',minecraft:custom_data={decrypto:{tool:'prompt'}},minecraft:enchantment_glint_override=true,minecraft:max_stack_size=1]
tellraw @s {text:'[谍报风云] 按Q丢出紫色染料，查看密码和己方词条，填写三条提示。每条最多24个字符；提交需要OP权限。关闭不保存草稿。',color:'yellow'}
