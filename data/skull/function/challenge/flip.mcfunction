$execute unless data entity @s data.skull.seats.s$(seat).stack[-1] run return 0
$data modify storage skull:io revealed set from entity @s data.skull.seats.s$(seat).stack[-1]
$data remove entity @s data.skull.seats.s$(seat).stack[-1]
function skull:player/audience
execute store result storage skull:io visual.seat int 1 run scoreboard players get @s sk_source
data modify storage skull:io visual.slot set from storage skull:io revealed.slot
data modify storage skull:io visual.model set from storage skull:io revealed.model
function skull:visual/reveal with storage skull:io visual
function skull:visual/refresh
scoreboard players operation #source sk_ctx = @s sk_source
execute as @a[tag=sk.audience] if score @s sk_seat = #source sk_ctx run tellraw @a[tag=sk.audience] [{text:"翻开 ",color:"yellow"},{selector:"@s"},{text:" 的堆顶："},{"nbt":"revealed.name","storage":"skull:io"}]
execute if data storage skull:io revealed{type:1} run return run function skull:challenge/fail
scoreboard players add @s sk_flipped 1
tellraw @a[tag=sk.audience] [{text:"花牌进度：",color:"green"},{score:{name:"@s",objective:"sk_flipped"}},{text:" / "},{score:{name:"@s",objective:"sk_bid"}}]
execute if score @s sk_flipped >= @s sk_bid run return run function skull:challenge/success
scoreboard players set @s sk_timer 10
function skull:round/epoch
execute store result storage skull:io flip.seat int 1 run scoreboard players get @s sk_lead
scoreboard players set #own sk_ctx 0
function skull:challenge/check_own with storage skull:io flip
execute if score #own sk_ctx matches 0 run function skull:ui/refresh
