$scoreboard players set #hint_need gd_ctx $(copies)
$execute if score #hint_apply_kind gd_ctx matches 9 as @e[tag=gd.cards,scores={gd_owner=$(seat),gd_point=$(rank),gd_wild=0,gd_sel=0,gd_suit=$(suit)},limit=$(copies)] run function guandan:hint/pick_one
$execute unless score #hint_apply_kind gd_ctx matches 9 as @e[tag=gd.cards,scores={gd_owner=$(seat),gd_point=$(rank),gd_wild=0,gd_sel=0},limit=$(copies)] run function guandan:hint/pick_one
$execute if score #hint_need gd_ctx matches 1.. as @e[tag=gd.cards,scores={gd_owner=$(seat),gd_wild=1,gd_sel=0}] if score #hint_need gd_ctx matches 1.. run function guandan:hint/pick_one
