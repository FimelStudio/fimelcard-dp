$data modify storage guandan:hint pick set value {seat:$(seat),suit:-1}
$scoreboard players set #hint_apply_kind gd_ctx $(kind)
$execute if score #hint_apply_kind gd_ctx matches 1..3 run return run function guandan:hint/pick_group {rank:$(rank),copies:$(size)}
$execute if score #hint_apply_kind gd_ctx matches 8 run return run function guandan:hint/pick_group {rank:$(rank),copies:$(size)}
$execute if score #hint_apply_kind gd_ctx matches 4 run function guandan:hint/pick_group {rank:$(rank),copies:3}
$execute if score #hint_apply_kind gd_ctx matches 4 run return run function guandan:hint/pick_group {rank:$(pair),copies:2}
execute if score #hint_apply_kind gd_ctx matches 10 run function guandan:hint/pick_group {rank:15,copies:2}
execute if score #hint_apply_kind gd_ctx matches 10 run return run function guandan:hint/pick_group {rank:16,copies:2}
$execute if score #hint_apply_kind gd_ctx matches 9 run data modify storage guandan:hint pick.suit set value $(suit)
$scoreboard players set #hint_step gd_ctx $(first)
$scoreboard players set #hint_end gd_ctx $(last)
$data modify storage guandan:hint pick.copies set value $(copies)
function guandan:hint/pick_run
