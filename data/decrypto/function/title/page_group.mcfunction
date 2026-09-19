$data modify storage decrypto:page rows set from storage decrypto:page lines.$(side).$(digit)
execute store result score #row_count dc_ctx run data get storage decrypto:page rows
scoreboard players add #row_count dc_ctx 1
scoreboard players set #two dc_ctx 2
scoreboard players operation #row_count dc_ctx /= #two dc_ctx
execute if score #row_count dc_ctx matches 0 run scoreboard players set #row_count dc_ctx 1
scoreboard players operation #local_page dc_ctx = #page dc_ctx
scoreboard players operation #local_page dc_ctx %= #row_count dc_ctx
execute store result storage decrypto:page args.total int 1 run scoreboard players get #row_count dc_ctx
execute store result storage decrypto:page args.display int 1 run scoreboard players add #local_page dc_ctx 1
scoreboard players remove #local_page dc_ctx 1
scoreboard players operation #local_page dc_ctx *= #two dc_ctx
execute store result storage decrypto:page args.first int 1 run scoreboard players get #local_page dc_ctx
execute store result storage decrypto:page args.second int 1 run scoreboard players add #local_page dc_ctx 1
$data modify storage decrypto:page args.digit set value $(digit)
$data modify storage decrypto:page args.y set value $(y)
function decrypto:title/page_rows with storage decrypto:page args
