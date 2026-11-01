scoreboard players operation @s ll_seen = @e[tag=ll.current,limit=1] ll_epoch
scoreboard players operation @s ll_ui_load = #ui_load ll_ctx
scoreboard players operation #ui_base ll_ctx = @s ll_seen
scoreboard players set #ui_factor ll_ctx 1000
scoreboard players operation #ui_base ll_ctx *= #ui_factor ll_ctx
scoreboard players set @s ll_action 0
scoreboard players enable @s ll_action
data modify storage love_letter:ui buttons set value []
data modify storage love_letter:ui cards set value {text:"",shadow_color:0,extra:[]}
data modify storage love_letter:ui info set value {text:"",extra:[]}
data modify storage love_letter:ui rows set value {text:"",extra:[]}
data modify storage love_letter:ui phase set value {text:"等待其他玩家。",color:"gray"}
data modify storage love_letter:ui title set value "情书 · 手牌"
