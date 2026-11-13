function hanabi:name/resolve
data modify storage abraca:hud text append value {text:"\n▶ 正在出牌：",color:"gold",bold:true}
data modify storage abraca:hud text append from storage hanabi:name resolved
data modify storage abraca:hud text[-1].color set value "aqua"
execute if data storage abraca:hud text[-1].extra run data modify storage abraca:hud text[-1].extra[].color set value "aqua"
