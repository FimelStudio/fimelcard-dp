"""掼蛋复用斗地主四段音乐；只增补掼蛋生命周期，不复制音频。"""
from pathlib import Path
from build_table_pause_guards import write_guarded

PACK = Path(__file__).resolve().parents[1]
ROOT = PACK / 'data/guandan/function'
TRACKS = {'normal': (1, 580), 'exciting': (2, 623), 'win': (3, 76), 'lose': (4, 60)}


def put(name, body):
    path = ROOT / (name + '.mcfunction')
    path.parent.mkdir(parents=True, exist_ok=True)
    write_guarded(path, body.strip() + '\n', encoding='utf-8')


def hook(name, key, body, before=None, after=None):
    path = ROOT / (name + '.mcfunction')
    text = path.read_text(encoding='utf-8')
    begin, end = '# BEGIN ' + key, '# END ' + key
    block = begin + '\n' + body.strip() + '\n' + end + '\n'
    if begin in text:
        first = text.index(begin)
        last = text.index(end, first) + len(end)
        text = text[:first] + block + text[last:].lstrip('\n')
    elif before:
        assert before in text, (name, before)
        text = text.replace(before, block + before, 1)
    elif after:
        assert after in text, (name, after)
        text = text.replace(after, after + '\n' + block.rstrip('\n'), 1)
    else:
        text = text.rstrip() + '\n' + block
    put(name, text)


def build():
    put('music/load', '''
scoreboard objectives add gd_audio dummy
scoreboard objectives add gd_music dummy
scoreboard objectives add gd_mtime dummy
# 重载只重启播放，不重置本桌开关、紧张状态或副数。
execute as @a[scores={gd_music=1..}] run function guandan:music/stop
''')
    put('music/stop', '\n'.join(
        'execute if score @s gd_music matches 1.. run stopsound @s record card:doudizhu.' + name
        for name in TRACKS) + '\nscoreboard players set @s gd_music 0\nscoreboard players set @s gd_mtime 0')
    for name, (mode, ticks) in TRACKS.items():
        put('music/start_' + name, f'''
function guandan:music/stop
scoreboard players set @s gd_music {mode}
scoreboard players set @s gd_mtime {ticks}
execute at @s run playsound card:doudizhu.{name} record @s ~ ~ ~ 1 1 1
''')
    put('music/begin', '''
# 每副重新进入普通音乐；紧张音乐只锁定当前这一副。
tag @s remove gd.music_exciting
function guandan:music/table_tick
''')
    put('music/check_exciting', '''
execute if score @s gd_kind matches 8..10 run tag @s add gd.music_exciting
execute if entity @e[tag=gd.board,scores={gd_count=1..2}] run tag @s add gd.music_exciting
''')
    put('music/table_tick', '''
function guandan:system/context
execute if entity @s[tag=gd.music_suspended] run function guandan:music/resume
execute if score @s gd_audio matches 0 as @a[tag=gd.audience] if score @s gd_music matches 1.. run function guandan:music/stop
execute if score @s gd_audio matches 0 run return 0
execute unless score @s gd_state matches 1..5 run return 0
scoreboard players remove @a[tag=gd.audience,scores={gd_mtime=1..}] gd_mtime 1
execute if score @s gd_state matches 1..3 run function guandan:music/playing
execute if score @s gd_state matches 4..5 run function guandan:music/result
''')
    put('music/playing', '''
scoreboard players set #music_mode gd_ctx 1
execute if entity @s[tag=gd.music_exciting] run scoreboard players set #music_mode gd_ctx 2
execute as @a[tag=gd.audience] unless score @s gd_music = #music_mode gd_ctx run function guandan:music/sync_playing
execute as @a[tag=gd.audience,scores={gd_music=1,gd_mtime=..0}] run function guandan:music/start_normal
execute as @a[tag=gd.audience,scores={gd_music=2,gd_mtime=..0}] run function guandan:music/start_exciting
''')
    put('music/sync_playing', '''
execute if score #music_mode gd_ctx matches 1 run function guandan:music/start_normal
execute if score #music_mode gd_ctx matches 2 run function guandan:music/start_exciting
''')
    put('music/result', '''
scoreboard players operation #music_winner gd_ctx = @s gd_winner
execute if score @s gd_state matches 5 run scoreboard players operation #music_winner gd_ctx = @s gd_matchwin
# 固定副数平局停背景音乐；胜负曲只放一次，不在时长归零后循环。
execute unless score #music_winner gd_ctx matches 0..1 as @a[tag=gd.audience] if score @s gd_music matches 1.. run function guandan:music/stop
execute unless score #music_winner gd_ctx matches 0..1 run return 0
execute as @a[tag=gd.audience] if score @s gd_team = #music_winner gd_ctx unless score @s gd_music matches 3 run function guandan:music/start_win
execute as @a[tag=gd.audience] unless score @s gd_team = #music_winner gd_ctx unless score @s gd_music matches 4 run function guandan:music/start_lose
''')
    put('music/pause', '''
# 公共暂停层以本桌控制器调用；不依赖已暂停的游戏 tick。
tag @s add gd.music_suspended
scoreboard players operation #music_table gd_ctx = @s ct_id
execute as @a[tag=gd.player,tag=ct.player] if score @s ct_id = #music_table gd_ctx if score @s gd_table = #music_table gd_ctx run function guandan:music/stop
''')
    put('music/resume', '''
# 掉线者记分仍记录旧曲，但客户端音频已经中断；恢复时全桌统一重播。
function guandan:music/pause
tag @s remove gd.music_suspended
''')
    hook('load', 'guandan shared music load', 'function guandan:music/load', before='function guandan:visual/load')
    hook('game/init_table', 'guandan music setting', 'execute unless score @s gd_audio matches 0..1 run scoreboard players set @s gd_audio 1', before='execute if score @s ct_state matches 1 run return 0')
    hook('round/begin', 'guandan round music', 'function guandan:music/begin', after='function guandan:sound/start')
    hook('game/tick', 'guandan music tick', 'function guandan:music/table_tick')
    hook('game/commit', 'guandan exciting music', 'function guandan:music/check_exciting', before='function guandan:round/check_end')
    hook('round/over', 'guandan result music', 'function guandan:music/table_tick', before='function guandan:visual/refresh')
    hook('system/reload', 'guandan reload music', 'function guandan:music/table_tick', after='function guandan:system/context')
    hook('player/clear_state', 'guandan stop music', 'function guandan:music/stop', before='function guandan:hud/deactivate')
    hook('game/clear', 'guandan clear music mode', 'tag @s remove gd.music_exciting\ntag @s remove gd.music_suspended', before='function guandan:system/context')


if __name__ == '__main__':
    build()
