scoreboard players operation #hud_side sp_ctx = @s sp_side
$scoreboard players add #hud_side sp_ctx $(offset)
scoreboard players remove #hud_side sp_ctx 1
scoreboard players operation #hud_side sp_ctx %= #hud_n sp_ctx
scoreboard players add #hud_side sp_ctx 1
$data modify storage splendor:hud placement set value {side:0,x:$(x),y:$(y),origin:"$(origin)",align:"$(align)"}
execute store result storage splendor:hud placement.side int 1 run scoreboard players get #hud_side sp_ctx
function splendor:hud/relative_show with storage splendor:hud placement
