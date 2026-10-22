from pathlib import Path
from PIL import Image
import json, subprocess
src=Path('C:/Users/Chen Yuru/Desktop/表情包-格式未变换')
rp=Path('C:/Users/Chen Yuru/Desktop/fimelcard-rp/assets/meme')
out=rp/'textures/imported';out.mkdir(exist_ok=True)
ffmpeg='C:/Users/Chen Yuru/Desktop/其他/SoraPostProcess/SoraPostProcess完整版/SoraPostProcess/resources/ffmpeg.exe'
rows=[]
for i,p in enumerate(sorted(src.rglob('*'))):
 if not p.is_file(): continue
 with Image.open(p) as im: size=list(im.size);frames=getattr(im,'n_frames',1);fmt=im.format
 ident='import_'+str(len(rows)+1).zfill(3);dest=out/(ident+'.png')
 subprocess.run([ffmpeg,'-hide_banner','-loglevel','error','-y','-i',str(p),'-vf',"scale=w='min(256,iw)':h='min(256,ih)':force_original_aspect_ratio=decrease",'-frames:v','1',str(dest)],check=True,capture_output=True)
 with Image.open(dest) as im:
  assert max(im.size)<=256
  target=list(im.size)
 rows.append(dict(id=len(rows)+5,source=p.name,format=fmt,frames=frames,original_size=size,size=target,texture='imported/'+ident+'.png'))
Path('docs/表情包导入清单.json').write_text(json.dumps(rows,ensure_ascii=False,indent=2),encoding='utf-8')
print('Imported',len(rows),'images; animated first frames:',sum(x['frames']>1 for x in rows))
