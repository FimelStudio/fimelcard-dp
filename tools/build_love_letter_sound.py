"""为情书合成原创短纸张声、封蜡声与室内乐提示音。"""
import hashlib
import json
import shutil
import subprocess
import wave
import numpy as np
from boardgame_assets import PACK, RP, CARD, json_file, text_file

RATE=44100
RNG=np.random.default_rng(20261101)


def paper(duration=.23):
    t=np.arange(round(duration*RATE))/RATE
    noise=RNG.normal(0,1,len(t))
    smooth=np.convolve(noise,np.ones(5)/5,mode='same')
    envelope=np.sin(np.pi*t/duration)**1.6
    flutter=.5+.5*np.sin(2*np.pi*(24*t+32*t*t))**2
    return smooth*envelope*flutter


def pluck(notes,duration):
    t=np.arange(round(duration*RATE))/RATE
    value=np.zeros(len(t))
    for index,note in enumerate(notes):
        delay=index*.065
        phase=np.maximum(0,t-delay)
        envelope=(t>=delay)*(1-np.exp(-phase*1200))*np.exp(-phase*5.5)
        value+=(np.sin(2*np.pi*note*phase)+.19*np.sin(2*np.pi*note*2*phase))*envelope
    return value/max(1,len(notes))


def seal(duration=.14):
    t=np.arange(round(duration*RATE))/RATE
    noise=RNG.normal(0,1,len(t))
    return (np.sin(2*np.pi*420*t)*np.exp(-t*42)+.18*noise*np.exp(-t*95))*(1-np.exp(-t*3200))


def save(name,samples):
    samples=np.asarray(samples,dtype=np.float64)
    size=min(170,len(samples)//4)
    samples[:size]*=np.linspace(0,1,size);samples[-size:]*=np.linspace(1,0,size)
    samples*=.68/max(.001,np.max(np.abs(samples)))
    source=RP/f'.source/love_letter/audio/{name}.wav';source.parent.mkdir(parents=True,exist_ok=True)
    with wave.open(str(source),'wb') as out:
        out.setnchannels(1);out.setsampwidth(2);out.setframerate(RATE)
        out.writeframes(np.round(samples*32767).astype('<i2').tobytes())
    target=CARD/f'sounds/love_letter/{name}.ogg';target.parent.mkdir(parents=True,exist_ok=True)
    subprocess.run([shutil.which('ffmpeg') or 'D:/ffmpeg/bin/ffmpeg.exe','-hide_banner','-loglevel','error',
                    '-y','-i',str(source),'-map_metadata','-1','-c:a','libvorbis','-q:a','5','-fflags','+bitexact',str(target)],check=True)
    return {'name':name,'source':source.relative_to(RP).as_posix(),'output':target.relative_to(RP).as_posix(),
            'seconds':round(len(samples)/RATE,5),'sha256':hashlib.sha256(target.read_bytes()).hexdigest()}


def build():
    entries={'start':(pluck([392,493.88,587.33],.65),'情书对局开始','Love Letter begins'),
             'play':(paper(.23),'放下信件','Card played'),
             'draw':(paper(.18),'抽取信件','Card drawn'),
             'seal':(seal(),'封蜡落下','Seal placed'),
             'swap':(paper(.32),'交换信件','Letters exchanged'),
             'eliminate':(pluck([349.23,261.63],.36),'退出本轮','Round elimination'),
             'round_win':(pluck([392,493.88,587.33,783.99],.8),'获得好感','Favor awarded'),
             'end':(pluck([261.63,329.63,392,523.25],1.0),'情书整场结束','Love Letter ends')}
    path=CARD/'sounds.json'
    sounds=json.loads(path.read_text(encoding='utf-8')) if path.exists() else {}
    langs={}
    for lang in ('zh_cn','en_us'):
        path=CARD/f'lang/{lang}.json'
        langs[lang]=json.loads(path.read_text(encoding='utf-8')) if path.exists() else {}
    manifest=[]
    for name,(samples,chinese,english) in entries.items():
        manifest.append(save(name,samples))
        key=f'love_letter.{name}';sub=f'subtitles.card.{key}'
        sounds[key]={'subtitle':sub,'sounds':[{'name':f'card:love_letter/{name}','stream':False}]}
        langs['zh_cn'][sub]=chinese;langs['en_us'][sub]=english
        text_file(PACK/f'data/love_letter/function/sound/{name}.mcfunction',f'''
function love_letter:system/context
# 声源固定在本桌，仅发送给仍在本桌入座的参与者。
execute at @s positioned ~ ~1 ~ as @a[tag=ll.audience] if score @s ct_id = #table ll_ctx if score @s ll_table = #table ll_ctx run playsound card:{key} block @s ~ ~ ~ 0.6 1 0
''')
    # 仅向最新共享清单合并本游戏的键，保留阿瓦隆及其他游戏的已有内容。
    latest=json.loads((CARD/'sounds.json').read_text(encoding='utf-8')) if (CARD/'sounds.json').exists() else {}
    latest.update({k:v for k,v in sounds.items() if k.startswith('love_letter.')})
    json_file(CARD/'sounds.json',latest)
    for lang,values in langs.items():
        path=CARD/f'lang/{lang}.json'
        latest=json.loads(path.read_text(encoding='utf-8')) if path.exists() else {}
        latest.update({k:v for k,v in values.items() if k.startswith('subtitles.card.love_letter.')})
        json_file(path,latest)
    json_file(RP/'.source/love_letter/audio_manifest.json',manifest)
    text_file(RP/'.source/love_letter/audio/README.md','''# 情书原创音效

共八段纸张声、封蜡声和短促室内乐提示，由 Fimel Cards 数学合成，不使用商业游戏录音，不新增前置。
44,100 Hz、单声道、16 bit PCM 源文件保留在此；发布用 Vorbis OGG 在 assets/card/sounds/love_letter/。
脚本 tools/build_love_letter_sound.py，固定随机种子 20261101，需要 NumPy 与 FFmpeg。
audio_manifest.json 保存时长和发布文件 SHA-256；sound 回调限定本桌玩家，使用 Minecraft 方块音量分类。
''')
    print(f'Exported {len(manifest)} original Love Letter sounds; preserved all unrelated sound/lang keys.')


if __name__=='__main__':build()
