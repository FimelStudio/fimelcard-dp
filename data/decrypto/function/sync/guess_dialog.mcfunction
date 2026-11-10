scoreboard players operation @s dc_sform = @e[tag=dc.sync_controller,limit=1] dc_form
scoreboard players set @s dc_action 0
scoreboard players enable @s dc_action
function decrypto:sync/duties
data modify storage decrypto:sync dialog set value {"type": "minecraft:confirmation", "title": {"text": "谍报风云 · 同步提交"}, "body": [], "inputs": [], "yes": {"label": {"text": "提交答案"}, "action": {"type": "minecraft:dynamic/run_command", "template": ""}}, "no": {"label": {"text": "暂时关闭"}}, "pause": false}
execute store result storage decrypto:sync table int 1 run scoreboard players get @s dc_id
execute store result storage decrypto:sync token int 1 run scoreboard players get @e[tag=dc.sync_controller,limit=1] dc_form
execute if score @s dc_team matches 1 if score #decode dc_ctx matches 1 run data modify storage decrypto:sync row set value {"type": "minecraft:plain_message", "contents": {"text": "己方解密提示：", "extra": []}, "width": 440}
execute if score @s dc_team matches 1 if score #decode dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra set value []
execute if score @s dc_team matches 1 if score #decode dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra append value {text:"  1："}
execute if score @s dc_team matches 1 if score #decode dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra append from entity @e[tag=dc.sync_controller,limit=1] data.decrypto.sync.white.clues[0]
execute if score @s dc_team matches 1 if score #decode dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra append value {text:"  2："}
execute if score @s dc_team matches 1 if score #decode dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra append from entity @e[tag=dc.sync_controller,limit=1] data.decrypto.sync.white.clues[1]
execute if score @s dc_team matches 1 if score #decode dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra append value {text:"  3："}
execute if score @s dc_team matches 1 if score #decode dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra append from entity @e[tag=dc.sync_controller,limit=1] data.decrypto.sync.white.clues[2]
execute if score @s dc_team matches 1 if score #decode dc_ctx matches 1 run data modify storage decrypto:sync dialog.body append from storage decrypto:sync row
execute if score @s dc_team matches 1 if score #intercept dc_ctx matches 1 run data modify storage decrypto:sync row set value {"type": "minecraft:plain_message", "contents": {"text": "对方拦截提示：", "extra": []}, "width": 440}
execute if score @s dc_team matches 1 if score #intercept dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra set value []
execute if score @s dc_team matches 1 if score #intercept dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra append value {text:"  1："}
execute if score @s dc_team matches 1 if score #intercept dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra append from entity @e[tag=dc.sync_controller,limit=1] data.decrypto.sync.black.clues[0]
execute if score @s dc_team matches 1 if score #intercept dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra append value {text:"  2："}
execute if score @s dc_team matches 1 if score #intercept dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra append from entity @e[tag=dc.sync_controller,limit=1] data.decrypto.sync.black.clues[1]
execute if score @s dc_team matches 1 if score #intercept dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra append value {text:"  3："}
execute if score @s dc_team matches 1 if score #intercept dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra append from entity @e[tag=dc.sync_controller,limit=1] data.decrypto.sync.black.clues[2]
execute if score @s dc_team matches 1 if score #intercept dc_ctx matches 1 run data modify storage decrypto:sync dialog.body append from storage decrypto:sync row
execute if score @s dc_team matches 1 if score #decode dc_ctx matches 1 run data modify storage decrypto:sync row.contents set from entity @e[tag=dc.sync_controller,limit=1] data.decrypto.keywords.white
execute if score @s dc_team matches 1 if score #decode dc_ctx matches 1 run data modify storage decrypto:sync dialog.body append from storage decrypto:sync row
execute if score @s dc_team matches 2 if score #decode dc_ctx matches 1 run data modify storage decrypto:sync row set value {"type": "minecraft:plain_message", "contents": {"text": "己方解密提示：", "extra": []}, "width": 440}
execute if score @s dc_team matches 2 if score #decode dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra set value []
execute if score @s dc_team matches 2 if score #decode dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra append value {text:"  1："}
execute if score @s dc_team matches 2 if score #decode dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra append from entity @e[tag=dc.sync_controller,limit=1] data.decrypto.sync.black.clues[0]
execute if score @s dc_team matches 2 if score #decode dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra append value {text:"  2："}
execute if score @s dc_team matches 2 if score #decode dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra append from entity @e[tag=dc.sync_controller,limit=1] data.decrypto.sync.black.clues[1]
execute if score @s dc_team matches 2 if score #decode dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra append value {text:"  3："}
execute if score @s dc_team matches 2 if score #decode dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra append from entity @e[tag=dc.sync_controller,limit=1] data.decrypto.sync.black.clues[2]
execute if score @s dc_team matches 2 if score #decode dc_ctx matches 1 run data modify storage decrypto:sync dialog.body append from storage decrypto:sync row
execute if score @s dc_team matches 2 if score #intercept dc_ctx matches 1 run data modify storage decrypto:sync row set value {"type": "minecraft:plain_message", "contents": {"text": "对方拦截提示：", "extra": []}, "width": 440}
execute if score @s dc_team matches 2 if score #intercept dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra set value []
execute if score @s dc_team matches 2 if score #intercept dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra append value {text:"  1："}
execute if score @s dc_team matches 2 if score #intercept dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra append from entity @e[tag=dc.sync_controller,limit=1] data.decrypto.sync.white.clues[0]
execute if score @s dc_team matches 2 if score #intercept dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra append value {text:"  2："}
execute if score @s dc_team matches 2 if score #intercept dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra append from entity @e[tag=dc.sync_controller,limit=1] data.decrypto.sync.white.clues[1]
execute if score @s dc_team matches 2 if score #intercept dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra append value {text:"  3："}
execute if score @s dc_team matches 2 if score #intercept dc_ctx matches 1 run data modify storage decrypto:sync row.contents.extra append from entity @e[tag=dc.sync_controller,limit=1] data.decrypto.sync.white.clues[2]
execute if score @s dc_team matches 2 if score #intercept dc_ctx matches 1 run data modify storage decrypto:sync dialog.body append from storage decrypto:sync row
execute if score @s dc_team matches 2 if score #decode dc_ctx matches 1 run data modify storage decrypto:sync row.contents set from entity @e[tag=dc.sync_controller,limit=1] data.decrypto.keywords.black
execute if score @s dc_team matches 2 if score #decode dc_ctx matches 1 run data modify storage decrypto:sync dialog.body append from storage decrypto:sync row
execute if score #decode dc_ctx matches 1 run data modify storage decrypto:sync dialog.inputs append value {"type": "minecraft:text", "key": "d", "label": {"text": "己方解密（如123，三个不同的1～4）"}, "max_length": 3, "width": 350, "initial": ""}
data modify storage decrypto:sync d set value "000"
execute if score #decode dc_ctx matches 1 run data modify storage decrypto:sync d set value "$(d)"
execute if score #intercept dc_ctx matches 1 run data modify storage decrypto:sync dialog.inputs append value {"type": "minecraft:text", "key": "i", "label": {"text": "对方拦截（如123，三个不同的1～4）"}, "max_length": 3, "width": 350, "initial": ""}
data modify storage decrypto:sync i set value "000"
execute if score #intercept dc_ctx matches 1 run data modify storage decrypto:sync i set value "$(i)"
function decrypto:sync/guess_template with storage decrypto:sync
function decrypto:sync/show with storage decrypto:sync
