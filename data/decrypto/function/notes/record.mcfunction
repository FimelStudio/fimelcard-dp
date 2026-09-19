# 宏只插入内部阵营键和数字编号，玩家文字始终通过NBT复制。
$data modify storage decrypto:notes $(side).$(digit) append from storage decrypto:input name
data modify storage decrypto:wrap remaining set value ""
data modify storage decrypto:wrap remaining set from storage decrypto:input name.text
data modify storage decrypto:wrap rows set value []
data modify storage decrypto:wrap line set value {text:"",extra:[]}
scoreboard players set #columns dc_ctx 0
execute unless data storage decrypto:wrap {remaining:""} run function decrypto:title/wrap/scan
execute if score #columns dc_ctx matches 1.. run function decrypto:title/wrap/flush
$data modify entity @s data.decrypto.note_lines.$(side).$(digit) append from storage decrypto:wrap rows[]
$execute store result score #row_count dc_ctx run data get entity @s data.decrypto.note_lines.$(side).$(digit)
scoreboard players add #row_count dc_ctx 1
scoreboard players set #two dc_ctx 2
scoreboard players operation #row_count dc_ctx /= #two dc_ctx
execute if score #row_count dc_ctx > @s dc_pages run scoreboard players operation @s dc_pages = #row_count dc_ctx
