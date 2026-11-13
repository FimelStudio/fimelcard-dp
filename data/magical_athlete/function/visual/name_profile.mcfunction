data modify storage magical_athlete:visual owner_profile set value {id:[I;0,0,0,0]}
$data modify storage magical_athlete:visual owner_profile.id set from entity @s data.magical_athlete.p$(owner).uuid
$execute as @a[tag=ma.player,scores={ma_side=$(owner)}] if score @s ma_table = #vis_table ma_ctx run data modify storage magical_athlete:visual owner_profile.id set from entity @s UUID
$data modify entity @s data.magical_athlete.p$(owner).uuid set from storage magical_athlete:visual owner_profile.id
