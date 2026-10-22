import json, subprocess, re, hashlib
from pathlib import Path
src=Path('C:/Users/Chen Yuru/Desktop/语音-格式未变换')
rp=Path('C:/Users/Chen Yuru/Desktop/fimelcard-rp/assets/meme')
out=rp/'sounds/imported';out.mkdir(exist_ok=True)
ffmpeg='C:/Users/Chen Yuru/Desktop/其他/SoraPostProcess/SoraPostProcess完整版/SoraPostProcess/runtime/Lib/site-packages/imageio_ffmpeg/binaries/ffmpeg-win-x86_64-v7.1.exe'
rows=[]
for p in sorted(src.rglob('*')):
 if not p.is_file(): continue
 key='voice_'+hashlib.sha256(p.name.encode('utf-8')).hexdigest()[:12]
 target=out/(key+'.ogg')
 result=subprocess.run([ffmpeg,'-hide_banner','-loglevel','error','-y','-i',str(p),'-map','0:a:0','-vn','-ac','1','-ar','44100','-c:a','libvorbis','-q:a','5',str(target)],capture_output=True)
 if result.returncode: raise RuntimeError(p.name+': '+result.stderr.decode('utf-8',errors='replace'))
 label=re.sub(r'^\[P\d+\][-\s]*','',p.stem)
 rows.append(dict(id=1001+len(rows),source=p.name,label=label,event=key,sound='imported/'+key))
Path('docs/语音导入清单.json').write_text(json.dumps(rows,ensure_ascii=False,indent=2),encoding='utf-8')
print('Converted',len(rows),'audio tracks to mono OGG Vorbis')
