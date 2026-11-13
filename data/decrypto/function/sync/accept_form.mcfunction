data modify storage decrypto:input clues set value [{text:""},{text:""},{text:""}]
data modify storage decrypto:input clues[0].text set from storage decrypto:form incoming.a
data modify storage decrypto:input clues[1].text set from storage decrypto:form incoming.b
data modify storage decrypto:input clues[2].text set from storage decrypto:form incoming.c
function decrypto:sync/save_clues
