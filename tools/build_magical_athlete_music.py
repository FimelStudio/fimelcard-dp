"""Import user-provided wild-track music and route music by the actual board."""
import argparse
import hashlib
import json
import math
import re
import shutil
import subprocess
from pathlib import Path
from boardgame_assets import RP, json_file

SOURCE=RP/'.source/magical_athlete/audio'
ORIGINAL=SOURCE/'imports/wake up.ogg'
OUTPUT=RP/'assets/magical_athlete/sounds/bgm_wild.ogg'
NORMAL=RP/'assets/magical_athlete/sounds/bgm.ogg'


def digest(path):return hashlib.sha256(path.read_bytes()).hexdigest()


def loudness(path,target=-23):
    result=subprocess.run(['ffmpeg','-nostdin','-hide_banner','-nostats','-i',str(path),
        '-af',f'aformat=channel_layouts=mono,loudnorm=I={target}:TP=-2:LRA=11:print_format=json',
        '-f','null','-'],capture_output=True,text=True,check=True)
    return json.loads(re.search(r'\{\s*"input_i"[\s\S]*?\}',result.stderr)[0])


def build(import_from=None):
    if import_from is not None:
        path=Path(import_from).resolve(strict=True)
        ORIGINAL.parent.mkdir(parents=True,exist_ok=True)
        if path!=ORIGINAL.resolve():shutil.copy2(path,ORIGINAL)
    if not ORIGINAL.exists():return None
    reference=loudness(NORMAL);incoming=loudness(ORIGINAL,float(reference['input_i']))
    duration=float(subprocess.check_output(['ffprobe','-v','error','-show_entries','format=duration',
        '-of','default=noprint_wrappers=1:nokey=1',str(ORIGINAL)],text=True))
    OUTPUT.parent.mkdir(parents=True,exist_ok=True)
    filters=('aformat=channel_layouts=mono,'
        f'loudnorm=I={reference["input_i"]}:TP=-2:LRA=11:'
        f'measured_I={incoming["input_i"]}:measured_TP={incoming["input_tp"]}:'
        f'measured_LRA={incoming["input_lra"]}:measured_thresh={incoming["input_thresh"]}:'
        f'offset={incoming["target_offset"]}:linear=false,'
        f'afade=t=in:d=0.025,afade=t=out:st={max(0,duration-.05):.6f}:d=0.05')
    subprocess.run(['ffmpeg','-nostdin','-hide_banner','-loglevel','error','-y','-i',str(ORIGINAL),
        '-af',filters,'-ac','1','-ar','44100','-c:a','libvorbis','-q:a','4','-map_metadata','-1',
        '-fflags','+bitexact','-flags:a','+bitexact',str(OUTPUT)],check=True)
    measured=loudness(OUTPUT)
    if abs(float(measured['input_i'])-float(reference['input_i']))>1:
        raise ValueError('Wild and mild music loudness differs by more than 1 LU')
    output_duration=float(subprocess.check_output(['ffprobe','-v','error','-show_entries','format=duration',
        '-of','default=noprint_wrappers=1:nokey=1',str(OUTPUT)],text=True))
    record={'original':ORIGINAL.relative_to(SOURCE).as_posix(),'original_sha256':digest(ORIGINAL),
        'resource':'magical_athlete:bgm_wild','output':OUTPUT.relative_to(RP).as_posix(),'sha256':digest(OUTPUT),
        'title':'wake up','duration':output_duration,'source_duration':duration,'loop_ticks':math.ceil(output_duration*20),'playback_volume':.16,
        'encoding':'mono 44100Hz Ogg Vorbis','license':'Not specified; user-provided audio',
        'normalization':{'reference':'magical_athlete:bgm','reference_lufs':float(reference['input_i']),
                         'source_mono_lufs':float(incoming['input_i']),'method':'two-pass loudnorm with transient peak limiting',
                         'output_lufs':float(measured['input_i']),'output_true_peak_dbfs':float(measured['input_tp'])}}
    manifest=json.loads((SOURCE/'manifest.json').read_text(encoding='utf-8'))
    for entry in manifest['audio'].values():entry.setdefault('license','CC0-1.0')
    manifest['license']='Mixed; see each audio entry'
    manifest['audio']['bgm_wild']=record
    json_file(SOURCE/'manifest.json',manifest)
    definitions=json.loads((RP/'assets/magical_athlete/sounds.json').read_text(encoding='utf-8'))
    definitions['bgm_wild']={'sounds':[{'name':record['resource'],'stream':True}]}
    json_file(RP/'assets/magical_athlete/sounds.json',definitions)
    readme=SOURCE/'README.md'
    text=readme.read_text(encoding='utf-8').split('\n## 狂野赛道音乐')[0].rstrip()
    text+='\n\n## 狂野赛道音乐\n\n`bgm_wild.ogg` 为用户提供的《wake up》，原始文件保留在 `imports/wake up.ogg`。普通赛道仍使用原创 `bgm`。两首均按 0.16 播放；新增曲目先转单声道，再以两遍响度归一化与瞬时峰值限制对齐普通曲目的综合响度，保留完整时长，按实际长度循环。响度、时长与哈希见 manifest。\n\n此曲不属于本目录原创合成音频的 CC0 授权；未提供额外许可信息。重建时运行 `python tools/build_magical_athlete_music.py`，无需再次访问原始磁盘路径。切换赛道会先停止旧曲，暂停、关闭音乐、结束游戏及离桌均停止两种音乐。\n'
    readme.write_text(text,encoding='utf-8')
    license_file=SOURCE/'LICENSE.txt'
    text=license_file.read_text(encoding='utf-8').split('\nUser-provided music exclusion:')[0].rstrip()
    license_file.write_text(text+'\n\nUser-provided music exclusion: imports/wake up.ogg and its converted bgm_wild.ogg are not covered by the CC0 dedication above. No additional license was supplied.\n',encoding='utf-8')
    functions()
    return record


def functions():
    from build_magical_athlete_game import put
    manifest=json.loads((SOURCE/'manifest.json').read_text(encoding='utf-8'))
    wild_ticks=manifest['audio']['bgm_wild']['loop_ticks']
    put('sound/start',['execute if score @s ct_paused matches 1 run return 0',
        'function magical_athlete:sound/stop','execute if score @s ma_music matches 1 run function magical_athlete:sound/play'])
    put('sound/play',['execute if score @s ct_paused matches 1 run return 0',
        'execute unless score @s ma_music matches 1 run return 0','function magical_athlete:sound/context',
        'execute if data entity @s data.magical_athlete{track:1} run return run function magical_athlete:sound/play_wild',
        'function magical_athlete:sound/play_mild'])
    for kind,event,ticks,track in [('mild','bgm',640,0),('wild','bgm_wild',wild_ticks,1)]:
        put('sound/play_'+kind,[f'execute as @a[tag=ma.sound_audience] at @s run playsound magical_athlete:{event} record @s ~ ~ ~ 0.16 1',
            f'scoreboard players set @s ma_music_tick {ticks}',f'data modify entity @s data.ma_sound.track set value {track}'])
    put('sound/tick',['execute if score @s ct_paused matches 1 run return 0',
        'execute unless score @s ma_music matches 1 run return 0',
        'execute if data entity @s data.magical_athlete{track:1} unless data entity @s data.ma_sound{track:1} run return run function magical_athlete:sound/start',
        'execute unless data entity @s data.magical_athlete{track:1} unless data entity @s data.ma_sound{track:0} run return run function magical_athlete:sound/start',
        'scoreboard players remove @s ma_music_tick 1',
        'execute if score @s ma_music_tick matches ..0 run function magical_athlete:sound/play'])
    put('sound/stop',['function magical_athlete:sound/context',
        'execute as @a[tag=ma.sound_audience] run function magical_athlete:sound/stop_player',
        'scoreboard players set @s ma_music_tick 0','data remove entity @s data.ma_sound'])
    put('sound/stop_player',['stopsound @s record magical_athlete:bgm','stopsound @s record magical_athlete:bgm_wild'])


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--import-from',type=Path)
    args=parser.parse_args()
    result=build(args.import_from)
    if result:print(json.dumps(result['normalization'],ensure_ascii=False),'; loop ticks =',result['loop_ticks'])
