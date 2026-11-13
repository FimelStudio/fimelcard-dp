# 局间只清牌面和文字；同一个牌盒从发牌到整场结束一直留在桌心。
scoreboard players operation #vis_table un_ctx = @s ct_id
execute as @e[tag=un.visual,tag=!un.box] if score @s ct_id = #vis_table un_ctx run kill @s
