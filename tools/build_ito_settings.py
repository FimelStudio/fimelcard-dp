from build_ito import *

def build():
 def edit(name, old, new):
  path=F/(name+'.mcfunction');s=path.read_text(encoding='utf8');s=s.replace(old,new);put(name,s)
 def prepend(name, line):
  path=F/(name+'.mcfunction');s=path.read_text(encoding='utf8')
  if line not in s:put(name,line+'\n'+s)
 prepend('load','scoreboard objectives add it_input dummy\nscoreboard objectives add it_settings trigger\nscoreboard objectives add it_settable dummy')
 prepend('tick','execute as @a[scores={it_settings=1..}] at @s run function ito:settings/save')
 edit('round/begin','execute as @a[tag=it.audience] run function ito:ui/open','tellraw @a[tag=it.audience] {text:"[命悬一线] 按Q使用紫色染料查看手牌和出牌；输入方式以游戏设置为准。",color:"yellow"}')
 prepend('round/begin','execute unless score @s it_input matches 0..1 run scoreboard players set @s it_input 0')
 prepend('input/book_return','execute if score @e[tag=it.current,limit=1] it_input matches 1 run return 0')
 prepend('input/book_read','execute if score @e[tag=it.current,limit=1] it_input matches 1 run return 0')
 prepend('form/open','execute unless score @e[tag=it.current,limit=1] it_input matches 1 run return 0')
 edit('form/receive','function ito:input/context','function ito:input/context\nexecute unless score @e[tag=it.current,limit=1] it_input matches 1 run return 0')
 edit('ui/card','function ito:ui/button\nfunction ito:ui/play_label','execute if score @e[tag=it.current,limit=1] it_input matches 1 run function ito:ui/button\nfunction ito:ui/play_label')
 edit('ui/open','描述不要透露数字。普通玩家可使用书本，第一页填写后Q提交。','描述不要透露数字。书本模式：第一页填写后Q提交；对话框模式：点击修改描述。输入方式在开局前的游戏设置中选择。')
 edit('rules/show','书本第一页填写描述后Q提交；紫色染料Q打开私密手牌和描述窗口，描述可以修改。','开局前在游戏设置选择书本或对话框输入。书本第一页填写后Q提交；对话框模式按Q使用紫色染料，再点击修改描述（提交需要OP）。系统不会自动弹窗，描述可以修改。')
 put('settings/clear_session','scoreboard players reset @s it_setnonce\nscoreboard players reset @s it_settable\nscoreboard players reset @s it_settings')
 put('settings/open',"""execute unless score @s ct_state matches 0 run return 0
execute unless score @s it_input matches 0..1 run scoreboard players set @s it_input 0
scoreboard players add #settings_serial it_ctx 1
execute if score #settings_serial it_ctx matches 10000001.. run scoreboard players set #settings_serial it_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,limit=1] it_setnonce = #settings_serial it_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] it_settable = @s ct_id
scoreboard players set @a[tag=ct.settings_actor,limit=1] it_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] it_settings
execute store result storage ito:settings nonce int 1 run scoreboard players get #settings_serial it_ctx
data modify storage ito:settings input set value "$(input)"
data modify storage ito:settings book set value true
data modify storage ito:settings form set value false
execute if score @s it_input matches 1 run data modify storage ito:settings book set value false
execute if score @s it_input matches 1 run data modify storage ito:settings form set value true
function ito:settings/show with storage ito:settings
""")
 put('settings/show',"""$dialog show @a[tag=ct.settings_actor,limit=1] {type:"minecraft:confirmation",title:{text:"命悬一线 · 游戏设置",color:"gold"},body:[{type:"minecraft:plain_message",width:440,contents:{text:"每轮随机一题，不自动打开对话框。书本模式：第一页填写后Q提交；对话框模式：按Q使用紫色染料，自行打开手牌并修改描述。对话框提交需要OP权限，普通玩家请选择书本。"}}],inputs:[{type:"minecraft:single_option",key:"input",label:{text:"答案输入方式"},width:320,options:[{id:"1",display:{text:"书本（默认）"},initial:$(book)},{id:"2",display:{text:"对话框（提交需要OP）"},initial:$(form)}]}],yes:{label:{text:"保存"},action:{type:"minecraft:dynamic/run_command",template:"trigger it_settings set $(nonce)$(input)"}},no:{label:{text:"取消"},action:{type:"minecraft:run_command",command:"trigger it_settings set 0"}},pause:false}
""")
 put('settings/save',"""scoreboard players operation #setting it_ctx = @s it_settings
scoreboard players set @s it_settings 0
scoreboard players set #ten it_ctx 10
scoreboard players operation #mode it_ctx = #setting it_ctx
scoreboard players operation #mode it_ctx %= #ten it_ctx
scoreboard players operation #setting it_ctx /= #ten it_ctx
execute unless score #mode it_ctx matches 1..2 run return 0
execute unless score #setting it_ctx = @s it_setnonce run return 0
execute unless entity @s[tag=ct.player] run return 0
execute unless score @s ct_id = @s it_settable run return 0
scoreboard players operation #settings_table it_ctx = @s it_settable
scoreboard players remove #mode it_ctx 1
scoreboard players set #saved it_ctx 0
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=19,ct_state=0}] if score @s ct_id = #settings_table it_ctx run function ito:settings/apply
execute if score #saved it_ctx matches 0 run tellraw @s {text:"牌桌已开始或切换游戏，设置未保存。",color:"red"}
execute if score #saved it_ctx matches 1 if score #mode it_ctx matches 0 run tellraw @s {text:"[命悬一线] 输入方式已设为：书本。",color:"green"}
execute if score #saved it_ctx matches 1 if score #mode it_ctx matches 1 run tellraw @s {text:"[命悬一线] 输入方式已设为：对话框。按Q使用紫色染料自行打开。",color:"green"}
function ito:settings/clear_session
""")
 put('settings/apply','scoreboard players operation @s it_input = #mode it_ctx\nscoreboard players set #saved it_ctx 1')

if __name__=='__main__':build()
