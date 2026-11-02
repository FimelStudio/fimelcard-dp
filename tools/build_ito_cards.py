from pathlib import Path
import json,shutil
from PIL import Image,ImageDraw,ImageFont
P=Path(__file__).resolve().parents[1];F=P/'data/ito/function';R=P.parents[3]/'resourcepacks/fimelcard-rp'
def build():
 def put(n,s):
  f=F/(n+'.mcfunction');f.parent.mkdir(parents=True,exist_ok=True);f.write_text(s.strip()+'\n',encoding='utf8')
 def edit(n,a,b):
  f=F/(n+'.mcfunction');s=f.read_text(encoding='utf8');put(n,s.replace(a,b))
 put('input/number_cards','scoreboard players operation #actor it_ctx = @s it_seat\n'+'\n'.join(f'scoreboard players set #slot it_ctx {i}\nfunction ito:input/number_card' for i in range(1,4)))
 put('input/number_card',"""function ito:input/focus
execute unless entity @e[tag=it.focus,limit=1] run return 0
execute store result storage ito:input table int 1 run scoreboard players get @s it_table
execute store result storage ito:input owner int 1 run scoreboard players get @s it_seat
execute store result storage ito:input slot int 1 run scoreboard players get #slot it_ctx
execute store result storage ito:input round int 1 run scoreboard players get @e[tag=it.current,limit=1] it_round
execute store result storage ito:input epoch int 1 run scoreboard players get @e[tag=it.current,limit=1] it_epoch
execute store result storage ito:input number int 1 run scoreboard players get @e[tag=it.focus,limit=1] it_number
function ito:input/number_item with storage ito:input""")
 put('input/number_item',"""$clear @s minecraft:paper[minecraft:custom_data~{ito:{tool:1b,kind:2,slot:$(slot)}}]
$give @s minecraft:paper[minecraft:item_model="card:ito/$(number)",minecraft:item_name="数字 $(number) · 手牌$(slot)（Q出牌）",minecraft:custom_data={ito:{tool:1b,kind:2,table:$(table),owner:$(owner),round:$(round),epoch:$(epoch),slot:$(slot)}},minecraft:max_stack_size=1,minecraft:lore=[{text:"所有描述提交后，讨论好顺序再按Q出牌。",color:"yellow"}]]""")
 put('input/play_number',"""execute store result score #card_owner it_ctx run data get entity @e[tag=it.drop,limit=1] Item.components."minecraft:custom_data".ito.owner
execute unless score #card_owner it_ctx = @s it_seat run return 0
execute unless score @e[tag=it.current,limit=1] it_state matches 2 run return 0
execute as @e[tag=it.current,limit=1] at @s run function ito:game/play
execute if score @e[tag=it.current,limit=1] it_state matches 2 run function ito:input/number_cards""")
 f=F/'input/give.mcfunction';s=f.read_text(encoding='utf8');s=s.replace('function ito:input/number_cards\n','');put('input/give','function ito:input/number_cards\n'+s)
 edit('input/from_player','execute if score @e[tag=it.current,limit=1] it_state matches 2 run function ito:input/book_read','execute if data entity @e[tag=it.drop,limit=1] Item.components."minecraft:custom_data".ito{kind:2} run return run function ito:input/play_number\nexecute if score @e[tag=it.current,limit=1] it_state matches 2 run function ito:input/book_read')
 f=F/'ui/card.mcfunction';s=f.read_text(encoding='utf8');s=s.split('function ito:ui/play_label')[0];put('ui/card',s)
 f=F/'input/submit.mcfunction';put('input/submit','\n'.join(l for l in f.read_text(encoding='utf8').splitlines() if 'matches 21..23' not in l))
 for i in range(1,4):
  needle=f'execute unless entity @e[tag=it.focus,limit=1] run clear @s *[minecraft:custom_data~{{ito:{{tool:1b,kind:1,slot:{i}}}}}]'
  edit('input/clear_spent_books',needle,needle.replace('kind:1,',''))
 f=F/'game/start.mcfunction';s=f.read_text(encoding='utf8');needle='execute if score #occupied it_ctx matches 1 run return run function ito:game/bad_slots'
 s=s.replace(needle,'\n'.join(f'execute as @a[tag=it.joining] if items entity @s hotbar.{i} * run scoreboard players set #occupied it_ctx 1' for i in [3,4,5])+'\n'+needle);put('game/start',s)
 edit('game/bad_slots','第1、2、3、9格','第1至6格和第9格')
 edit('round/begin','按Q使用紫色染料查看手牌和出牌；输入方式以游戏设置为准。','拿数字牌按Q出牌；紫色染料用于查看手牌和填写描述。')
 # Use the same geometry, UV layout and display transforms as Doudizhu poker cards.
 font=ImageFont.truetype('C:/Windows/Fonts/arialbd.ttf',84)
 for n in range(1,101):
  im=Image.open(R/'assets/card/textures/item/poker/c_a.png').convert('RGBA').resize((384,384),Image.Resampling.NEAREST);d=ImageDraw.Draw(im)
  # Preserve the poker silhouette and gray border; replace only the face interior.
  d.rectangle((32,24,231,359),fill=(242,239,233,255))
  d.text((132,192),str(n),font=font,anchor='mm',fill='#333333',stroke_width=1)
  f=R/f'assets/card/textures/item/ito/{n}.png';f.parent.mkdir(parents=True,exist_ok=True);im.save(f)
  m={'parent':'card:item/fake_card','textures':{'0':f'card:item/ito/{n}','1':'card:item/card','particle':f'card:item/ito/{n}'}}
  f=R/f'assets/card/models/item/ito/{n}.json';f.parent.mkdir(parents=True,exist_ok=True);f.write_text(json.dumps(m),encoding='utf8')
  item={'model':{'type':'minecraft:select','property':'minecraft:display_context','cases':[{'when':['thirdperson_righthand','thirdperson_lefthand'],'model':{'type':'minecraft:model','model':'card:item/fake_card'}}],'fallback':{'type':'minecraft:model','model':f'card:item/ito/{n}'}}}
  f=R/f'assets/card/items/ito/{n}.json';f.parent.mkdir(parents=True,exist_ok=True);f.write_text(json.dumps(item),encoding='utf8')
 for folder in ['assets/card/textures/item/ito','assets/card/models/item/ito','assets/card/items/ito']:shutil.copytree(R/folder,R.parent/'Fimel桌游馆'/folder,dirs_exist_ok=True)
if __name__=='__main__':build()
