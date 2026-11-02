"""Build CATAN's table-private CC0 audio and its playback functions.

Original downloads, authors' license declarations and hashes live in the resource
pack's .source/catan/audio. No other game's sounds.json entries are replaced.
"""
from pathlib import Path
import argparse
import hashlib
import json
import math
import subprocess

PACK = Path(__file__).resolve().parents[1]
RP = PACK.parents[3] / 'resourcepacks/fimelcard-rp'
OBJECTIVES = {'ca_music': 'dummy', 'ca_bgm': 'dummy', 'ca_bgm_on': 'dummy', 'ca_bgm_table': 'dummy'}
EVENTS = {
    'roll': ('kenney/casino/dice-throw-1.ogg', 'volume=0.85', '掷出骰子', 0.65),
    'road': ('kenney/impact/impactWood_light_000.ogg', 'volume=0.8', '铺设道路', 0.48),
    'settlement': ('kenney/impact/impactWood_medium_000.ogg', 'volume=0.7', '建造村庄', 0.50),
    'city': ('kenney/impact/impactWood_heavy_000.ogg', 'volume=0.65', '升级城市', 0.55),
    'trade': ('kenney/casino/chips-collide-1.ogg', 'volume=0.7', '完成交易', 0.45),
    'robber': ('kenney/casino/card-shove-1.ogg', 'volume=0.7', '移动强盗', 0.42),
    'development': ('kenney/casino/card-shuffle.ogg', 'volume=0.7', '使用开发牌', 0.42),
    'win': ('kenney/impact/impactBell_heavy_000.ogg', 'asetrate=52920,aresample=44100,volume=0.5,afade=t=out:st=0.5:d=0.8', '获得胜利', 0.50),
    'lose': ('kenney/impact/impactBell_heavy_000.ogg', 'asetrate=35280,aresample=44100,volume=0.3,afade=t=out:st=0.3:d=1.5', '对局结束', 0.40),
    'illegal': ('kenney/impact/impactSoft_medium_000.ogg', 'volume=0.6', '无法执行', 0.35),
}
MUSIC = 'Loop_The_Old_Tower_Inn.wav'
MUSIC_FILTER = 'volume=0.75'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def probe(path):
    return json.loads(subprocess.check_output(['ffprobe', '-v', 'error', '-show_entries',
        'format=duration:stream=codec_name,sample_rate,channels', '-of', 'json', str(path)], text=True))


def build_assets(rp=RP):
    source = rp / '.source/catan/audio'
    dest = rp / 'assets/card/sounds/catan'
    dest.mkdir(parents=True, exist_ok=True)
    manifest = {'license': 'CC0-1.0', 'license_url': 'https://creativecommons.org/publicdomain/zero/1.0/',
        'sources': [
            {'author': 'Kenney', 'title': 'Casino Audio 1.1', 'page': 'https://kenney.nl/assets/casino-audio',
             'license_file': 'kenney/casino/License.txt', 'page_snapshot': 'kenney-casino-page.html'},
            {'author': 'Kenney', 'title': 'Impact Sounds 1.0', 'page': 'https://kenney.nl/assets/impact-sounds',
             'license_file': 'kenney/impact/License.txt', 'page_snapshot': 'kenney-impact-page.html'},
            {'author': 'RandomMind', 'title': 'Medieval: The Old Tower Inn (loop)',
             'page': 'https://opengameart.org/content/medieval-the-old-tower-inn',
             'download': 'https://opengameart.org/sites/default/files/Loop_The_Old_Tower_Inn.wav',
             'page_snapshot': 'randommind-page.html', 'license_file': 'CC0-1.0.txt'},
        ], 'audio': {}}
    sound_file = rp / 'assets/card/sounds.json'
    sounds = json.loads(sound_file.read_text(encoding='utf-8')) if sound_file.exists() else {}
    subtitles = {}
    definitions = dict(EVENTS)
    definitions['bgm'] = (MUSIC, MUSIC_FILTER, '田园背景音乐', 0.20)
    for event, (original, filters, subtitle, _volume) in definitions.items():
        src, target = source / original, dest / (event + '.ogg')
        command = ['ffmpeg', '-hide_banner', '-loglevel', 'error', '-y', '-i', str(src),
            '-ac', '1', '-ar', '44100', '-af', filters, '-c:a', 'libvorbis', '-q:a',
            '4' if event == 'bgm' else '5', '-map_metadata', '-1', str(target)]
        subprocess.run(command, check=True)
        details = probe(target)
        manifest['audio'][event] = {'source': original, 'source_sha256': sha(src),
            'output': 'assets/card/sounds/catan/' + event + '.ogg', 'output_sha256': sha(target),
            'filter': filters, 'format': details, 'encoding': 'mono 44100 Hz Ogg Vorbis; metadata removed'}
        item = {'name': 'card:catan/' + event}
        if event == 'bgm':
            item['stream'] = True
        sounds['catan.' + event] = {'sounds': [item], 'subtitle': 'subtitles.card.catan.' + event}
        subtitles['subtitles.card.catan.' + event] = subtitle
    sound_file.write_text(json.dumps(sounds, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    for locale in ('zh_cn', 'en_us'):
        path = rp / 'assets/card/lang' / (locale + '.json')
        path.parent.mkdir(parents=True, exist_ok=True)
        values = json.loads(path.read_text(encoding='utf-8')) if path.exists() else {}
        english = {'roll': 'Dice roll', 'road': 'Road built', 'settlement': 'Settlement built',
            'city': 'City upgraded', 'trade': 'Trade completed', 'robber': 'Robber moved',
            'development': 'Development card played', 'win': 'Victory', 'lose': 'Game over',
            'illegal': 'Action unavailable', 'bgm': 'Pastoral music'}
        values.update(subtitles if locale == 'zh_cn' else {'subtitles.card.catan.' + k: v for k, v in english.items()})
        path.write_text(json.dumps(values, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    duration = float(manifest['audio']['bgm']['format']['format']['duration'])
    manifest['loop_ticks'] = math.ceil(duration * 20)
    manifest['retained_files'] = {str(path.relative_to(source)).replace('\\', '/'): sha(path)
        for path in sorted(source.rglob('*')) if path.is_file() and path.name not in ('manifest.json', 'README.md')}
    (source / 'manifest.json').write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    return manifest['loop_ticks']


def build(root=PACK / 'data/catan/function', loop_ticks=1000):
    def put(name, lines):
        path = root / 'sound' / (name + '.mcfunction')
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(('\n'.join(lines) if isinstance(lines, list) else lines).strip() + '\n', encoding='utf-8')
    put('load', [f'scoreboard objectives add {key} {kind}' for key, kind in OBJECTIVES.items()] + [
        '# ca_ctx belongs to the game installer, not to this module.',
        'execute as @a run function catan:sound/stop_player'])
    put('stop_player', ['stopsound @s record card:catan.bgm',
        'scoreboard players reset @s ca_bgm_on', 'scoreboard players reset @s ca_bgm_table'])
    put('stop', ['scoreboard players operation #sound_table ca_ctx = @s ct_id',
        'scoreboard players set @s ca_bgm 0',
        'execute as @a[scores={ca_bgm_on=1}] if score @s ca_bgm_table = #sound_table ca_ctx run function catan:sound/stop_player'])
    put('start_player', ['stopsound @s record card:catan.bgm',
        'playsound card:catan.bgm record @s ~ ~ ~ 0.20 1 0',
        'scoreboard players set @s ca_bgm_on 1',
        'scoreboard players operation @s ca_bgm_table = #sound_table ca_ctx'])
    put('start', ['function catan:sound/stop',
        'execute unless score @s ct_game matches 21 run return 0',
        'execute unless score @s ct_state matches 1 run return 0',
        'execute if score @s ca_finish matches 1.. run return 0',
        'execute if score @s ca_state matches 11 run return 0',
        'execute unless score @s ca_music matches 1 run return 0',
        f'scoreboard players set @s ca_bgm {loop_ticks}',
        'execute at @s positioned ~ ~1 ~ as @a[tag=ca.player,tag=ct.player] if score @s ca_table = #sound_table ca_ctx if score @s ct_id = #sound_table ca_ctx run function catan:sound/start_player'])
    put('verify_player', [
        'execute unless entity @s[tag=ca.player,tag=ct.player] run return run function catan:sound/stop_player',
        'execute unless score @s ca_table = #sound_table ca_ctx run return run function catan:sound/stop_player',
        'execute unless score @s ct_id = #sound_table ca_ctx run return run function catan:sound/stop_player'])
    put('tick', [
        'execute unless score @s ct_game matches 21 run return run function catan:sound/stop',
        'execute unless score @s ct_state matches 1 run return run function catan:sound/stop',
        'execute if score @s ca_finish matches 1.. run return run function catan:sound/stop',
        'execute if score @s ca_state matches 11 run return run function catan:sound/stop',
        'execute unless score @s ca_music matches 1 run return run function catan:sound/stop',
        'scoreboard players operation #sound_table ca_ctx = @s ct_id',
        'execute as @a[scores={ca_bgm_on=1}] if score @s ca_bgm_table = #sound_table ca_ctx run function catan:sound/verify_player',
        'execute if score @s ca_bgm matches 1.. run scoreboard players remove @s ca_bgm 1',
        'execute unless score @s ca_bgm matches 1.. run return run function catan:sound/start',
        'execute at @s positioned ~ ~1 ~ as @a[tag=ca.player,tag=ct.player] if score @s ca_table = #sound_table ca_ctx if score @s ct_id = #sound_table ca_ctx unless score @s ca_bgm_on matches 1 run function catan:sound/start_player'])
    put('reload', ['function catan:sound/stop',
        'execute if score @s ct_game matches 21 if score @s ct_state matches 1 if score @s ca_music matches 1 run function catan:sound/start'])
    put('toggle', [
        'execute unless score @s ct_game matches 21 run return 0',
        'scoreboard players operation #sound_music ca_ctx = @s ca_music',
        'scoreboard players set @s ca_music 1',
        'execute if score #sound_music ca_ctx matches 1 run scoreboard players set @s ca_music 0',
        'execute if score @s ca_music matches 0 run return run function catan:sound/stop',
        'function catan:sound/start'])
    for event, (_src, _filter, _subtitle, volume) in EVENTS.items():
        if event == 'illegal':
            put(event + '_player', f'playsound card:catan.{event} block @s ~ ~ ~ {volume} 1 0')
            audience = '@a[tag=ca.player,tag=ct.player,tag=ca.actor]'
        else:
            audience = '@a[tag=ca.player,tag=ct.player]'
        lines = ['# Keep controller position as source; never retarget another table.',
            'scoreboard players operation #sound_table ca_ctx = @s ct_id',
            f'execute at @s positioned ~ ~1 ~ as {audience} if score @s ca_table = #sound_table ca_ctx if score @s ct_id = #sound_table ca_ctx run playsound card:catan.{event} block @s ~ ~ ~ {volume} 1 0']
        if event == 'illegal':
            lines.insert(1, 'execute if entity @s[type=minecraft:player] run return run function catan:sound/illegal_player')
        put(event, lines)
        if event in ('win', 'lose'):
            put(event + '_player', f'playsound card:catan.{event} block @s ~ ~ ~ {volume} 1 0')
    put('result', ['function catan:sound/stop',
        'scoreboard players operation #sound_winner ca_ctx = @s ca_winner',
        'execute at @s positioned ~ ~1 ~ as @a[tag=ca.player,tag=ct.player] if score @s ca_table = #sound_table ca_ctx if score @s ct_id = #sound_table ca_ctx if score @s ca_side = #sound_winner ca_ctx run function catan:sound/win_player',
        'execute at @s positioned ~ ~1 ~ as @a[tag=ca.player,tag=ct.player] if score @s ca_table = #sound_table ca_ctx if score @s ct_id = #sound_table ca_ctx unless score @s ca_side = #sound_winner ca_ctx run function catan:sound/lose_player'])


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--assets', action='store_true', help='Re-encode retained sources and merge sound/subtitle keys')
    args = parser.parse_args()
    ticks = build_assets() if args.assets else 1000
    build(loop_ticks=ticks)
