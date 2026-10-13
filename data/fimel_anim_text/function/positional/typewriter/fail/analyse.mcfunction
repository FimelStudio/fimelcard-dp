tellraw @a [{text:"[文本动画库] ",color:"light_purple"},{text:"自动解析：输入不符合规范",color:"red"}]

execute as @a at @s run playsound block.glass.break master @s ~ ~ ~

function fimel_anim_text:positional/typewriter/start/analyse