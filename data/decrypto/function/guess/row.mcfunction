$data modify storage decrypto:guess row set value {type:"minecraft:plain_message",width:320,contents:{text:"$(row)．",color:"gold",extra:[]}}
$data modify storage decrypto:guess row.contents.extra append from storage decrypto:guess clues[$(index)]
data modify storage decrypto:guess dialog.body append from storage decrypto:guess row
data modify storage decrypto:guess row.contents set value {text:"",extra:[]}
scoreboard players add #guess_command dc_ctx 1
execute store result storage decrypto:guess button.command int 1 run scoreboard players get #guess_command dc_ctx
data modify storage decrypto:guess button.digit set value 1
data modify storage decrypto:guess button.color set value "white"
execute if score #guess_selected dc_ctx matches 1 run data modify storage decrypto:guess button.color set value "green"
function decrypto:guess/digit_button with storage decrypto:guess button
scoreboard players add #guess_command dc_ctx 1
execute store result storage decrypto:guess button.command int 1 run scoreboard players get #guess_command dc_ctx
data modify storage decrypto:guess button.digit set value 2
data modify storage decrypto:guess button.color set value "white"
execute if score #guess_selected dc_ctx matches 2 run data modify storage decrypto:guess button.color set value "green"
function decrypto:guess/digit_button with storage decrypto:guess button
scoreboard players add #guess_command dc_ctx 1
execute store result storage decrypto:guess button.command int 1 run scoreboard players get #guess_command dc_ctx
data modify storage decrypto:guess button.digit set value 3
data modify storage decrypto:guess button.color set value "white"
execute if score #guess_selected dc_ctx matches 3 run data modify storage decrypto:guess button.color set value "green"
function decrypto:guess/digit_button with storage decrypto:guess button
scoreboard players add #guess_command dc_ctx 1
execute store result storage decrypto:guess button.command int 1 run scoreboard players get #guess_command dc_ctx
data modify storage decrypto:guess button.digit set value 4
data modify storage decrypto:guess button.color set value "white"
execute if score #guess_selected dc_ctx matches 4 run data modify storage decrypto:guess button.color set value "green"
function decrypto:guess/digit_button with storage decrypto:guess button
data modify storage decrypto:guess dialog.body append from storage decrypto:guess row
