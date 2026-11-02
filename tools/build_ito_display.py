from build_ito import *
def build():
 put('form/open','''function ito:input/focus
execute unless entity @e[tag=it.focus,limit=1] run return 0
execute store result storage ito:form slot int 1 run scoreboard players get #slot it_ctx
execute store result storage ito:form table int 1 run scoreboard players get @s it_table
execute store result storage ito:form epoch int 1 run scoreboard players get @e[tag=it.current,limit=1] it_epoch
execute store result storage ito:form token int 1 run scoreboard players get @s it_window
execute store result storage ito:form number int 1 run scoreboard players get @e[tag=it.focus,limit=1] it_number
data modify storage ito:form dialog set value '''+js({'type':'minecraft:confirmation','title':{'text':'修改描述'},'body':[{'type':'minecraft:plain_message','contents':{'text':'自由文本提交需要OP；普通玩家请使用描述书。最多48字。'}}],'inputs':[{'type':'minecraft:text','key':'a','label':{'text':'描述'},'width':360,'max_length':48,'initial':''}],'yes':{'label':{'text':'公布描述'},'action':{'type':'minecraft:dynamic/run_command','template':''}},'no':{'label':{'text':'关闭'}},'pause':False,'after_action':'close'})+'''
data modify storage ito:form dialog.body prepend value {type:"minecraft:plain_message",width:440,contents:{text:"本轮问题：",color:"gold",extra:[{text:""}]}}
data modify storage ito:form dialog.body[0].contents.extra[0].text set from entity @e[tag=it.current,limit=1] data.ito.theme.text
data modify storage ito:form dialog.inputs[0].initial set from entity @e[tag=it.focus,limit=1] data.description
data modify storage ito:form a set value "$(a)"
function ito:form/template with storage ito:form
function ito:form/show with storage ito:form''')
 put('form/template','''$data modify storage ito:form dialog.inputs[0].label.text set value "手牌$(slot) · 数字$(number)"
$data modify storage ito:form dialog.yes.action.template set value "function ito:form/submit {p:{a:'$(a)',t:$(table),e:$(epoch),s:$(slot),n:$(token)}}"''')
 put('form/show','$dialog show @s $(dialog)')
 put('form/submit','$data modify storage ito:form incoming set value $(p)\nfunction ito:form/receive')
 put('form/receive','''function ito:input/context
execute unless score #valid it_ctx matches 1 run return 0
execute unless score @e[tag=it.current,limit=1] it_state matches 2 run return 0
'''+ '\n'.join(f'execute store result score #{key} it_ctx run data get storage ito:form incoming.{key}' for key in ['t','e','n','s'])+'''
execute unless score #t it_ctx = @s it_table run return 0
execute unless score #e it_ctx = @e[tag=it.current,limit=1] it_epoch run return 0
execute unless score #n it_ctx = @s it_window run return 0
scoreboard players operation #slot it_ctx = #s it_ctx
execute unless score #slot it_ctx matches 1..3 run return 0
data modify storage ito:input incoming set from storage ito:form incoming.a
function ito:input/save
function ito:input/book_return''')
 # HUD reuse the installed font-based positioning library; never send hidden numbers.
 put('hud/activate','''execute unless data storage fimel_title:io panels run function fimel_title:code/load
scoreboard players set @s it_previous 0
execute if score @s fbt_panel matches 1.. run scoreboard players operation @s it_previous = @s fbt_panel
scoreboard players reset @s it_panel
function fimel_title:new_panel {id:"@s it_panel"}
execute unless entity @s[tag=fimel.anim_text.replace.actionbar] run tag @s add it.owns_hud
tag @s add fimel.anim_text.replace.actionbar
tag @s add it.hud''')
 put('hud/deactivate','''execute unless entity @s[tag=it.hud] run return 0
data modify storage fimel_title:io panel_buffer set value []
scoreboard players operation panel_id fbt_io = @s it_panel
function fimel_title:replace_panel
execute if score @s fbt_panel = @s it_panel run scoreboard players operation @s fbt_panel = @s it_previous
execute if entity @s[tag=it.owns_hud] run tag @s remove fimel.anim_text.replace.actionbar
tag @s remove it.owns_hud
tag @s remove it.hud
scoreboard players reset @s it_panel''')
 put('hud/refresh','''function ito:system/context
execute as @a[tag=it.audience] run function ito:hud/build''')
 put('hud/build','''execute unless entity @s[tag=it.hud] run function ito:hud/activate
data modify storage fimel_title:io panel_buffer set value []
data modify storage fimel_title:io text_buffer set value []
data modify storage fimel_title:io neg_text_buffer set value []
data modify storage fimel_title:io x set value 8.0d
data modify storage fimel_title:io y set value -12.0d
data modify storage fimel_title:io origin set value "up-left"
data modify storage fimel_title:io align set value "left"
execute as @e[tag=it.parts] run function ito:hud/participant
data modify storage fimel_title:io x set value 0.0d
data modify storage fimel_title:io y set value 8.0d
data modify storage fimel_title:io origin set value "default"
data modify storage fimel_title:io align set value "middle"
data modify storage fimel_title:io text set value {text:"正在随机抽取主题",color:"gold",shadow_color:0}
execute unless score @e[tag=it.current,limit=1] it_state matches 1 run data modify storage fimel_title:io text.text set from entity @e[tag=it.current,limit=1] data.ito.theme.question
function ito:hud/text
scoreboard players operation panel_id fbt_io = @s it_panel
function fimel_title:replace_panel
scoreboard players operation @s fbt_panel = @s it_panel''')
 put('hud/participant','''data modify storage fimel_title:io text set from entity @s data.name
function ito:hud/text
scoreboard players operation #hud_owner it_ctx = @s it_seat
execute as @e[tag=it.cards,scores={it_owner=1..8,it_slot=1}] if score @s it_owner = #hud_owner it_ctx run function ito:hud/card
execute as @e[tag=it.cards,scores={it_owner=1..8,it_slot=2}] if score @s it_owner = #hud_owner it_ctx run function ito:hud/card
execute as @e[tag=it.cards,scores={it_owner=1..8,it_slot=3}] if score @s it_owner = #hud_owner it_ctx run function ito:hud/card''')
 put('hud/card','''data modify storage fimel_title:io text set value {text:"",color:"white",shadow_color:0}
data modify storage fimel_title:io text.text set from entity @s data.description
execute if data entity @s {data:{description:""}} run data modify storage fimel_title:io text.text set value "（尚未描述）"
execute if score @s it_used matches 2.. run data modify storage fimel_title:io text.color set value "dark_gray"
function ito:hud/text''')
 put('hud/text','''data modify storage fimel_title:io font set value "minecraft:default_mod"
data modify storage fimel_title:io neg_font set value "minecraft:default_neg"
data modify storage fimel_title:io dx set value 0.0d
data modify storage fimel_title:io dy set value -10.0d
function fimel_title:new_text''')
 put('visual/refresh','# 公开信息由玩家HUD负责，暂不生成桌面文字。\nreturn 1')
 put('settings/open','dialog show @a[tag=ct.settings_actor,limit=1] '+js({'type':'minecraft:notice','title':{'text':'命悬一线 · 蛛丝设置'},'body':[{'type':'minecraft:plain_message','contents':{'text':'采用原版规则：3点生命，三关每人1/2/3张；过关恢复1点，上限3，两人局不恢复。书本与对话框输入同时提供。'}}],'pause':False}))
 put('settings/clear_session','scoreboard players reset @s it_setnonce')
 put('rules/show','dialog show @a[tag=ct.rules_actor,limit=1] '+js({'type':'minecraft:notice','title':{'text':'命悬一线 · 蛛丝'},'body':[{'type':'minecraft:plain_message','width':460,'contents':{'text':'2–8人合作。每关随机抽取一个主题，用主题描述自己的数字，不能透露具体数字。\n第一、二、三关每人分别1、2、3张。书本第一页填写描述后Q提交；紫色染料Q打开私密手牌和描述窗口，描述可以修改。\n所有手牌描述完毕后，讨论谁的牌最小，再主动出牌。若跳过更小的牌，系统揭示并移除它们，每张扣1生命。\n初始3生命，归零失败；过关回1生命，上限3，两人局不回血；第三关有公共参照数字。三关成功全员获胜。'}}],'pause':False}))

_original_build=build
def build():
 _original_build()
 for name,body in {'hud\\build': 'execute unless entity @s[tag=it.hud] run function ito:hud/activate\ndata modify storage fimel_title:io panel_buffer set value []\ndata modify storage fimel_title:io text_buffer set value []\ndata modify storage fimel_title:io neg_text_buffer set value []\ndata modify storage fimel_title:io x set value 8.0d\ndata modify storage fimel_title:io y set value -12.0d\ndata modify storage fimel_title:io origin set value "up-left"\ndata modify storage fimel_title:io align set value "left"\nexecute store result score #hud_clock it_ctx run time query gametime\nscoreboard players set #hud_period it_ctx 120\nscoreboard players operation #hud_clock it_ctx /= #hud_period it_ctx\nscoreboard players set #two it_ctx 2\nscoreboard players operation #hud_clock it_ctx %= #two it_ctx\nexecute if score @e[tag=it.current,limit=1] it_count matches ..4 run scoreboard players set #hud_clock it_ctx 0\nexecute as @e[tag=it.parts,scores={it_order=0..3}] if score #hud_clock it_ctx matches 0 run function ito:hud/participant\nexecute as @e[tag=it.parts,scores={it_order=4..7}] if score #hud_clock it_ctx matches 1 run function ito:hud/participant\ndata modify storage fimel_title:io x set value 0.0d\ndata modify storage fimel_title:io y set value 8.0d\ndata modify storage fimel_title:io origin set value "default"\ndata modify storage fimel_title:io align set value "middle"\ndata modify storage fimel_title:io text set value {text:"正在随机抽取主题",color:"gold",shadow_color:0}\nexecute unless score @e[tag=it.current,limit=1] it_state matches 1 run data modify storage fimel_title:io text.text set from entity @e[tag=it.current,limit=1] data.ito.theme.question\nfunction ito:hud/text\nscoreboard players operation panel_id fbt_io = @s it_panel\nfunction fimel_title:replace_panel\nscoreboard players operation @s fbt_panel = @s it_panel\n', 'hud\\card': 'data modify storage fimel_title:io text set value {text:"",color:"white",shadow_color:0}\ndata modify storage fimel_title:io text.text set from entity @s data.description\nexecute if data entity @s {data:{description:""}} run data modify storage fimel_title:io text.text set value "（尚未描述）"\nexecute if score @s it_used matches 2.. run data modify storage fimel_title:io text.color set value "dark_gray"\nfunction ito:hud/text\n'}.items():put(name,body)
 put('hud/card', '''data modify storage fimel_title:io text set value {text:"",color:"white",shadow_color:0}
execute store result score #hud_length it_ctx run data get entity @s data.description
data modify storage fimel_title:io text.text set from entity @s data.description
execute if score #hud_length it_ctx matches 25.. run data modify storage fimel_title:io text.text set string entity @s data.description 0 24
execute if data entity @s {data:{description:""}} run data modify storage fimel_title:io text.text set value "（尚未描述）"
execute if score @s it_used matches 2.. run data modify storage fimel_title:io text.color set value "dark_gray"
function ito:hud/text
execute if score #hud_length it_ctx matches 25.. run data modify storage fimel_title:io text.text set string entity @s data.description 24
execute if score #hud_length it_ctx matches 25.. run function ito:hud/text
''')
if __name__=='__main__':build()


