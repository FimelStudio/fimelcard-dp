function hanabi:name/resolve
data modify storage abraca:hud text append value {text:"\n"}
data modify storage abraca:hud text append from storage hanabi:name resolved
data modify storage abraca:hud text[-1].color set value "aqua"
execute if data storage abraca:hud text[-1].extra run data modify storage abraca:hud text[-1].extra[].color set value "aqua"
execute store result storage abraca:hud current.hp int 1 run scoreboard players get @s ab_hp
function abraca:hud/append_hp with storage abraca:hud current
