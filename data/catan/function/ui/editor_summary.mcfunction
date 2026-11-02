execute store result storage catan:ui g0 int 1 run scoreboard players get @s ca_g0
execute store result storage catan:ui g1 int 1 run scoreboard players get @s ca_g1
execute store result storage catan:ui g2 int 1 run scoreboard players get @s ca_g2
execute store result storage catan:ui g3 int 1 run scoreboard players get @s ca_g3
execute store result storage catan:ui g4 int 1 run scoreboard players get @s ca_g4
execute store result storage catan:ui w0 int 1 run scoreboard players get @s ca_w0
execute store result storage catan:ui w1 int 1 run scoreboard players get @s ca_w1
execute store result storage catan:ui w2 int 1 run scoreboard players get @s ca_w2
execute store result storage catan:ui w3 int 1 run scoreboard players get @s ca_w3
execute store result storage catan:ui w4 int 1 run scoreboard players get @s ca_w4
execute store result storage catan:ui partner int 1 run scoreboard players get @s ca_partner
execute store result storage catan:ui pay int 1 run scoreboard players get @s ca_pay
execute store result storage catan:ui receive int 1 run scoreboard players get @s ca_receive
execute store result storage catan:ui batch int 1 run scoreboard players get @s ca_batch
execute store result storage catan:ui a int 1 run scoreboard players get @s ca_a
execute store result storage catan:ui b int 1 run scoreboard players get @s ca_b
execute store result storage catan:ui edit int 1 run scoreboard players get @s ca_edit
data modify storage catan:ui due set from storage catan:ui hand.discard_due
data modify storage catan:ui partner_name set value {text:"—"}
function catan:ui/partner_name with storage catan:ui
function catan:ui/resource_labels
execute if score @s ca_edit matches 3 run function catan:ui/bank_summary
execute if score @s ca_edit matches 1 run function catan:ui/editor_note_1 with storage catan:ui
execute if score @s ca_edit matches 2 run function catan:ui/editor_note_2 with storage catan:ui
execute if score @s ca_edit matches 3 run function catan:ui/editor_note_3 with storage catan:ui
execute if score @s ca_edit matches 4 run function catan:ui/editor_note_4 with storage catan:ui
execute if score @s ca_edit matches 5 run function catan:ui/editor_note_5 with storage catan:ui
