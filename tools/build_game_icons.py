from pathlib import Path
import json,re,shutil,subprocess,math
from PIL import Image,ImageDraw,ImageFont
P=Path(__file__).resolve().parents[1];R=P.parents[3]/'resourcepacks/fimelcard-rp';D=P/'docs/game-icons';S=Path('C:/Users/Chen Yuru/Desktop/icon')
def card(x,y,c,t,angle=0):return f'<g transform="translate({x} {y}) rotate({angle} 100 140)"><rect width="200" height="280" rx="20" fill="#fffdf4" stroke="#bdcbd6" stroke-width="10"/><text x="100" y="180" text-anchor="middle" font-family="Arial" font-size="110" font-weight="bold" fill="{c}">{t}</text></g>'
def circle(x,y,r,c):return f'<circle cx="{x}" cy="{y}" r="{r}" fill="{c}" stroke="#dbc39a" stroke-width="8"/>'
def board():return '<rect x="210" y="120" width="600" height="540" rx="24" fill="#d6ab6d" stroke="#f6dca7" stroke-width="16"/>'+''.join(f'<path d="M{v} 150V630M240 {v-90}H780" stroke="#785235" stroke-width="5"/>' for v in range(240,781,90))
def build():
 D.mkdir(parents=True,exist_ok=True)
 old={1:10,2:2,3:4,4:5,5:6,6:3,7:9,8:7,9:8,10:1}
 names={11:('UNO','UNO'),12:('国际象棋','CHESS'),13:('中国象棋','XIANGQI'),14:('五子棋','GOMOKU'),15:('飞行棋','AEROPLANE'),16:('阿瓦隆','AVALON'),17:('情书','LOVE LETTER'),18:('掼蛋','GUANDAN'),19:('命悬一线','ITO'),20:('围棋','GO'),21:('卡坦岛','CATAN')}
 artwork={}
 artwork[11]=card(230,180,'#c72542','+2',-20)+card(410,140,'#268561','8')+card(580,190,'#397ac2','4',20)
 artwork[12]='<path d="M430 140H590V205H650V270H590V350L650 540H690V620H330V540H370L430 350V270H370V205H430Z" fill="url(#metal)" stroke="#7993ad" stroke-width="14"/>'+circle(680,490,65,'#14243a')
 artwork[13]=board()+circle(420,355,140,'#f6d7a2')+'<text x="420" y="410" text-anchor="middle" font-family="Microsoft YaHei" font-size="160" fill="#a62935">帥</text>'+circle(660,510,94,'#f4d09b')+'<text x="660" y="550" text-anchor="middle" font-family="Microsoft YaHei" font-size="110" fill="#283543">將</text>'
 artwork[14]=board()+''.join(circle(300+i*90,200+i*90,37,'#17283a') for i in range(5))+circle(570,200,38,'#fff8db')+circle(390,470,38,'#fff8db')
 artwork[15]='<g transform="rotate(-28 512 380)"><path d="M480 120Q512 70 544 120L550 320L790 470V535L550 440V570L640 620V660L512 625L384 660V620L474 570V440L234 535V470L474 320Z" fill="url(#metal)" stroke="#93c2d9" stroke-width="12"/></g>'+circle(760,180,65,'#e44e4e')
 artwork[16]='<path d="M260 180L512 110L764 180V380Q740 570 512 670Q280 570 260 380Z" fill="#385b7a" stroke="url(#gold)" stroke-width="24"/><path d="M480 180H544V440H610V485H544V600H480V485H414V440H480Z" fill="url(#metal)"/>'
 artwork[17]='<rect x="220" y="240" width="590" height="360" rx="25" fill="#fff2d7" stroke="#dcc4a1" stroke-width="14"/><path d="M230 250L515 470L800 250M230 590L430 430M800 590L600 430" fill="none" stroke="#c7987e" stroke-width="14"/>'+circle(515,450,70,'#a82249')+'<path d="M475 440Q465 400 495 410L515 425L535 410Q575 400 555 440L515 480Z" fill="#ffd6b4"/>'
 artwork[18]=card(240,160,'#b62843','2',-18)+card(420,150,'#b62843','2',8)+card(600,210,'#b62843','♥',22)+'<path d="M380 530L460 590L650 470" fill="none" stroke="url(#gold)" stroke-width="35"/>'
 artwork[19]='<path d="M170 160Q512 520 854 160" stroke="#fff1cb" stroke-width="12" fill="none"/>'+card(390,310,'#267879','65',0)+'<path d="M512 350V140M480 170L512 140L544 170" stroke="url(#gold)" stroke-width="12" fill="none"/>'
 artwork[20]=board()+''.join(circle(x,y,40,c) for x,y,c in [(330,270,'#122238'),(420,270,'#122238'),(510,270,'#122238'),(330,360,'#fff7e6'),(420,360,'#122238'),(510,360,'#fff7e6'),(600,450,'#fff7e6'),(510,540,'#122238')])
 artwork[21]=''.join(f'<polygon points="'+ ' '.join(f'{x+120*math.cos(math.radians(a)):.1f},{y+120*math.sin(math.radians(a)):.1f}' for a in range(0,360,60))+f'" fill="{c}" stroke="#f8dd9b" stroke-width="10"/>' for x,y,c in [(340,280,'#749a49'),(550,280,'#d4b257'),(445,465,'#ad6749'),(655,465,'#5e9349')])+'<path d="M365 405L445 340L525 405V500H365Z" fill="#b83735" stroke="#f4b88a" stroke-width="10"/>'
 template=(S/'01_斗地主.svg').read_text(encoding='utf8');prefix=template[:template.index(' <circle cx="505"')];suffix='<rect x="14" y="14" width="996" height="996" rx="75" fill="none" stroke="#fff" stroke-opacity=".48" stroke-width="10"/></g></svg>'
 colors=['#286e73','#334261','#8b4933','#38635a','#295c85','#414473','#9a3e65','#814331','#356b70','#405555','#55783d']
 for i,(id,(name,en)) in enumerate(names.items()):
  svg=prefix.replace('#8c1b25',colors[i]).replace('#3b0822','#111d31')+artwork[id]+suffix
  (D/f'{id}.svg').write_text(svg,encoding='utf8')
 # Rasterize editable SVG using bundled Sharp; no external download.
 sharp=Path('C:/Users/Chen Yuru/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/sharp')
 script='const sharp=require('+json.dumps(str(sharp))+');const fs=require("fs");(async()=>{for(const f of fs.readdirSync(process.argv[1]).filter(x=>/^\\d+\\.svg$/.test(x)))await sharp(process.argv[1]+"/"+f).resize(1024,1024).png().toFile(process.argv[1]+"/"+f.replace(".svg",".png"));})();'
 subprocess.run(['node','-e',script,str(D)],check=True)
 dest=R/'assets/card/textures/gui/game_icons';dest.mkdir(parents=True,exist_ok=True)
 for id,num in old.items():
  f=next(S.glob(f'{num:02d}_*.png'));Image.open(f).convert('RGBA').resize((256,256),Image.Resampling.LANCZOS).save(dest/f'{id}.png')
 for id,(name,en) in names.items():
  im=Image.open(D/f'{id}.png').convert('RGBA');d=ImageDraw.Draw(im);d.rounded_rectangle((60,736,964,950),radius=46,fill='#151427',outline='#9b7483',width=4);d.line((84,758,940,758),fill='#f5d25e',width=9)
  size=90 if len(name)<=4 else 74;d.text((512,830),name,font=ImageFont.truetype('C:/Windows/Fonts/msyhbd.ttc',size),anchor='mm',fill='white');d.text((512,912),en,font=ImageFont.truetype('C:/Windows/Fonts/arial.ttf',42),anchor='mm',fill='#d0e1eb');im.resize((256,256),Image.Resampling.LANCZOS).save(dest/f'{id}.png')
 providers=[]
 for id in range(1,22):providers.append({'type':'bitmap','file':f'card:gui/game_icons/{id}.png','height':9,'ascent':8,'chars':[[chr(0xE600+id*8+j)][0] for j in range(8)]})
 advances={' ':7}
 for id in range(1,22):
  icon=Image.open(dest/f'{id}.png').convert('RGBA')
  for strip in range(8):
   bbox=icon.crop((0,strip*32,256,(strip+1)*32)).getchannel('A').getbbox()
   width=math.floor((bbox[2] if bbox else 0)*9/32+.5)+1
   advances[chr(0xE800+id*8+strip)]=80-width
 providers.append({'type':'space','advances':advances})
 f=R/'assets/card/font/game_icons.json';f.write_text(json.dumps({'providers':providers},ensure_ascii=False,indent=2),encoding='utf8')
 for cap in [4,8]:
  path=P/f'data/cardtable/function/menu/picker/show{cap}.mcfunction';backup=D/f'picker{cap}-original.json'
  if not backup.exists():backup.write_text(path.read_text(encoding='utf8').split(' ',3)[3],encoding='utf8')
  original=json.loads(backup.read_text(encoding='utf8'));actions=original['actions'];body=[{'type':'minecraft:plain_message','width':410,'contents':{'text':'点击图标选择游戏；悬停查看人数。','color':'gray'}}]
  for row in range(0,len(actions),5):
   extra=[]
   for strip in range(8):
    for col,a in enumerate(actions[row:row+5]):
     id=int(re.search(r'\$\(p(\d+)\)',a['action']['command'])[1]);extra.append({'text':chr(0xE600+id*8+strip),'font':'card:game_icons','color':'white','shadow_color':0,'click_event':{'action':'run_command','command':a['action']['command']},'hover_event':{'action':'show_text','value':a['label']}})
     extra.append({'text':chr(0xE800+id*8+strip),'font':'card:game_icons'})
    if strip<7:extra.append({'text':'\n'})
   body.append({'type':'minecraft:plain_message','width':410,'contents':{'text':'','extra':extra}})
  dialog={'type':'minecraft:notice','title':original['title'],'body':body,'action':{'label':{'text':'取消'}},'pause':False,'after_action':'close'}
  path.write_text('$dialog show @a[tag=ct.switch_actor,limit=1] '+json.dumps(dialog,ensure_ascii=False,separators=(',',':'))+'\n',encoding='utf8')
 for folder in ['assets/card/textures/gui/game_icons','assets/card/font']:
  if folder.endswith('/font'):shutil.copy2(R/folder/'game_icons.json',R.parent/'Fimel桌游馆'/folder/'game_icons.json')
  else:shutil.copytree(R/folder,R.parent/'Fimel桌游馆'/folder,dirs_exist_ok=True)
 for id in range(1,22):shutil.copy2(dest/f'{id}.png',D/f'{id}.png')
 preview=Image.new('RGBA',(256*4,256*6),'#151725')
 for id in range(1,22):preview.paste(Image.open(dest/f'{id}.png'),(((id-1)%4)*256,((id-1)//4)*256))
 preview.save(D/'preview.png')
 # 21号已有独立高细节矢量源；公共旧模板生成后必须重新应用，避免资源地块图标回退。
 from build_catan_icon import build as build_catan_icon
 build_catan_icon(refresh_preview=True)
if __name__=='__main__':build()
