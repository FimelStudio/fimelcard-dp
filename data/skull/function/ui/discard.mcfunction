data modify storage skull:ui dialog.body append value {type:"minecraft:plain_message",contents:{text:"翻到了自己的骷髅。秘密选择一张牌永久弃置，包含本轮已经扣下的牌。不可撤销，其他人不会得知牌型。",color:"red"}}
execute if data storage skull:ui owned[{slot:1}] run function skull:ui/button {choice:51,label:"弃掉花牌 1"}
execute if data storage skull:ui owned[{slot:2}] run function skull:ui/button {choice:52,label:"弃掉花牌 2"}
execute if data storage skull:ui owned[{slot:3}] run function skull:ui/button {choice:53,label:"弃掉花牌 3"}
execute if data storage skull:ui owned[{slot:4}] run function skull:ui/button {choice:54,label:"弃掉骷髅（糖骷髅）"}
