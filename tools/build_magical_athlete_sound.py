# -*- coding: utf-8 -*-
"""胡闹运动会原创轻快循环与短音效；只导出本游戏资源，不修改其他游戏。"""
from __future__ import annotations

import hashlib
import json
import math
import subprocess
import wave

import numpy as np
from boardgame_assets import RP, json_file, text_file

SOURCE = RP / '.source/magical_athlete/audio'
DEST = RP / 'assets/magical_athlete/sounds'
RATE = 44100
LOOP_TICKS = 640


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def tone(note, duration, amplitude=.25, kind='pluck'):
    t = np.arange(round(RATE * duration), dtype=np.float64) / RATE
    frequency = 440 * 2 ** ((note - 69) / 12)
    base = np.sin(2 * math.pi * frequency * t)
    if kind == 'pluck':
        sound = base + .28 * np.sin(4 * math.pi * frequency * t) + .10 * np.sin(6 * math.pi * frequency * t)
        envelope = np.minimum(t / .004, 1) * np.exp(-t * 9 / max(duration, .3))
    elif kind == 'bass':
        sound = base + .2 * np.sin(4 * math.pi * frequency * t)
        envelope = np.minimum(t / .008, 1) * np.minimum((duration - t) / .035, 1)
    else:
        sound = base
        envelope = np.minimum(t / .01, 1) * np.exp(-t * 4 / duration)
    return amplitude * sound * envelope


def add(output, start, sample):
    offset = round(start * RATE)
    length = min(len(sample), len(output) - offset)
    if length > 0:
        output[offset:offset + length] += sample[:length]


def save(name, values):
    SOURCE.mkdir(parents=True, exist_ok=True)
    DEST.mkdir(parents=True, exist_ok=True)
    wav, ogg = SOURCE / (name + '.wav'), DEST / (name + '.ogg')
    values = np.asarray(values, dtype=np.float64)
    peak = max(1, np.max(np.abs(values)) / .88)
    values = np.clip(values / peak, -1, 1)
    if len(values) > 882:
        values[:220] *= np.linspace(0, 1, 220)
        values[-440:] *= np.linspace(1, 0, 440)
    with wave.open(str(wav), 'wb') as stream:
        stream.setnchannels(1)
        stream.setsampwidth(2)
        stream.setframerate(RATE)
        stream.writeframes((values * 32767).astype('<i2').tobytes())
    subprocess.run(['ffmpeg', '-hide_banner', '-loglevel', 'error', '-y', '-i', str(wav),
                    '-ac', '1', '-ar', str(RATE), '-c:a', 'libvorbis', '-q:a',
                    '4' if name == 'bgm' else '5', '-map_metadata', '-1',
                    '-fflags', '+bitexact', '-flags:a', '+bitexact', str(ogg)], check=True)
    return {'original': str(wav.relative_to(SOURCE)), 'original_sha256': sha(wav),
            'resource': 'magical_athlete:' + name, 'output': str(ogg.relative_to(RP)).replace('\\', '/'),
            'sha256': sha(ogg), 'duration': round(len(values) / RATE, 6),
            'encoding': 'mono 44100Hz Ogg Vorbis'}


def music():
    # Original 16-bar / 120 BPM C-major sports theme. No sampled or copied melody.
    beat = .5
    output = np.zeros(32 * RATE)
    chords = [(48, 52, 55), (45, 48, 52), (53, 57, 60), (55, 59, 62)] * 4
    phrases = [
        [76, 79, 81, 79, 76, 74, 72, 74], [76, 79, 84, 81, 79, 76, 74, 72],
        [77, 81, 84, 81, 77, 76, 74, 72], [74, 79, 83, 81, 79, 76, 74, 79],
        [84, 83, 81, 79, 76, 79, 81, 76], [81, 79, 76, 74, 72, 74, 76, 79],
        [77, 79, 81, 84, 86, 84, 81, 77], [79, 83, 86, 83, 79, 77, 74, 71],
        [76, 0, 79, 81, 79, 76, 74, 72], [76, 79, 84, 0, 81, 79, 76, 72],
        [77, 81, 84, 86, 84, 81, 79, 77], [79, 74, 71, 74, 79, 81, 83, 86],
        [88, 84, 81, 79, 76, 79, 84, 81], [84, 81, 79, 76, 74, 72, 69, 72],
        [77, 81, 84, 81, 79, 77, 76, 74], [79, 77, 74, 71, 74, 79, 76, 72],
    ]
    rng = np.random.default_rng(230120)
    for bar, chord in enumerate(chords):
        start = bar * 2
        for i, note in enumerate(phrases[bar]):
            if note:
                add(output, start + i * beat / 2, tone(note, .21, .19, 'pluck'))
        for i in range(4):
            add(output, start + i * beat, tone(chord[0] - 12 + (7 if i % 2 else 0), .30, .19, 'bass'))
            for note in chord:
                add(output, start + i * beat + beat / 2, tone(note + 12, .14, .036, 'pluck'))
            if i % 2 == 0:
                t = np.arange(round(RATE * .12)) / RATE
                phase = 2 * math.pi * (52 * t + 65 * .035 * (1 - np.exp(-t / .035)))
                add(output, start + i * beat, .23 * np.sin(phase) * np.exp(-t * 35))
            else:
                t = np.arange(round(RATE * .07)) / RATE
                noise = rng.uniform(-1, 1, len(t))
                add(output, start + i * beat, .07 * np.diff(np.r_[0, noise]) * np.exp(-t * 60))
        for i in range(8):
            t = np.arange(round(RATE * .026)) / RATE
            noise = rng.uniform(-1, 1, len(t))
            add(output, start + i * .25, .025 * np.diff(np.r_[0, noise]) * np.exp(-t * 150))
    return output


def effects():
    values = {}
    for name, notes, duration in (
        ('step', [69], .085), ('land', [57, 69], .12), ('skill', [72, 79, 84], .30),
        ('trip', [67, 60, 48], .32), ('coin', [88, 93], .20),
        ('finish', [72, 76, 79, 84], .56), ('race_start', [79, 79, 84], .58),
        ('win', [72, 76, 79, 84, 79, 84, 88, 91], 1.50), ('illegal', [52, 49], .20),
    ):
        sound = np.zeros(round(RATE * duration))
        for i, note in enumerate(notes):
            add(sound, i * duration / len(notes), tone(note, duration / len(notes) * .92, .33))
        values[name] = sound
    t = np.arange(round(RATE * .42)) / RATE
    phase = 2 * math.pi * (320 * t + 1450 * t ** 2)
    values['warp'] = .26 * np.sin(phase) * np.sin(math.pi * t / .42) ** 2
    return values


def build():
    audio = {name: save(name, values) for name, values in effects().items()}
    audio['bgm'] = save('bgm', music())
    roll = RP/'assets/card/sounds/catan/roll.ogg'
    retained = RP/'.source/catan/audio'
    assert roll.is_file(), roll
    audio['roll'] = {'resource': 'card:catan/roll', 'sha256': sha(roll),
        'original': '.source/catan/audio/kenney/casino/dice-throw-1.ogg',
        'license': 'CC0-1.0', 'author': 'Kenney', 'page': 'https://kenney.nl/assets/casino-audio',
        'retained_license': '.source/catan/audio/kenney/casino/License.txt'}
    events = {name: {'sounds': [{'name': item['resource'], **({'stream': True} if name == 'bgm' else {})}]}
              for name, item in audio.items()}
    json_file(RP/'assets/magical_athlete/sounds.json', events)
    score = {'tempo': 120, 'meter': '4/4', 'bars': 16, 'key': 'C major', 'duration_seconds': 32,
             'loop_ticks': LOOP_TICKS, 'composition': 'Original Fimel Cards sports theme',
             'synthesis': 'Sine/plucked harmonics, bass, deterministic noise percussion; no samples'}
    json_file(SOURCE/'score.json', score)
    json_file(SOURCE/'manifest.json', {'license': 'CC0-1.0', 'loop_ticks': LOOP_TICKS,
        'original_audio': 'Fimel Cards generated original composition and sound synthesis',
        'synthesis_source': 'fimel_cards/tools/build_magical_athlete_sound.py', 'audio': audio,
        'external_sources': [{'author': 'Kenney', 'title': 'Casino Audio 1.1',
            'page': 'https://kenney.nl/assets/casino-audio', 'license': 'CC0-1.0',
            'retained_originals': '.source/catan/audio/kenney/casino/'}]})
    text_file(SOURCE/'LICENSE.txt', 'SPDX-License-Identifier: CC0-1.0\n\n'
        'Fimel Cards dedicates the original synthesized music and sound effects in this directory '
        'to the public domain under CC0 1.0 Universal.\n'
        'https://creativecommons.org/publicdomain/zero/1.0/\n'
        'Kenney dice audio is separately CC0; the original notice is retained in '
        '.source/catan/audio/kenney/casino/License.txt.')
    text_file(SOURCE/'README.md', '''# 胡闹运动会音频

`bgm.wav` 是 Fimel Cards 原创轻快运动主题：C 大调、120 BPM、4/4 拍、16 小节，共 32 秒（640 游戏刻）。旋律、低音、拨弦和打击乐均由生成器合成，无第三方采样。其余短音效也为原创合成，许可 CC0-1.0。

掷骰事件复用已经合并的 [Kenney Casino Audio 1.1](https://kenney.nl/assets/casino-audio) `dice-throw-1.ogg`，许可为 CC0；原始文件及许可在 `.source/catan/audio/kenney/casino/`。运行资源引用同一 Ogg，不重复打包。

独立事件为 `magical_athlete:roll/step/land/skill/trip/warp/coin/finish/race_start/win/illegal/bgm`。音乐流式加载，建议播放音量 0.16，可在本桌设置关闭；暂停、结束、离桌和旧局重连时停止对应事件。所有播放仅发送本桌玩家。

重建：在数据包根目录运行 `python tools/build_magical_athlete_sound.py`，需要 NumPy、ffmpeg。原始无损 WAV、乐曲说明、许可及每个输出的 SHA-256 均保留在本目录。音乐首尾使用短淡化消除点击，播放循环不改变规则或骰值。
''')
    return LOOP_TICKS


if __name__ == '__main__':
    print('Magical Athlete audio built; loop_ticks =', build())
