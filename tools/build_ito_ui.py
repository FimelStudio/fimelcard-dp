from build_ito import *
def build():
 put('input/context','''scoreboard players set #valid it_ctx 0
tag @e[tag=it.current] remove it.current
tag @a[tag=it.actor] remove it.actor
execute unless entity @s[tag=it.player,tag=ct.player] run return 0
execute unless score @s ct_id = @s it_table run return 0
scoreboard players operation #request_table it_ctx = @s it_table
execute as @e[tag=it.controller,scores={ct_game=19,it_state=1..4}] if score @s ct_id = #request_table it_ctx run tag @s add it.current
execute unless entity @e[tag=it.current,limit=1] run return 0
execute as @e[tag=it.current,limit=1] run function ito:system/context
scoreboard players operation #actor it_ctx = @s it_seat
tag @s add it.actor
scoreboard players set #valid it_ctx 1''')
 put('input/focus','''tag @e[tag=it.focus] remove it.focus
execute as @e[tag=it.cards,scores={it_used=0}] if score @s it_owner = #actor it_ctx if score @s it_slot = #slot it_ctx run tag @s add it.focus''')
 put('input/give','''execute store result storage ito:input table int 1 run scoreboard players get @s it_table
function ito:input/dye_item with storage ito:input
scoreboard players operation #actor it_ctx = @s it_seat
'''+ '\n'.join(f'scoreboard players set #slot it_ctx {i}\nfunction ito:input/book_return' for i in range(1,4)))
 put('input/dye_item','''clear @s minecraft:purple_dye[minecraft:custom_data~{ito:{tool:1b,kind:0}}]
$give @s minecraft:purple_dye[minecraft:item_name="命悬一线 · Q查看手牌／描述",minecraft:custom_data={ito:{tool:1b,kind:0,table:$(table)}},minecraft:max_stack_size=1]''')
 put('input/book_return','''function ito:input/focus
execute unless entity @e[tag=it.focus,limit=1] run return 0
execute store result storage ito:input table int 1 run scoreboard players get @s it_table
execute store result storage ito:input slot int 1 run scoreboard players get #slot it_ctx
execute store result storage ito:input round int 1 run scoreboard players get @e[tag=it.current,limit=1] it_round
execute store result storage ito:input number int 1 run scoreboard players get @e[tag=it.focus,limit=1] it_number
data modify storage ito:input content set value {pages:[""]}
data modify storage ito:input content.pages[0] set from entity @e[tag=it.focus,limit=1] data.description
function ito:input/book_item with storage ito:input''')
 put('input/book_item','''$clear @s *[minecraft:custom_data~{ito:{tool:1b,kind:1,slot:$(slot)}}]
$give @s minecraft:writable_book[minecraft:item_name="手牌$(slot) · 描述书（Q提交）",minecraft:custom_data={ito:{tool:1b,kind:1,table:$(table),round:$(round),slot:$(slot)}},minecraft:writable_book_content=$(content),minecraft:lore=[{text:"仅你可见：数字$(number)",color:"gold"},{text:"第一页写1–48字，完成后Q提交，不签名。",color:"yellow"}]]''')
 put('input/clear_spent_books','scoreboard players operation #actor it_ctx = @s it_seat\n'+'\n'.join(f'scoreboard players set #slot it_ctx {i}\nfunction ito:input/focus\nexecute unless entity @e[tag=it.focus,limit=1] run clear @s *[minecraft:custom_data~{{ito:{{tool:1b,kind:1,slot:{i}}}}}]' for i in range(1,4)))
 put('input/drop','''tag @e[tag=it.drop] remove it.drop
tag @s add it.drop
execute on origin if entity @s[tag=it.player] at @s run function ito:input/from_player
kill @s''')
 put('input/from_player','''function ito:input/context
execute unless score #valid it_ctx matches 1 run return 0
execute store result score #item_table it_ctx run data get entity @e[tag=it.drop,limit=1] Item.components."minecraft:custom_data".ito.table
execute unless score #item_table it_ctx = @s it_table run return 0
execute if data entity @e[tag=it.drop,limit=1] Item.components."minecraft:custom_data".ito{kind:0} run return run function ito:input/dye
execute store result score #book_round it_ctx run data get entity @e[tag=it.drop,limit=1] Item.components."minecraft:custom_data".ito.round
execute unless score #book_round it_ctx = @e[tag=it.current,limit=1] it_round run return 0
execute store result score #slot it_ctx run data get entity @e[tag=it.drop,limit=1] Item.components."minecraft:custom_data".ito.slot
execute unless score #slot it_ctx matches 1..3 run return 0
execute if score @e[tag=it.current,limit=1] it_state matches 2 run function ito:input/book_read
function ito:input/book_return''')
 put('input/dye','''execute store result storage ito:input table int 1 run scoreboard players get @s it_table
function ito:input/dye_item with storage ito:input
function ito:ui/open''')
 put('input/book_read','''data modify storage ito:input pages set value []
data modify storage ito:input pages set from entity @e[tag=it.drop,limit=1] Item.components."minecraft:writable_book_content".pages
execute store result score #pages it_ctx run data get storage ito:input pages
execute unless score #pages it_ctx matches 1 run return run function ito:input/reject
data modify storage ito:input incoming set from storage ito:input pages[0]
execute if data storage ito:input pages[0].raw run data modify storage ito:input incoming set from storage ito:input pages[0].raw
function ito:input/save''')
 put('input/reject',say('请在未签名书的第一页填写1–48字；原描述保留。','red','@s'))
 put('input/save','''execute store result score #length it_ctx run data get storage ito:input incoming
execute unless score #length it_ctx matches 1..48 run return run function ito:input/reject
function ito:input/focus
execute unless entity @e[tag=it.focus,limit=1] run return 0
data modify entity @e[tag=it.focus,limit=1] data.description set from storage ito:input incoming
'''+say('描述已更新，出牌前可以继续修改。','green','@s')+'''
execute as @e[tag=it.current,limit=1] at @s run function ito:hud/refresh''')
 put('ui/open','''function ito:input/context
execute unless score #valid it_ctx matches 1 run return 0
scoreboard players add #window_serial it_ctx 1
execute if score #window_serial it_ctx matches 10000001.. run scoreboard players set #window_serial it_ctx 1
scoreboard players operation @s it_window = #window_serial it_ctx
scoreboard players operation @s it_win_epoch = @e[tag=it.current,limit=1] it_epoch
scoreboard players operation #base it_ctx = @s it_window
scoreboard players operation #base it_ctx *= #hundred it_ctx
data modify storage ito:ui dialog set value '''+js({'type':'minecraft:multi_action','title':{'text':'命悬一线 · 私密手牌'},'body':[{'type':'minecraft:plain_message','width':440,'contents':{'text':'描述不要透露数字。普通玩家可使用书本，第一页填写后Q提交。'}}],'actions':[],'columns':2,'pause':False,'after_action':'close'})+'''
execute if score @e[tag=it.current,limit=1] it_state matches 1 run function ito:ui/topics
execute if score @e[tag=it.current,limit=1] it_state matches 2 run function ito:ui/cards
execute unless data storage ito:ui dialog.actions[0] run data modify storage ito:ui dialog.actions append value {label:{text:"等待下一阶段"}}
function ito:ui/show with storage ito:ui''')
 put('ui/show','$dialog show @s $(dialog)')
 put('ui/topics','\n'.join(f'''data modify storage ito:ui label set from entity @e[tag=it.current,limit=1] data.ito.option{i}.text
scoreboard players operation #button it_ctx = #base it_ctx
scoreboard players add #button it_ctx {i}
function ito:ui/button''' for i in [1,2]))
 put('ui/button','''execute store result storage ito:ui action int 1 run scoreboard players get #button it_ctx
function ito:ui/button_value with storage ito:ui
data modify storage ito:ui button.label.text set from storage ito:ui label
data modify storage ito:ui dialog.actions append from storage ito:ui button''')
 put('ui/button_value','$data modify storage ito:ui button set value {label:{text:""},width:210,action:{type:"minecraft:run_command",command:"trigger it_action set $(action)"}}')
 put('ui/cards','\n'.join(f'scoreboard players set #slot it_ctx {i}\nfunction ito:ui/card' for i in range(1,4)))
 put('ui/card','''function ito:input/focus
execute unless entity @e[tag=it.focus,limit=1] run return 0
execute store result storage ito:ui number int 1 run scoreboard players get @e[tag=it.focus,limit=1] it_number
execute store result storage ito:ui slot int 1 run scoreboard players get #slot it_ctx
function ito:ui/card_label with storage ito:ui
scoreboard players operation #button it_ctx = #base it_ctx
scoreboard players operation #button it_ctx += #slot it_ctx
scoreboard players add #button it_ctx 10
function ito:ui/button
function ito:ui/play_label with storage ito:ui
scoreboard players add #button it_ctx 10
function ito:ui/button''')
 put('ui/card_label','$data modify storage ito:ui label set value "手牌$(slot)：$(number) · 修改描述"')
 put('ui/play_label','$data modify storage ito:ui label set value "打出 $(number)"')
 put('input/submit','''scoreboard players operation #request it_ctx = @s it_action
scoreboard players set @s it_action 0
scoreboard players enable @s it_action
function ito:input/context
execute unless score #valid it_ctx matches 1 run return 0
scoreboard players operation #choice it_ctx = #request it_ctx
scoreboard players operation #choice it_ctx %= #hundred it_ctx
scoreboard players operation #request it_ctx /= #hundred it_ctx
execute unless score #request it_ctx = @s it_window run return 0
execute unless score @s it_win_epoch = @e[tag=it.current,limit=1] it_epoch run return 0
execute if score #choice it_ctx matches 1..2 run return run function ito:themes/vote
scoreboard players operation #slot it_ctx = #choice it_ctx
execute if score #choice it_ctx matches 11..13 run scoreboard players remove #slot it_ctx 10
execute if score #choice it_ctx matches 11..13 run return run function ito:form/open
execute if score #choice it_ctx matches 21..23 run scoreboard players remove #slot it_ctx 20
execute if score #choice it_ctx matches 21..23 as @e[tag=it.current,limit=1] at @s run function ito:game/play''')
if __name__=='__main__':build()
