clear @s minecraft:writable_book[minecraft:custom_data~{decrypto:{clue:1b}}]
give @s minecraft:writable_book[minecraft:item_name='提示册（每页一条，按Q提交）',minecraft:custom_data={decrypto:{clue:1b}},minecraft:writable_book_content={pages:['','','']},minecraft:lore=[{text:'第1、2、3页依次填写三条提示。',color:'gray'},{text:'点击完成保存，不要签名；按Q提交。',color:'yellow'}]]
tellraw @s [{text:'[谍报风云] ',color:'aqua'},{text:'请在提示册第1、2、3页依次填写提示，点击完成后按Q提交。不要签名。',color:'yellow'}]
