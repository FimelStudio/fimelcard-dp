# 设置数据

data remove storage fimel_anim_text:runtime operation.punctuation.next

data modify storage fimel_anim_text:runtime operation.punctuation.next set from storage fimel_anim_text:runtime local.subtitle.template[-1]

execute store result score #operation.speed fca_store run data get storage fimel_anim_text:runtime local.subtitle.speed

function fimel_anim_text:operation/punctuation/run

scoreboard players operation @s fca_timer = #operation.delay fca_store

scoreboard players operation #local.subtitle.punctuation fca_store = #operation.punctuation fca_store