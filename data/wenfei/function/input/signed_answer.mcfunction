function wenfei:input/reject_answer
function wenfei:input/give_answer
tellraw @s {text:"[问非所答] 请勿签名，已补发空白答案册。原书可拾回查看。",color:"yellow"}
data remove entity @e[tag=wq.drop,limit=1] Item.components."minecraft:custom_data".wenfei.tool
