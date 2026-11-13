execute if data storage cardtable:uninstall active run return run tellraw @a {text:"[牌桌] 正在卸载，请等待完成提示。",color:"yellow"}
data modify storage cardtable:uninstall active set value 1b
tellraw @a {text:"[牌桌] 开始卸载：结束所有牌局并清理运行数据，请等待完成提示后再移除数据包。",color:"yellow"}
scoreboard objectives add ct_ctx dummy
scoreboard players reset #version ct_ctx
execute in minecraft:overworld store success storage cardtable:uninstall helper_existed byte 1 run forceload query 0 0
execute in minecraft:overworld run forceload add 0 0
function cardtable:uninstall/cancel_schedules
tag @a[tag=ab.player] add ct.uninstall_member
tag @a[tag=ac.player] add ct.uninstall_member
tag @a[tag=av.player] add ct.uninstall_member
tag @a[tag=bw.player] add ct.uninstall_member
tag @a[tag=ca.player] add ct.uninstall_member
tag @a[tag=ch.player] add ct.uninstall_member
tag @a[tag=cp.player] add ct.uninstall_member
tag @a[tag=ct.player] add ct.uninstall_member
tag @a[tag=dc.player] add ct.uninstall_member
tag @a[tag=dd.player] add ct.uninstall_member
tag @a[tag=fc.player] add ct.uninstall_member
tag @a[tag=gd.player] add ct.uninstall_member
tag @a[tag=gm.player] add ct.uninstall_member
tag @a[tag=go.player] add ct.uninstall_member
tag @a[tag=hb.player] add ct.uninstall_member
tag @a[tag=it.player] add ct.uninstall_member
tag @a[tag=lh.player] add ct.uninstall_member
tag @a[tag=ll.player] add ct.uninstall_member
tag @a[tag=ma.player] add ct.uninstall_member
tag @a[tag=sk.player] add ct.uninstall_member
tag @a[tag=sp.player] add ct.uninstall_member
tag @a[tag=un.player] add ct.uninstall_member
tag @a[tag=wq.player] add ct.uninstall_member
tag @a[tag=xq.player] add ct.uninstall_member
tag @a add ct.uninstall_pending
function cardtable:uninstall/step
