kill @e[type=minecraft:item,tag=dc.note_drop,limit=1]
function decrypto:input/give_notes
execute if score @s dc_team matches 1 run function decrypto:notes/show_white_self
execute if score @s dc_team matches 2 run function decrypto:notes/show_black_self
