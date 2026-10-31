"""检查两款新游戏的资源闭包、骰面朝向、跑道几何及16段原创音效。"""
import hashlib
import json
import math
import shutil
import subprocess
import wave
import numpy as np
from PIL import Image
from boardgame_assets import RP, CARD
from build_aeroplane_visual import FACE_ROTATIONS, PATH, point
from test_aeroplane_geometry import audit_manifest, audit_terminal_clearance, expected_point

checks=0
def check(value,label):
    global checks
    assert value,label
    checks+=1


def rotate(q,v):
    # 独立的四元数旋转向量公式。
    u=np.array(q[:3]);v=np.array(v)
    return v+2*np.cross(u,np.cross(u,v)+q[3]*v)


for game in ('gomoku','aeroplane_chess'):
    for path in (CARD/f'items/{game}').rglob('*.json'):
        item=json.loads(path.read_text(encoding='utf-8'))
        ns,loc=item['model']['model'].split(':')
        model_path=RP/f'assets/{ns}/models/{loc}.json'
        check(model_path.is_file(),str(path)+' model')
        model=json.loads(model_path.read_text(encoding='utf-8'))
        for key,resource in model['textures'].items():
            if resource.startswith('#'):continue
            ns,loc=resource.split(':')
            check((RP/f'assets/{ns}/textures/{loc}.png').is_file(),str(path)+' texture '+key)
        for element in model['elements']:
            check(all(a<=b for a,b in zip(element['from'],element['to'])),'positive box '+str(path))
            check(all(-16<=a<=32 for a in element['from']+element['to']),'Java bounds '+str(path))
            for face in element['faces'].values():
                check(face['texture'].lstrip('#') in model['textures'],'face texture '+str(path))
        source=RP/f'.source/{game}/models'/path.relative_to(CARD/f'items/{game}').with_suffix('.bbmodel')
        check(source.exists(),'editable source '+str(path))
        editable=json.loads(source.read_text(encoding='utf-8'))
        check(len(editable['elements'])==len(model['elements']),'source elements')
        check(all(t['source'].startswith('data:image/png;base64,') for t in editable['textures']),'embedded source textures')

check(len(list((CARD/'models/item/gomoku/board').glob('*.json')))==12,'two gomoku palettes x three sizes x labels')
check(len(list((CARD/'models/item/gomoku/stone').glob('*.json')))==2,'black and white stones only')
check(len(list((CARD/'models/item/aeroplane_chess/board').glob('*.json')))==1,'one flight board')
check(len(list((CARD/'models/item/aeroplane_chess/plane').glob('*.json')))==4,'four flight colors')
normals={1:(0,1,0),6:(0,-1,0),2:(0,0,-1),5:(0,0,1),3:(1,0,0),4:(-1,0,0)}
for face,q in FACE_ROTATIONS.items():
    check(abs(sum(v*v for v in q)-1)<1e-8,'unit dice quaternion')
    check(np.allclose(rotate(q,normals[face]),[0,1,0]),f'face {face} points up')
    check(np.allclose(rotate(q,normals[7-face]),[0,-1,0]),'opposite dice face')
audit_manifest(PATH,check)
minimum_clearance=audit_terminal_clearance(PATH,CARD,check)
for c in range(4):
    for cap,foot in [(4,2.7),(8,3.6)]:
        for orient in (0,1):
            for p in range(4):
                for pos in range(-1,58):
                    geom=point(c,p,pos,foot/PATH['grid'],orient)
                    expected=expected_point(PATH,c,p,pos,foot,orient)
                    check(all(abs(geom[key]-expected[key])<1e-7 for key in ('x','z','qy','qw')),'independent manifest coordinate '+str((c,p,pos,cap,orient)))
                    check(max(abs(geom[k]) for k in ('x','z'))<foot/2,'plane inside table board')
                    check(abs(geom['qy']**2+geom['qw']**2-1)<1e-7,'unit plane orientation')

# 检查实际PNG，格心的暖白圆点与其下四色跑道必须同时位于声明坐标。
with Image.open(CARD/'textures/item/aeroplane_chess/board/classic.png') as image:
    texture=image.convert('RGB')
    check(texture.size==(1536,1536),'traditional board texture dimensions')
    def pixel(node):
        x,z=[round((value+.5)/PATH['grid']*texture.width) for value in node]
        return texture.getpixel((x,z))
    for i,node in enumerate(PATH['ring']):
        check(pixel(node)==(255,251,237),f'ring {i} painted landing circle matches geometry')
        color=PATH['colors'][(i+2)%4]['name']
        with Image.open(CARD/f'textures/item/aeroplane_chess/plane/classic_{color}.png') as plane_texture:
            painted=plane_texture.convert('RGB').getpixel((16,16))
        samples=[tuple(a+(b-a)*.6 for a,b in zip(node,vertex)) for vertex in PATH['ring_cells'][i]]
        check(any(pixel(sample)==painted for sample in samples),f'ring {i} matches plane color')
    for color in PATH['colors']:
        for i,node in enumerate(color['home']):
            check(pixel(node)==(255,251,237),f'home {color["name"]}/{i} landing circle matches geometry')

sounds=json.loads((CARD/'sounds.json').read_text(encoding='utf-8'))
manifest=json.loads((RP/'.source/boardgames/manifest.json').read_text(encoding='utf-8'))
ffmpeg=shutil.which('ffmpeg') or 'D:/ffmpeg/bin/ffmpeg.exe'
ffprobe=shutil.which('ffprobe') or 'D:/ffmpeg/bin/ffprobe.exe'
for entry in manifest:
    path=RP/entry['output'];parts=path.parts;game=parts[-2];name=path.stem
    check(hashlib.sha256(path.read_bytes()).hexdigest()==entry['sha256'],'audio hash '+name)
    event=sounds[f'{game}.{name}']
    check(event['sounds'][0]['name']==f'card:{game}/{name}','sound event '+name)
    for lang in ('zh_cn','en_us'):
        check(event['subtitle'] in json.loads((CARD/f'lang/{lang}.json').read_text(encoding='utf-8')),'subtitle '+lang)
    with wave.open(str(RP/entry['source']),'rb') as source:
        check((source.getnchannels(),source.getsampwidth(),source.getframerate())==(1,2,44100),'lossless source')
    metadata=json.loads(subprocess.check_output([ffprobe,'-v','error','-show_streams','-of','json',str(path)],text=True))['streams'][0]
    check(metadata['codec_name']=='vorbis' and metadata['channels']==1,'mono vorbis')
    pcm=subprocess.check_output([ffmpeg,'-v','error','-i',str(path),'-f','f32le','-ac','1','pipe:1'])
    data=np.frombuffer(pcm,dtype='<f4')
    check(len(data)>2000 and .02<np.max(np.abs(data))<.98,'audible no clipping '+name)
    check(np.sqrt(np.mean(data*data))>.008,'audio RMS '+name)
check(len(manifest)==16,'sixteen sounds')
print(f'PASS: {checks} resource, geometry, dice and audio assertions; terminal/dice clearance {minimum_clearance:.6f} blocks.')
