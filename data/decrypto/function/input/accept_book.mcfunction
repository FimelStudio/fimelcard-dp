# 整本校验通过后才写入回合；转为纯文本组件以复用笔记和面板。
execute if items entity @e[type=minecraft:item,tag=dc.submitted_book,limit=1] contents minecraft:written_book run return run function decrypto:input/unsigned_book
data modify storage decrypto:input pages set value []
data modify storage decrypto:input pages set from entity @e[type=minecraft:item,tag=dc.submitted_book,limit=1] Item.components."minecraft:writable_book_content".pages
execute store result score #pages dc_ctx run data get storage decrypto:input pages
execute unless score #pages dc_ctx matches 3 run return run function decrypto:input/reject_book
# 兼容字符串页面与{raw:...}形式；不通过宏拼接玩家输入。
data modify storage decrypto:input clues set value [{text:""},{text:""},{text:""}]
data modify storage decrypto:input clues[0].text set from storage decrypto:input pages[0]
execute if data storage decrypto:input pages[0].raw run data modify storage decrypto:input clues[0].text set from storage decrypto:input pages[0].raw
data modify storage decrypto:input clues[1].text set from storage decrypto:input pages[1]
execute if data storage decrypto:input pages[1].raw run data modify storage decrypto:input clues[1].text set from storage decrypto:input pages[1].raw
data modify storage decrypto:input clues[2].text set from storage decrypto:input pages[2]
execute if data storage decrypto:input pages[2].raw run data modify storage decrypto:input clues[2].text set from storage decrypto:input pages[2].raw
execute if data storage decrypto:input clues[{text:""}] run return run function decrypto:input/reject_book
kill @e[type=minecraft:item,tag=dc.submitted_book,limit=1]
tellraw @a[tag=dc.submitter,limit=1] [{text:"[谍报风云] ",color:"aqua"},{text:"三条提示已提交。",color:"green"}]
scoreboard players set @s dc_clue 0
data modify storage decrypto:input name set from storage decrypto:input clues[0]
function decrypto:input/save_prompt
data modify storage decrypto:input name set from storage decrypto:input clues[1]
function decrypto:input/save_prompt
data modify storage decrypto:input name set from storage decrypto:input clues[2]
function decrypto:input/save_prompt
