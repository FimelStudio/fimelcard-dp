$data modify storage splendor:hud anchor set value {x:$(x),origin:"$(origin)",align:"$(align)"}
$scoreboard players set #hud_y sp_ctx $(y)
$data modify storage splendor:hud player set from entity @e[tag=sp.current,limit=1] data.splendor.p$(side)
data modify storage splendor:hud row set value {name:{text:"玩家"},vp:0,cards:0,nobles:0,reserved:0,marker:"  ",color:"white"}
data modify storage splendor:hud row.name set from storage splendor:hud player.name
data modify storage splendor:hud row.vp set from storage splendor:hud player.vp
execute store result storage splendor:hud row.cards int 1 run data get storage splendor:hud player.cards
execute store result storage splendor:hud row.nobles int 1 run data get storage splendor:hud player.nobles
execute store result storage splendor:hud row.reserved int 1 run data get storage splendor:hud player.reserve
$execute if score @e[tag=sp.current,limit=1] sp_turn matches $(side) run data modify storage splendor:hud row.marker set value "▶ "
$execute if score @e[tag=sp.current,limit=1] sp_turn matches $(side) run data modify storage splendor:hud row.color set value "yellow"
data modify storage splendor:hud row.t0 set from storage splendor:hud player.tokens[0]
data modify storage splendor:hud row.t1 set from storage splendor:hud player.tokens[1]
data modify storage splendor:hud row.t2 set from storage splendor:hud player.tokens[2]
data modify storage splendor:hud row.t3 set from storage splendor:hud player.tokens[3]
data modify storage splendor:hud row.t4 set from storage splendor:hud player.tokens[4]
data modify storage splendor:hud row.t5 set from storage splendor:hud player.tokens[5]
data modify storage splendor:hud row.b0 set from storage splendor:hud player.bonus[0]
data modify storage splendor:hud row.b1 set from storage splendor:hud player.bonus[1]
data modify storage splendor:hud row.b2 set from storage splendor:hud player.bonus[2]
data modify storage splendor:hud row.b3 set from storage splendor:hud player.bonus[3]
data modify storage splendor:hud row.b4 set from storage splendor:hud player.bonus[4]
function splendor:hud/row_text with storage splendor:hud row
