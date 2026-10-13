# 设置数据

data remove storage fimel_anim_text:runtime operation.punctuation.next

data modify storage fimel_anim_text:runtime operation.punctuation.next set from storage fimel_anim_text:runtime global.actionbar.template[-1]

scoreboard players operation #operation.speed fca_store = #global.actionbar.speed fca_store

function fimel_anim_text:operation/punctuation/run

scoreboard players operation #global.actionbar.timer fca_store = #operation.delay fca_store

scoreboard players operation #global.actionbar.punctuation fca_store = #operation.punctuation fca_store