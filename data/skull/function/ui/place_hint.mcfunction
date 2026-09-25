execute if entity @a[tag=sk.viewer,scores={sk_done=0}] run tellraw @a[tag=sk.viewer] {text:"[骷髅牌] 选中要扣的手牌，按Q丢出；本轮首次只能扣一张。",color:"yellow"}
execute if entity @a[tag=sk.viewer,scores={sk_done=1}] run tellraw @a[tag=sk.viewer] {text:"[骷髅牌] 你已完成首次扣牌，请等待其他人。",color:"yellow"}
