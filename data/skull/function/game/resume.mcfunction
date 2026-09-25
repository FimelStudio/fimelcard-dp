function skull:player/audience
execute unless score @s sk_state matches 7 as @a[tag=sk.audience] run function skull:hand/sync
function skull:hud/update
function skull:ui/refresh
tag @a[tag=sk.audience] remove sk.audience
