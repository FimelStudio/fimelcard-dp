data modify storage splendor:hud row set value {}
$data modify storage splendor:hud row.name set value $(name)
$data modify storage splendor:hud tokens set value $(tokens)
data modify storage splendor:hud row.t0 set from storage splendor:hud tokens[0]
data modify storage splendor:hud row.t1 set from storage splendor:hud tokens[1]
data modify storage splendor:hud row.t2 set from storage splendor:hud tokens[2]
data modify storage splendor:hud row.t3 set from storage splendor:hud tokens[3]
data modify storage splendor:hud row.t4 set from storage splendor:hud tokens[4]
data modify storage splendor:hud row.t5 set from storage splendor:hud tokens[5]
function splendor:hud/row_text with storage splendor:hud row
