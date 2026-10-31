"""生成自由五子棋规则：13/15/19 路，固定 19 步长，五连及长连均获胜。"""
from pathlib import Path
from textwrap import dedent
import re

PACK = Path(__file__).resolve().parents[1]
DIRECTIONS = ((1, 0), (0, 1), (1, 1), (1, -1))


def build(root=PACK):
    root = Path(root)
    if root.name != 'function':
        root = root / 'data/gomoku/function'
    def put(name, body):
        path = root / 'engine' / (name + '.mcfunction')
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text('\n'.join(re.sub(r' {2,}', ' ', x.strip()) for x in dedent(body).strip().splitlines()) + '\n', encoding='utf-8')

    put('init_board', '''
        function gomoku:system/context
        scoreboard players set @e[type=minecraft:marker,tag=gm.board] gm_piece 0
        scoreboard players set @s gm_turn 1
        scoreboard players set @s gm_moves 0
        scoreboard players set @s gm_result 0
        scoreboard players set @s gm_reason 0
        data modify entity @s data.gomoku.history set value []
        data modify entity @s data.gomoku.win set value []
        data remove entity @s data.gomoku.last
    ''')
    # A real-board cache is rebuilt once per search tick. Invalid/missing cells never
    # become empty legal moves, and cells outside the selected board are sentinels.
    cache = '''
        function gomoku:system/context
        scoreboard players set #nineteen gm_ctx 19
        scoreboard players set #minus gm_ctx -1
        scoreboard players operation #size gm_ctx = @s gm_size
        scoreboard players operation #side gm_ctx = @s gm_turn
        scoreboard players set #cache_ok gm_ctx 0
        execute if score #size gm_ctx matches 13 run scoreboard players set #cache_ok gm_ctx 1
        execute if score #size gm_ctx matches 15 run scoreboard players set #cache_ok gm_ctx 1
        execute if score #size gm_ctx matches 19 run scoreboard players set #cache_ok gm_ctx 1
        execute unless score #side gm_ctx matches -1 unless score #side gm_ctx matches 1 run scoreboard players set #cache_ok gm_ctx 0
        scoreboard players operation #expected gm_ctx = #size gm_ctx
        scoreboard players operation #expected gm_ctx *= #size gm_ctx
        execute store result score #actual gm_ctx if entity @e[type=minecraft:marker,tag=gm.board]
        execute unless score #actual gm_ctx = #expected gm_ctx run scoreboard players set #cache_ok gm_ctx 0
        execute as @e[type=minecraft:marker,tag=gm.board] unless score @s gm_piece matches -1..1 run scoreboard players set #cache_ok gm_ctx 0
    '''
    for i in range(361):
        f, r = i % 19, i // 19
        selector = f'@e[type=minecraft:marker,tag=gm.board,scores={{gm_sq={i}}}]'
        cache += f'\nscoreboard players set #b{i} gm_ctx -2\n'
        cache += f'execute if score #size gm_ctx matches {max(f,r)+1}.. run function gomoku:engine/cache_cell/{i}\n'
        put(f'cache_cell/{i}', f'''
            execute store result score #cell_count gm_ctx if entity {selector}
            execute unless score #cell_count gm_ctx matches 1 run scoreboard players set #cache_ok gm_ctx 0
            execute if score #cell_count gm_ctx matches 1 run scoreboard players operation #b{i} gm_ctx = {selector[:-1]},limit=1] gm_piece
        ''')
    put('cache', cache)
    put('check_move', '''
        scoreboard players set #legal gm_ctx 0
        execute unless score @s gm_size matches 13 unless score @s gm_size matches 15 unless score @s gm_size matches 19 run return 0
        execute unless score @s gm_turn matches 1 unless score @s gm_turn matches -1 run return 0
        execute unless score #to gm_ctx matches 0..360 run return 0
        execute unless score @s gm_result matches 0 run return 0
        scoreboard players set #nineteen gm_ctx 19
        scoreboard players operation #file gm_ctx = #to gm_ctx
        scoreboard players operation #rank gm_ctx = #to gm_ctx
        scoreboard players operation #file gm_ctx %= #nineteen gm_ctx
        scoreboard players operation #rank gm_ctx /= #nineteen gm_ctx
        execute unless score #file gm_ctx < @s gm_size run return 0
        execute unless score #rank gm_ctx < @s gm_size run return 0
        execute store result storage gomoku:ctx check.sq int 1 run scoreboard players get #to gm_ctx
        function gomoku:engine/check_cell with storage gomoku:ctx check
    ''')
    put('check_cell', '''
        $execute store result score #cell_count gm_ctx if entity @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=$(sq)}]
        execute unless score #cell_count gm_ctx matches 1 run return 0
        $execute if score @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=$(sq)},limit=1] gm_piece matches 0 run scoreboard players set #legal gm_ctx 1
    ''')
    put('try_move', '''
        function gomoku:system/context
        scoreboard players set #legal gm_ctx 0
        execute unless score @s gm_state matches 1 run return 0
        execute unless score @s ct_state matches 1 run return 0
        function gomoku:engine/check_move
        execute unless score #legal gm_ctx matches 1 run return 0
        data modify entity @s data.gomoku.last set value {sq:0,side:1}
        execute store result entity @s data.gomoku.last.sq int 1 run scoreboard players get #to gm_ctx
        execute store result entity @s data.gomoku.last.side int 1 run scoreboard players get @s gm_turn
        function gomoku:engine/place with entity @s data.gomoku.last
        data modify entity @s data.gomoku.history append from entity @s data.gomoku.last
        scoreboard players add @s gm_moves 1
        scoreboard players set #minus gm_ctx -1
        scoreboard players operation @s gm_turn *= #minus gm_ctx
        function gomoku:game/after_move
    ''')
    put('place', '''
        $scoreboard players set @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=$(sq)},limit=1] gm_piece $(side)
    ''')
    put('evaluate', '''
        execute if score @s gm_result matches 1..3 run return 0
        function gomoku:engine/cache
        execute unless score #cache_ok gm_ctx matches 1 run return run function gomoku:engine/invalid
        data modify entity @s data.gomoku.win set value []
        execute unless data entity @s data.gomoku.last run return run function gomoku:engine/full
        execute store result score #last gm_ctx run data get entity @s data.gomoku.last.sq
        execute store result score #mover gm_ctx run data get entity @s data.gomoku.last.side
        execute unless score #last gm_ctx matches 0..360 run return run function gomoku:engine/invalid
        execute unless score #mover gm_ctx matches -1 unless score #mover gm_ctx matches 1 run return run function gomoku:engine/invalid
        function gomoku:engine/dispatch_line with entity @s data.gomoku.last
        execute if data entity @s data.gomoku.win[4] run scoreboard players set @s gm_reason 1
        execute if data entity @s data.gomoku.win[4] if score #mover gm_ctx matches 1 run scoreboard players set @s gm_result 1
        execute if data entity @s data.gomoku.win[4] if score #mover gm_ctx matches -1 run scoreboard players set @s gm_result 2
        execute if score @s gm_result matches 0 run function gomoku:engine/full
    ''')
    put('dispatch_line', '$function gomoku:engine/lines/$(sq)')
    put('full', '''
        scoreboard players operation #capacity gm_ctx = @s gm_size
        scoreboard players operation #capacity gm_ctx *= @s gm_size
        execute unless score @s gm_moves >= #capacity gm_ctx run return 0
        scoreboard players set @s gm_result 3
        scoreboard players set @s gm_reason 2
    ''')
    put('invalid', 'scoreboard players set @s gm_result 3\nscoreboard players set @s gm_reason 11')
    for i in range(361):
        f, r = i % 19, i // 19
        lines = [f'execute unless score #b{i} gm_ctx = #mover gm_ctx run return 0']
        for direction, (df,dr) in enumerate(DIRECTIONS):
            rays = []
            lines.append('scoreboard players set #length gm_ctx 1')
            for sign, key in ((-1,'left'),(1,'right')):
                ray = []
                lines += [f'scoreboard players set #{key} gm_ctx 0','scoreboard players set #run gm_ctx 1']
                for step in range(1,19):
                    tf,tr = f+df*step*sign,r+dr*step*sign
                    if not (0<=tf<19 and 0<=tr<19): break
                    dest = tr*19+tf
                    ray.append(dest)
                    lines += [f'execute if score #run gm_ctx matches 1 if score #b{dest} gm_ctx = #mover gm_ctx run scoreboard players add #{key} gm_ctx 1',f'execute unless score #b{dest} gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0']
                rays.append((key,ray))
                lines.append(f'scoreboard players operation #length gm_ctx += #{key} gm_ctx')
            lines.append(f'execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/{i}_{direction}')
            add = [f'execute unless data entity @s data.gomoku{{win:[{i}]}} run data modify entity @s data.gomoku.win append value {i}']
            for key,ray in rays:
                for distance,dest in enumerate(ray,1):
                    add.append(f'execute if score #{key} gm_ctx matches {distance}.. unless data entity @s data.gomoku{{win:[{dest}]}} run data modify entity @s data.gomoku.win append value {dest}')
            put(f'win/{i}_{direction}', '\n'.join(add))
        put(f'lines/{i}', '\n'.join(lines))


if __name__ == '__main__':
    build()
