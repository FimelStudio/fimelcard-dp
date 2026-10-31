data modify storage fimel_title:io font set value "card:uno/hud"
data modify storage fimel_title:io neg_font set value "card:uno/hud_neg"
execute if score #hud_types un_ctx matches 9..18 run data modify storage fimel_title:io font set value "card:uno/hud_dense"
execute if score #hud_types un_ctx matches 9..18 run data modify storage fimel_title:io neg_font set value "card:uno/hud_dense_neg"
execute if score #hud_types un_ctx matches 19..36 run data modify storage fimel_title:io font set value "card:uno/hud_medium"
execute if score #hud_types un_ctx matches 19..36 run data modify storage fimel_title:io neg_font set value "card:uno/hud_medium_neg"
execute if score #hud_types un_ctx matches 37..54 run data modify storage fimel_title:io font set value "card:uno/hud_small"
execute if score #hud_types un_ctx matches 37..54 run data modify storage fimel_title:io neg_font set value "card:uno/hud_small_neg"
function uno:hud/text
