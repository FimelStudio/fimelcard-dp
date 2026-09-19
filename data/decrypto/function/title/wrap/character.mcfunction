data modify storage decrypto:wrap line.extra append value {text:""}
data modify storage decrypto:wrap line.extra[-1].text set from storage decrypto:wrap character
scoreboard players add #columns dc_ctx 1
