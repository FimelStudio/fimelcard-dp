data modify storage wenfei:wrap line.extra append value {text:""}
data modify storage wenfei:wrap line.extra[-1].text set from storage wenfei:wrap character
scoreboard players add #columns wq_ctx 1
execute if score #columns wq_ctx matches 36.. run function wenfei:title/wrap/flush
