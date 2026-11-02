from build_ito import *

def build():
 put('form/open',"""function ito:input/context
execute unless score #valid it_ctx matches 1 run return 0
execute unless score @e[tag=it.current,limit=1] it_input matches 1 run return 0
execute unless score @e[tag=it.current,limit=1] it_state matches 2 run return 0
scoreboard players add #window_serial it_ctx 1
execute if score #window_serial it_ctx matches 10000001.. run scoreboard players set #window_serial it_ctx 1
scoreboard players operation @s it_window = #window_serial it_ctx
execute store result storage ito:form table int 1 run scoreboard players get @s it_table
execute store result storage ito:form epoch int 1 run scoreboard players get @e[tag=it.current,limit=1] it_epoch
execute store result storage ito:form token int 1 run scoreboard players get @s it_window
data modify storage ito:form dialog set value {type:"minecraft:confirmation",title:{text:"命悬一线 · 本轮答案",color:"gold"},body:[{type:"minecraft:plain_message",width:440,contents:{text:"本轮问题：",color:"gold",extra:[{text:""}]}},{type:"minecraft:plain_message",width:440,contents:{text:"为每张数字牌填写1至48字。提交后仍可修改；拿数字牌按Q出牌。对话框提交需要OP。",color:"gray"}}],inputs:[],yes:{label:{text:"提交全部答案"},action:{type:"minecraft:dynamic/run_command",template:""}},no:{label:{text:"关闭"}},pause:false,after_action:"close"}
data modify storage ito:form dialog.body[0].contents.extra[0].text set from entity @e[tag=it.current,limit=1] data.ito.theme.text
data modify storage ito:form a1 set value ""
data modify storage ito:form a2 set value ""
data modify storage ito:form a3 set value ""
"""+'\n'.join(f'scoreboard players set #slot it_ctx {i}\nfunction ito:form/add_input {{slot:{i}}}' for i in range(1,4))+"""
execute unless data storage ito:form dialog.inputs[0] run return 0
function ito:form/template with storage ito:form
function ito:form/show with storage ito:form""")
 # Preserve dynamic input tokens through the outer macro without nested macro syntax.
 put('form/add_input','function ito:input/focus\nexecute unless entity @e[tag=it.focus,limit=1] run return 0\nexecute store result storage ito:form field.number int 1 run scoreboard players get @e[tag=it.focus,limit=1] it_number\nexecute store result storage ito:form field.slot int 1 run scoreboard players get #slot it_ctx\nfunction ito:form/field with storage ito:form field\ndata modify storage ito:form dialog.inputs[-1].initial set from entity @e[tag=it.focus,limit=1] data.description\n'+'\n'.join(f'execute if score #slot it_ctx matches {i} run data modify storage ito:form a{i} set value "$(a{i})"' for i in range(1,4)))
 put('form/field','$data modify storage ito:form dialog.inputs append value {type:"minecraft:text",key:"a$(slot)",label:{text:"数字 $(number)："},width:360,max_length:48,initial:""}')
 put('form/template',r'''$data modify storage ito:form dialog.yes.action.template set value "function ito:form/submit {p:{t:$(table),e:$(epoch),n:$(token),a1:'$(a1)',a2:'$(a2)',a3:'$(a3)'}}"''')
 put('form/receive',"""function ito:input/context
execute unless score #valid it_ctx matches 1 run return 0
execute unless score @e[tag=it.current,limit=1] it_input matches 1 run return 0
execute unless score @e[tag=it.current,limit=1] it_state matches 2 run return 0
"""+'\n'.join(f'execute store result score #{k} it_ctx run data get storage ito:form incoming.{k}' for k in ['t','e','n'])+"""
execute unless score #t it_ctx = @s it_table run return 0
execute unless score #e it_ctx = @e[tag=it.current,limit=1] it_epoch run return 0
execute unless score #n it_ctx = @s it_window run return 0
scoreboard players set #batch_bad it_ctx 0
"""+'\n'.join(f'scoreboard players set #slot it_ctx {i}\nfunction ito:form/validate {{slot:{i}}}' for i in range(1,4))+"""
execute if score #batch_bad it_ctx matches 1 run tellraw @s {text:"每张未出数字牌都需填写1至48字，本次未保存。",color:"red"}
execute if score #batch_bad it_ctx matches 1 run return 0
"""+'\n'.join(f'scoreboard players set #slot it_ctx {i}\nfunction ito:form/save_field {{slot:{i}}}' for i in range(1,4))+"""
tellraw @s {text:"[命悬一线] 本轮答案已更新，拿数字牌按Q出牌。",color:"green"}
execute as @e[tag=it.current,limit=1] at @s run function ito:hud/refresh""")
 put('form/validate','function ito:input/focus\nexecute unless entity @e[tag=it.focus,limit=1] run return 0\nscoreboard players set #length it_ctx 0\n$execute store result score #length it_ctx run data get storage ito:form incoming.a$(slot)\nexecute unless score #length it_ctx matches 1..48 run scoreboard players set #batch_bad it_ctx 1')
 put('form/save_field','function ito:input/focus\nexecute unless entity @e[tag=it.focus,limit=1] run return 0\n$data modify entity @e[tag=it.focus,limit=1] data.description set from storage ito:form incoming.a$(slot)')
 f=F/'ui/open.mcfunction';s=f.read_text(encoding='utf8');line='execute if score @e[tag=it.current,limit=1] it_input matches 1 if score @e[tag=it.current,limit=1] it_state matches 2 run return run function ito:form/open'
 if line not in s:s=s.replace('execute unless score #valid it_ctx matches 1 run return 0','execute unless score #valid it_ctx matches 1 run return 0\n'+line)
 put('ui/open',s)
if __name__=='__main__':build()
