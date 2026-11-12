scoreboard players set @s dc_seconds 0
function decrypto:player/audience
execute store result storage decrypto:timer notice.round int 1 run scoreboard players get @s dc_round
execute if score @s dc_mode matches 3 unless data entity @s data.decrypto.sync.white.clues run function decrypto:timer/miss_encoding {side:"white",team:1,opponent:2,error:"dc_we",decode:6,intercept:5,name:"合作队"}
execute if score @s dc_mode matches 4 unless data entity @s data.decrypto.sync.white.clues run function decrypto:timer/miss_encoding {side:"white",team:1,opponent:2,error:"dc_we",decode:6,intercept:5,name:"红队"}
execute if score @s dc_mode matches 4 unless data entity @s data.decrypto.sync.black.clues run function decrypto:timer/miss_encoding {side:"black",team:2,opponent:1,error:"dc_be",decode:8,intercept:7,name:"蓝队"}
function decrypto:marker/update
function decrypto:sync/check_win
execute unless score @s dc_state matches 2 run return 0
function decrypto:sync/open_guesses
