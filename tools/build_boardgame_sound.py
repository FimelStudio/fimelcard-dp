"""为五子棋／飞行棋合成原创短音效，保留无损源和可复现参数。"""
import hashlib
import json
import shutil
import subprocess
import wave
import numpy as np
from boardgame_assets import PACK, RP, CARD, text_file, json_file

RATE=44100
RNG=np.random.default_rng(20261031)


def knock(duration=.16, pitch=820, strength=1):
    t=np.arange(round(duration*RATE))/RATE
    n=RNG.normal(0,1,len(t))
    noise=np.convolve(n,np.ones(4)/4,mode='same')
    attack=1-np.exp(-t*3500)
    return strength*attack*(.48*np.sin(2*np.pi*pitch*t)*np.exp(-t*42)+
          .22*np.sin(2*np.pi*pitch*1.87*t)*np.exp(-t*65)+.28*noise*np.exp(-t*95))


def pluck(notes,duration=.55):
    t=np.arange(round(duration*RATE))/RATE
    return sum(np.sin(2*np.pi*f*t)*np.exp(-t*9)*(1-np.exp(-t*1800)) for f in notes)/len(notes)


def whoosh(duration=.26):
    t=np.arange(round(duration*RATE))/RATE
    n=RNG.normal(0,1,len(t));low=np.convolve(n,np.ones(13)/13,mode='same')
    return low*np.sin(np.pi*t/duration)**2+.12*np.sin(2*np.pi*(440*t+900*t*t))*np.sin(np.pi*t/duration)**2


def dice():
    value=np.zeros(RATE)
    times=[0,.055,.115,.185,.265,.36,.47,.60,.75,.91]
    for i,when in enumerate(times):
        click=knock(.07,1050+i*37,1-i*.045)
        start=round(when*RATE);end=min(len(value),start+len(click))
        value[start:end]+=click[:end-start]
    return value


def save(game,name,samples):
    samples=np.asarray(samples,dtype=np.float64)
    # 短首尾淡入淡出，输出单声道、无削波的16bit PCM。
    n=min(160,len(samples)//4)
    samples[:n]*=np.linspace(0,1,n);samples[-n:]*=np.linspace(1,0,n)
    peak=np.max(np.abs(samples));samples*=.72/max(peak,.001)
    source=RP/f'.source/boardgames/audio/{game}/{name}.wav';source.parent.mkdir(parents=True,exist_ok=True)
    with wave.open(str(source),'wb') as out:
        out.setnchannels(1);out.setsampwidth(2);out.setframerate(RATE)
        out.writeframes((samples*32767).round().astype('<i2').tobytes())
    target=CARD/f'sounds/{game}/{name}.ogg';target.parent.mkdir(parents=True,exist_ok=True)
    ffmpeg=shutil.which('ffmpeg') or 'D:/ffmpeg/bin/ffmpeg.exe'
    subprocess.run([ffmpeg,'-hide_banner','-loglevel','error','-y','-i',str(source),'-map_metadata','-1',
                    '-c:a','libvorbis','-q:a','5','-fflags','+bitexact',str(target)],check=True)
    return {'source':str(source.relative_to(RP)).replace('\\','/'),'output':str(target.relative_to(RP)).replace('\\','/'),
            'seconds':round(len(samples)/RATE,5),'sha256':hashlib.sha256(target.read_bytes()).hexdigest()}


def build():
    libraries={
        'gomoku':{'move':(knock(.17,760),'落子'), 'undo':(knock(.16,550)[::-1].copy(),'收回棋子'),
                  'illegal':(pluck([196,207.65],.15),'落点不可用'), 'start':(pluck([523.25,659.25],.42),'对局开始'),
                  'end':(pluck([523.25,659.25,783.99],.65),'对局结束')},
        'aeroplane_chess':{'dice_roll':(dice(),'骰子翻滚'), 'dice_land':(knock(.20,510),'骰子落稳'),
            'move':(knock(.065,1200),'飞机前进'),'takeoff':(whoosh(.24),'飞机起飞'),
            'jump':(pluck([880,1174.66],.16),'飞机跳格'),'fly':(whoosh(.35),'飞机飞越'),
            'capture':(knock(.22,390)+pluck([196],.22)*.3,'撞机返航'),
            'home':(pluck([659.25,987.77],.36),'飞机抵达终点'), 'illegal':(pluck([196,207.65],.15),'行动不可用'),
            'start':(pluck([523.25,659.25],.42),'对局开始'),'end':(pluck([523.25,659.25,783.99],.65),'对局结束')}}
    path=CARD/'sounds.json';sounds=json.loads(path.read_text(encoding='utf-8')) if path.exists() else {}
    languages={}
    for lang in ('zh_cn','en_us'):
        path=CARD/f'lang/{lang}.json'
        languages[lang]=json.loads(path.read_text(encoding='utf-8')) if path.exists() else {}
    manifest=[]
    for game,entries in libraries.items():
        prefix='gm' if game=='gomoku' else 'ac'
        for name,(samples,label) in entries.items():
            manifest.append(save(game,name,samples))
            key=f'{game}.{name}';subtitle=f'subtitles.card.{key}'
            sounds[key]={'subtitle':subtitle,'sounds':[{'name':f'card:{game}/{name}','stream':False}]}
            languages['zh_cn'][subtitle]=label
            languages['en_us'][subtitle]=key.replace('_',' ').replace('.',' ')
            target=f'@a[tag={prefix}.audience]'
            if name=='illegal':target=f'@a[tag={prefix}.audience,tag={prefix}.actor]'
            volume=.38 if name=='move' and prefix=='ac' else .65
            text_file(PACK/f'data/{game}/function/sound/{name}.mcfunction',f'''
# 固定本桌为声源；非法输入仅反馈操作者。
function {game}:system/context
execute at @s positioned ~ ~1 ~ as {target} if score @s ct_id = #table {prefix}_ctx if score @s {prefix}_table = #table {prefix}_ctx run playsound card:{key} block @s ~ ~ ~ {volume} 1 0
''')
    json_file(CARD/'sounds.json',sounds)
    for lang,value in languages.items():json_file(CARD/f'lang/{lang}.json',value)
    json_file(RP/'.source/boardgames/manifest.json',manifest)
    text_file(RP/'.source/boardgames/README.md','''
# 五子棋与飞行棋音效

全部由 Fimel Cards 自行合成，无外部音频或运行时前置。
无损源位于 audio/，发布资源为 assets/card/sounds/ 中的单声道 Vorbis OGG。
五子棋使用短促木石敲击；飞行棋使用逐渐放慢的骰子撞击、逐格轻敲、起飞与飞越风声、撞机和到达音。
从数据包根目录运行 `python tools/build_boardgame_sound.py`，依赖 NumPy 与 FFmpeg。
随机种子20261031、采样率44100 Hz，参数在生成脚本中；manifest.json记录时长及输出SHA-256。
声音由本桌控制器定位，发送给仍属于本桌的玩家，音量受Minecraft「方块」分类控制。
''')
    print(f'Generated {len(manifest)} original sounds and table-scoped callbacks.')


if __name__=='__main__':build()
