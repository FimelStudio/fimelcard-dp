"""Use poker geometry and display transforms while keeping Abraca artwork UVs."""
from pathlib import Path
import json, copy
ROOT = Path(__file__).resolve().parents[1]
RP = ROOT.resolve().parents[3] / 'resourcepacks'
def build():
    for name in ('fimelcard-rp', 'Fimel桌游馆'):
        root = RP / name / 'assets/card'
        if not (root / 'models/item/abraca/card.json').exists():
            continue
        poker = json.loads((root / 'models/item/fake_card.json').read_text(encoding='utf-8'))
        old = json.loads((root / 'models/item/hanabi/card.json').read_text(encoding='utf-8'))
        model = copy.deepcopy(poker)
        model['textures'] = {'face':'card:item/abraca/back', 'back':'card:item/abraca/back', 'edge':'card:item/poker/s_a', 'particle':'#face'}
        for element in model['elements']:
            for face in element['faces'].values():
                face['texture'] = '#edge'
        for direction, texture in [('north', '#face'), ('south', '#back')]:
            model['elements'][0]['faces'][direction] = copy.deepcopy(old['elements'][0]['faces'][direction])
            model['elements'][0]['faces'][direction]['texture'] = texture
        (root / 'models/item/abraca/card.json').write_text(json.dumps(model, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')
        for card in ['back', 'secret'] + [f'spell_{i}' for i in range(1,9)]:
            obj = {'parent':'card:item/abraca/card', 'textures':{'face':f'card:item/abraca/{card}', 'back':'card:item/abraca/back', 'particle':f'card:item/abraca/{card}'}}
            (root / f'models/item/abraca/{card}.json').write_text(json.dumps(obj,indent=2)+'\n',encoding='utf-8')
        assert model['display'] == poker['display']
        for a,b in zip(model['elements'],poker['elements']):
            assert a['from']==b['from'] and a['to']==b['to'] and a['rotation']==b['rotation']
        print(f'{name}: 10 card models updated; poker geometry/display verified; original textures retained')
if __name__ == '__main__':
    build()
