"""棋盘游戏原创 Java 模型、纹理和可编辑 Blockbench 源文件的公共导出工具。"""
from pathlib import Path
import base64
import copy
import json
import math
import uuid
from PIL import Image

PACK = Path(__file__).resolve().parents[1]
RP = PACK.parents[3] / 'resourcepacks/fimelcard-rp'
CARD = RP/'assets/card'
SIDES = ('up', 'down', 'north', 'south', 'east', 'west')


def text_file(path, body):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(body.strip()+'\n', encoding='utf-8')


def json_file(path, value):
    text_file(path, json.dumps(value, ensure_ascii=False, indent=2))


def faces(texture, uv=(0, 0, 16, 16)):
    return {side: {'texture': '#'+texture, 'uv': list(uv)} for side in SIDES}


def cube(start, end, texture='all', name='cube'):
    return {'name': name, 'from': start, 'to': end, 'faces': faces(texture)}


def flat_board(texture):
    return {'credit': 'Fimel Cards original artwork', 'textures': {'all': texture, 'particle': texture},
            'elements': [cube([0, 0, 0], [16, .06, 16], name='board')]}


def disc(top, edge, height=1.8, segments=16):
    elements = []
    for index in range(segments):
        x0 = .5+index*15/segments
        x1 = .5+(index+1)*15/segments
        dz = math.sqrt(7.5**2-((x0+x1)/2-8)**2)
        element = cube([x0, 0, 8-dz], [x1, height, 8+dz], 'edge', f'disc_{index:02}')
        for side in ('up', 'down'):
            element['faces'][side] = {'texture': '#top', 'uv': [x0, 8-dz, x1, 8+dz]}
        # 棋子始终贴在不透明棋盘上；去掉不可见底面，16条圆盘共80面。
        del element['faces']['down']
        elements.append(element)
    return {'credit': 'Fimel Cards original round geometry', 'gui_light': 'front',
            'textures': {'top': top, 'edge': edge, 'particle': edge}, 'elements': elements}


def outline(texture):
    return {'textures': {'all': texture, 'particle': texture}, 'elements': [
        cube([.5, 0, .5], [15.5, .1, 1.2]), cube([.5, 0, 14.8], [15.5, .1, 15.5]),
        cube([.5, 0, 1.2], [1.2, .1, 14.8]), cube([14.8, 0, 1.2], [15.5, .1, 14.8])
    ]}


def export_model(game, name, model, editable=True):
    json_file(CARD/f'models/item/{game}/{name}.json', model)
    json_file(CARD/f'items/{game}/{name}.json', {'model': {'type': 'minecraft:model', 'model': f'card:item/{game}/{name}'}})
    if editable:
        export_blockbench(game, name, model)


def export_texture(game, name, bitmap):
    path = CARD/f'textures/item/{game}/{name}.png'
    path.parent.mkdir(parents=True, exist_ok=True)
    bitmap.save(path)
    return path


def export_blockbench(game, name, model):
    textures, indices = [], {}
    for key, resource in model.get('textures', {}).items():
        if key == 'particle' or resource.startswith('#'):
            continue
        namespace, location = resource.split(':')
        path = RP/f'assets/{namespace}/textures/{location}.png'
        if not path.exists():
            continue
        with Image.open(path) as bitmap:
            width, height = bitmap.size
        indices[key] = len(textures)
        textures.append({'name': path.name, 'id': str(len(textures)), 'uuid': str(uuid.uuid5(uuid.NAMESPACE_URL, resource)),
                         'width': width, 'height': height, 'uv_width': 16, 'uv_height': 16,
                         'source': 'data:image/png;base64,'+base64.b64encode(path.read_bytes()).decode('ascii')})
    elements = []
    for index, element in enumerate(model.get('elements', [])):
        element = copy.deepcopy(element)
        element.update({'uuid': str(uuid.uuid5(uuid.NAMESPACE_URL, f'fimel:{game}:{name}:{index}')),
                        'type': 'cube', 'origin': [8, 8, 8], 'box_uv': False, 'rescale': False})
        for face in element.get('faces', {}).values():
            face['texture'] = indices.get(face['texture'].lstrip('#'), None)
        elements.append(element)
    json_file(RP/f'.source/{game}/models/{name}.bbmodel', {
        'meta': {'format_version': '5.0', 'model_format': 'java_block', 'box_uv': False},
        'name': name, 'resolution': {'width': 16, 'height': 16}, 'elements': elements,
        'outliner': [element['uuid'] for element in elements], 'textures': textures})


def number(value):
    return f'{value:.8f}'.rstrip('0').rstrip('.') if value else '0.0'


def vec(values):
    return '['+','.join(number(value)+'f' for value in values)+']'
