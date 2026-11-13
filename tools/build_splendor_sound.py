"""璀璨宝石按桌播放：复用已内置、保留许可原件的 CC0 声音。"""
from __future__ import annotations

import hashlib
import json
import math
from boardgame_assets import PACK, RP, json_file, text_file

ROOT = PACK/'data/splendor/function/sound'
OBJECTIVES = {name: 'dummy' for name in ('sp_bgm', 'sp_bgm_on', 'sp_bgm_table')}
EVENTS = {'take': ('trade', .48), 'reserve': ('robber', .42), 'buy': ('settlement', .50),
          'return': ('trade', .37), 'noble': ('win', .48), 'win': ('win', .56),
          'illegal': ('illegal', .32)}


def put(name, lines):
    text_file(ROOT/(name+'.mcfunction'), '\n'.join(lines) if isinstance(lines, list) else lines)


def build():
    original = RP/'.source/catan/audio/manifest.json'
    manifest = json.loads(original.read_text(encoding='utf-8'))
    loop = math.ceil(float(manifest['audio']['bgm']['format']['format']['duration'])*20)
    definitions = {}
    refs = {}
    for event, (source, volume) in {**EVENTS, 'bgm': ('bgm', .18)}.items():
        path = RP/('assets/card/sounds/catan/'+source+'.ogg')
        if not path.exists():
            raise FileNotFoundError(path)
        entry = {'name': 'card:catan/'+source}
        if event == 'bgm':
            entry['stream'] = True
        definitions[event] = {'sounds': [entry]}
        refs[event] = {'resource': entry['name'], 'volume': volume,
                      'sha256': hashlib.sha256(path.read_bytes()).hexdigest(),
                      'original': manifest['audio'][source]}
    json_file(RP/'assets/splendor/sounds.json', definitions)
    json_file(RP/'.source/splendor/audio/manifest.json', {'license': 'CC0-1.0',
        'sources': manifest['sources'], 'loop_ticks': loop, 'references': refs,
        'retained_originals': '.source/catan/audio/', 'duplicated_audio': False})
    text_file(RP/'.source/splendor/audio/README.md', '''# 璀璨宝石音频来源

沿用数据包已合并的 CC0 声音，不重复打包音频：

- 拿取／退回宝石：Kenney《Casino Audio 1.1》chips-collide-1.ogg。
- 预约牌：同包 card-shove-1.ogg。
- 购买开发牌：Kenney《Impact Sounds 1.0》impactWood_medium_000.ogg。
- 贵族到访／胜利：同包 impactBell_heavy_000.ogg。
- 无法操作：同包 impactSoft_medium_000.ogg。
- 可关闭背景音乐：RandomMind《Medieval: The Old Tower Inn (loop)》。

来源：[Casino Audio](https://kenney.nl/assets/casino-audio)、[Impact Sounds](https://kenney.nl/assets/impact-sounds)、[The Old Tower Inn](https://opengameart.org/content/medieval-the-old-tower-inn)。
均为 CC0-1.0；作者原文件、页面快照、许可和编码记录保存在 ../../catan/audio/（从资源包 .source 根目录定位为 catan/audio/）。
本目录 manifest.json 逐项记录实际引用、原始文件、处理参数和 SHA-256。事件独立注册在 assets/splendor/sounds.json，引用 assets/card/sounds/catan/，不改其他游戏声音。
在数据包根目录运行 python tools/build_splendor_sound.py 重建事件注册和播放函数；需要重新编码公共音源时使用 python tools/build_catan_sound.py --assets（需 ffmpeg）。

音乐仅发送本桌玩家，使用独立 splendor:bgm 事件；关闭选项、暂停、结束、清理和旧局重连都应调用 stop／stop_player。恢复对局可重新从曲首播放，不改变规则状态。
''')
    put('load', [f'scoreboard objectives add {name} dummy' for name in ('sp_bgm', 'sp_bgm_on', 'sp_bgm_table')]+
        ['execute as @a run function splendor:sound/stop_player'])
    put('context', 'scoreboard players operation #sound_table sp_ctx = @s ct_id')
    put('stop_player', ['stopsound @s record splendor:bgm',
        'scoreboard players reset @s sp_bgm_on', 'scoreboard players reset @s sp_bgm_table'])
    put('stop', ['function splendor:sound/context', 'scoreboard players set @s sp_bgm 0',
        'execute as @a[scores={sp_bgm_on=1}] if score @s sp_bgm_table = #sound_table sp_ctx run function splendor:sound/stop_player'])
    put('pause', 'function splendor:sound/stop')
    put('start_player', ['stopsound @s record splendor:bgm',
        'playsound splendor:bgm record @s ~ ~ ~ 0.18 1 0',
        'scoreboard players set @s sp_bgm_on 1',
        'scoreboard players operation @s sp_bgm_table = #sound_table sp_ctx'])
    put('start', ['function splendor:sound/stop',
        'execute unless score @s ct_game matches 22 run return 0',
        'execute unless score @s ct_state matches 1 run return 0',
        'execute if score @s ct_paused matches 1 run return 0',
        'execute unless score @s sp_music matches 1 run return 0',
        'execute if data entity @s data.splendor{phase:4} run return 0',
        f'scoreboard players set @s sp_bgm {loop}',
        'execute as @a[tag=sp.player,tag=ct.player] if score @s sp_table = #sound_table sp_ctx if score @s ct_id = #sound_table sp_ctx at @s run function splendor:sound/start_player'])
    put('tick', ['execute if score @s ct_paused matches 1 run return run function splendor:sound/stop',
        'execute unless score @s ct_state matches 1 run return run function splendor:sound/stop',
        'execute unless score @s ct_game matches 22 run return run function splendor:sound/stop',
        'execute unless score @s sp_music matches 1 run return run function splendor:sound/stop',
        'execute if data entity @s data.splendor{phase:4} run return run function splendor:sound/stop',
        'scoreboard players remove @s sp_bgm 1',
        'execute unless score @s sp_bgm matches 1.. run function splendor:sound/start'])
    put('reload', ['function splendor:sound/stop', 'function splendor:sound/start'])
    for event, (_source, volume) in EVENTS.items():
        audience = '@a[tag=sp.player,tag=ct.player' + (',tag=sp.actor' if event == 'illegal' else '') + ']'
        put(event, ['function splendor:sound/context',
            'execute if score @s ct_paused matches 1 run return 0',
            f'execute as {audience} if score @s sp_table = #sound_table sp_ctx if score @s ct_id = #sound_table sp_ctx at @s run playsound splendor:{event} block @s ~ ~ ~ {volume} 1 0'])
        put(event+'_player', f'playsound splendor:{event} block @s ~ ~ ~ {volume} 1 0')
    put('result', ['function splendor:sound/stop', 'function splendor:sound/win'])
    put('event', ['$function splendor:sound/$(event)'])


if __name__ == '__main__':
    build()
