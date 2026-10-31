"""生成中国象棋按桌隔离的音效入口。"""
from pathlib import Path


def build(root):
    root = Path(root)
    target = root / 'sound'
    target.mkdir(parents=True, exist_ok=True)
    def put(name, lines):
        (target / (name + '.mcfunction')).write_text('\n'.join(lines) + '\n', encoding='utf-8')
    put('landing', [
        'execute if score @s xq_check matches 1 run return run function xiangqi:sound/check',
        'scoreboard players set #sound_captured xq_ctx 0',
        'execute store result score #sound_captured xq_ctx run data get entity @s data.xiangqi.last.captured',
        'execute unless score #sound_captured xq_ctx matches 0 run return run function xiangqi:sound/capture',
        'function xiangqi:sound/move',
    ])
    for event in ('move', 'capture', 'check', 'start', 'end', 'illegal'):
        audience = '@a[tag=xq.audience' + (',tag=xq.actor' if event == 'illegal' else '') + ']'
        volume = '0.45' if event in ('start', 'end') else '0.75'
        put(event, [
            '# 固定牌桌为声源，只发送给仍属于本桌的玩家。',
            'function xiangqi:system/context',
            f'execute at @s positioned ~ ~1 ~ as {audience} if score @s ct_id = #table xq_ctx if score @s xq_table = #table xq_ctx run playsound card:xiangqi.{event} block @s ~ ~ ~ {volume} 1 0',
        ])


if __name__ == '__main__':
    build(Path(__file__).resolve().parents[1] / 'data/xiangqi/function')
