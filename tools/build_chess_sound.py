"""生成按桌隔离的国际象棋音效函数，音频素材由配套资源包提供。"""
from pathlib import Path


def build(root: Path) -> None:
    def put(name: str, lines: list[str]) -> None:
        target = root / 'sound' / (name + '.mcfunction')
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_text('\n'.join(lines) + '\n', encoding='utf-8')

    # 每步只播放一种提示：终局优先于落子，将军优先于易位／吃子。
    # 过路兵的目标格虽然为空，last 仍保存实际被吃的棋子。
    put('landing', [
        'execute if score @s ch_check matches 1 run return run function chess:sound/check',
        'scoreboard players set #sound_rook ch_ctx -1',
        'scoreboard players set #sound_captured ch_ctx 0',
        'execute store result score #sound_rook ch_ctx run data get entity @s data.chess.last.rook_from',
        'execute store result score #sound_captured ch_ctx run data get entity @s data.chess.last.captured',
        'execute if score #sound_rook ch_ctx matches 0..63 run return run function chess:sound/castle',
        'execute unless score #sound_captured ch_ctx matches 0 run return run function chess:sound/capture',
        'function chess:sound/move',
    ])

    for event in ('move', 'capture', 'castle', 'check', 'start', 'end', 'illegal'):
        audience = '@a[tag=ch.audience' + (',tag=ch.actor' if event == 'illegal' else '') + ']'
        volume = '0.8' if event in ('capture', 'castle', 'check', 'end') else '0.65'
        put(event, [
            '# 声源固定在控制器上方，仅本桌仍入座的双方接收。',
            'function chess:system/context',
            f'execute at @s positioned ~ ~1 ~ as {audience} if score @s ct_id = #table ch_ctx if score @s ch_table = #table ch_ctx run playsound card:chess.{event} block @s ~ ~ ~ {volume} 1 0',
        ])


if __name__ == '__main__':
    build(Path(__file__).resolve().parents[1] / 'data/chess/function')
