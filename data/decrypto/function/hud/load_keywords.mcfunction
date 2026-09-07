# 通过同一份题库分别读取白队和黑队抽中的组，避免维护两份重复映射。
scoreboard players operation #wordset dc_ctx = @s dc_wset
function decrypto:hud/load_one_keyword
data modify storage decrypto:hud white set from storage decrypto:hud current
scoreboard players operation #wordset dc_ctx = @s dc_bset
function decrypto:hud/load_one_keyword
data modify storage decrypto:hud black set from storage decrypto:hud current
