# 宏只插入内部阵营键和数字编号，玩家文字始终通过NBT复制。
$data modify storage decrypto:notes $(side).$(digit) append from storage decrypto:input name
# 接着本编号最后一行未满的位置写入，不在每条提示结束时强制起新行。
$data modify storage decrypto:wrap rows set from entity @s data.decrypto.note_lines.$(side).$(digit)
data modify storage decrypto:wrap line set value {text:"",extra:[]}
scoreboard players set #columns dc_ctx 0
scoreboard players set #last_width dc_ctx 36
execute if data storage decrypto:wrap rows[-1] store result score #last_width dc_ctx run data get storage decrypto:wrap rows[-1].extra
execute if score #last_width dc_ctx matches ..35 run data modify storage decrypto:wrap line set from storage decrypto:wrap rows[-1]
execute if score #last_width dc_ctx matches ..35 run scoreboard players operation #columns dc_ctx = #last_width dc_ctx
execute if score #last_width dc_ctx matches ..35 run data remove storage decrypto:wrap rows[-1]
data modify storage decrypto:wrap character set value "["
function decrypto:title/wrap/character
data modify storage decrypto:wrap remaining set value ""
data modify storage decrypto:wrap remaining set from storage decrypto:input name.text
execute unless data storage decrypto:wrap {remaining:""} run function decrypto:title/wrap/scan
data modify storage decrypto:wrap character set value "]"
function decrypto:title/wrap/character
execute if score #columns dc_ctx matches 1.. run function decrypto:title/wrap/flush
$data modify entity @s data.decrypto.note_lines.$(side).$(digit) set from storage decrypto:wrap rows
$execute store result score #row_count dc_ctx run data get entity @s data.decrypto.note_lines.$(side).$(digit)
scoreboard players add #row_count dc_ctx 1
scoreboard players set #two dc_ctx 2
scoreboard players operation #row_count dc_ctx /= #two dc_ctx
execute if score #row_count dc_ctx > @s dc_pages run scoreboard players operation @s dc_pages = #row_count dc_ctx
