tag @e[tag=it.focus] remove it.focus
execute as @e[tag=it.cards,scores={it_used=0}] if score @s it_owner = #actor it_ctx if score @s it_slot = #slot it_ctx run tag @s add it.focus
