execute if entity @e[tag=ma.current,scores={ma_anim=1..},limit=1] run return run function magical_athlete:direct/busy
execute if score @s ma_confirm = #code ma_ctx if score @s ma_cepoch = @e[tag=ma.current,limit=1] ma_epoch run return run function magical_athlete:direct/submit
scoreboard players operation @s ma_confirm = #code ma_ctx
scoreboard players operation @s ma_cepoch = @e[tag=ma.current,limit=1] ma_epoch
function magical_athlete:hud/notice {"text":{"text":"已选中：再次右键或按Q确认，左键取消。","color":"aqua"}}
playsound minecraft:ui.button.click master @s ~ ~ ~ 0.5 1.3
function magical_athlete:direct/highlight
function magical_athlete:direct/confirm_details
