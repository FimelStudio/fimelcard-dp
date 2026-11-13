"""Public played cards and announcements for Ito, applied after both modes."""
from pathlib import Path
import json
from build_ito import put
P=Path(__file__).resolve().parents[1]
R=P.parents[3]/'resourcepacks/fimelcard-rp'

def build():
 put('game/reveal', 'scoreboard players set @s it_used 2\nfunction ito:game/history\nscoreboard players operation #revealed_owner it_ctx = @s it_owner\nscoreboard players operation #revealed_number it_ctx = @s it_number\nexecute as @a[tag=it.audience] if score @s it_seat = #revealed_owner it_ctx run tellraw @a[tag=it.audience] [{text:"[命悬一线] ",color:"gold"},{selector:"@s"},{text:" 打出了 [",color:"white"},{score:{name:"#revealed_number",objective:"it_ctx"},color:"gold"},{text:"]",color:"white"}]\n')
 history=P/'data/ito/function/game/history.mcfunction'
 text=history.read_text(encoding='utf8')
 hook='execute as @e[tag=it.current,limit=1] at @s run function ito:visual/refresh'
 if hook not in text:put('game/history',text.rstrip()+'\n'+hook)
 lines=['scoreboard players operation #visual_table it_ctx = @s ct_id',
        'execute as @e[tag=it.visual] if score @s ct_id = #visual_table it_ctx run kill @s']
 for i in range(24):
  x=round((i%6-2.5)*.36,3);z=round((i//6-1.5)*.46,3)
  lines.append(f'execute if data entity @s data.ito.history[{i}] at @s run function ito:visual/card '+json.dumps({'index':i,'x':x,'z':z},separators=(',',':')))
 put('visual/refresh','\n'.join(lines))
 put('visual/card', '$data modify storage ito:visual card set from entity @s data.ito.history[$(index)]\n$execute positioned ~$(x) ~1.055 ~$(z) summon minecraft:item_display run function ito:visual/entity with storage ito:visual card')
 put('visual/entity', 'tag @s add it.visual\nscoreboard players operation @s ct_id = #visual_table it_ctx\n$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:ito/table/$(number)"}},item_display:"none",brightness:{block:15,sky:15},view_range:0.6f,transformation:{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[0.43f,0.43f,0.43f]}}\n')
 # Separate table models preserve the existing private hand/front and public hand/back.
 for rp in (R,R.parent/'Fimel桌游馆'):
  def save(relative,obj):
   f=rp/relative;f.parent.mkdir(parents=True,exist_ok=True);f.write_text(json.dumps(obj,separators=(',',':')),encoding='utf8')
  save('assets/card/models/item/ito/table_base.json',{'textures':{'back':'card:item/card'},'elements':[{'from':[3,8,0],'to':[13,8.15,16],'faces':{'up':{'uv':[1,0,10.667,16],'texture':'#front'},'down':{'uv':[1,0,10.667,16],'texture':'#back'}}}]})
  for n in range(1,101):
   save(f'assets/card/models/item/ito/table/{n}.json',{'parent':'card:item/ito/table_base','textures':{'front':f'card:item/ito/{n}'}})
   save(f'assets/card/items/ito/table/{n}.json',{'model':{'type':'minecraft:model','model':f'card:item/ito/table/{n}'}})

if __name__=='__main__':build()
