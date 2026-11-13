"""Build opaque backing for the top slice of overlapping dialog cards only."""
from pathlib import Path
import json,shutil
from PIL import Image
P=Path(__file__).resolve().parents[1]
R=P.parents[3]/'resourcepacks/fimelcard-rp'
def build():
 for game,names in [('doudizhu',['stack','stack_selected']),('guandan',['stack'])]:
  for name in names:
   path=R/f'assets/card/font/{game}/{name}.json'
   data=json.loads(path.read_text(encoding='utf8'))
   for provider in data['providers']:
    if provider['type']!='bitmap':continue
    original=provider['file'];src=R/('assets/'+original.replace(':','/textures/'))
    im=Image.open(src).convert('RGBA')
    for row in range(6):
     for col in range(9):
      x=col*36;y=row*48
      cell=im.crop((x,y,x+36,y+48));box=cell.getchannel('A').point(lambda alpha: 255 if alpha>16 else 0).getbbox()
      for px in range(box[0],box[2]):
       first=next((py for py in range(12) if cell.getpixel((px,py))[3]>16),None)
       if first is not None:
        # Continue the real gray/gold edge; ignore invisible width markers.
        edge=cell.getpixel((px,first))
        for py in range(first):cell.putpixel((px,py),edge)
      im.paste(cell,(x,y))
    dest=src.with_name(src.stem+'_joined.png');im.save(dest)
    provider['file']=original[:-4]+'_joined.png'
   (path.with_name(name+'_joined.json')).write_text(json.dumps(data,ensure_ascii=False),encoding='utf8')
  path=P/f'data/{game}/function'/('dialog/stack_fragment.mcfunction' if game=='doudizhu' else 'ui/stack_fragment.mcfunction')
  s=path.read_text(encoding='utf8')
  if game=='guandan':
   lines=['execute if score #ui_stack_index gd_ctx matches 1.. run data modify storage guandan:ui fragment.font set value "card:guandan/stack_joined"']
  else:
   lines=[f'execute if score #stack_index dd_ctx matches 1.. if data storage doudizhu:ui fragment{{font:"card:doudizhu/{n}"}} run data modify storage doudizhu:ui fragment.font set value "card:doudizhu/{n}_joined"' for n in names]
  for line in lines:s=s.replace(line+'\n','')
  needle=f'data modify storage {game}:ui grid.extra append from storage {game}:ui fragment'
  s=s.replace(needle,'\n'.join(lines)+'\n'+needle);path.write_text(s,encoding='utf8')
  for folder in [f'assets/card/font/{game}',f'assets/card/textures/font/{game}']:
   shutil.copytree(R/folder,R.parent/'Fimel桌游馆'/folder,dirs_exist_ok=True)
if __name__=='__main__':build()
