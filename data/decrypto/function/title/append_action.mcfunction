# 与左上角笔记共用 BetterTitle 的 Actionbar，避免互相覆盖。
data modify storage fimel_title:io text set value [{text:"等待其他玩家提交",color:"gray"}]
execute if score @s dc_hint matches 2 run data modify storage fimel_title:io text set value [{text:"本轮轮空 · 可查看笔记",color:"gray"}]
execute if score @s dc_hint matches 3 run data modify storage fimel_title:io text set value [{text:"请加密 · 在提示册写三条提示，完成后按 Q 提交",color:"gold",bold:true}]
execute if score @s dc_hint matches 4 run data modify storage fimel_title:io text set value [{text:"请加密 · 手持紫色染料按 Q",color:"gold",bold:true}]
execute if score @s dc_hint matches 5 run data modify storage fimel_title:io text set value [{text:"请解密 · 手持紫色染料按 Q",color:"aqua",bold:true}]
execute if score @s dc_hint matches 6 run data modify storage fimel_title:io text set value [{text:"请拦截 · 手持紫色染料按 Q",color:"light_purple",bold:true}]
data modify storage fimel_title:io font set value "minecraft:default_mod"
data modify storage fimel_title:io neg_font set value "minecraft:default_neg"
data modify storage fimel_title:io x set value 0.0d
data modify storage fimel_title:io y set value 0.0d
data modify storage fimel_title:io dx set value 0.0d
data modify storage fimel_title:io dy set value 0.0d
data modify storage fimel_title:io align set value "middle"
data modify storage fimel_title:io origin set value "default"
function fimel_title:new_text
