execute store result score #word_count dc_ctx run data get storage decrypto:words remaining
scoreboard players remove #word_count dc_ctx 1
execute store result storage decrypto:words args.max int 1 run scoreboard players get #word_count dc_ctx
function decrypto:words/roll with storage decrypto:words args
function decrypto:words/take with storage decrypto:words args
