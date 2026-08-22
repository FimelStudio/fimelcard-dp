scoreboard players random #roll ab_ctx 1 3
scoreboard players operation @a[tag=ab.actor,limit=1] ab_hp -= #roll ab_ctx
tellraw @a[tag=ab.actor,limit=1] [{text:'[古代巨龙] ',color:'red'},{text:'召唤失败！骰子为 ',color:'gray'},{score:{name:'#roll',objective:'ab_ctx'},color:'gold'},{text:'；你失去等量生命。',color:'red'}]
function abraca:hud/update
function abraca:turn/end
