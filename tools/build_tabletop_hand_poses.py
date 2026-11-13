"""桌游立体道具的独立手持姿态；不改变 none 桌面视角或投骰几何。"""
import copy
import json
from boardgame_assets import CARD, RP, json_file


def poses(die=False):
    scale=.27 if die else .32
    first=.28 if die else .30
    height=7.5 if die else 6.5
    return {
        'firstperson_righthand':{'rotation':[0,135,0],'translation':[-3,height,3],'scale':[first]*3},
        'firstperson_lefthand':{'rotation':[0,225,0],'translation':[-3,height,3],'scale':[first]*3},
        'thirdperson_righthand':{'rotation':[75,45,0],'translation':[0,2.5,0],'scale':[scale]*3},
        'thirdperson_lefthand':{'rotation':[75,225,0],'translation':[0,2.5,0],'scale':[scale]*3},
    }


def apply(body,die=False):
    body.setdefault('display',{}).update(copy.deepcopy(poses(die)))
    return body


def build():
    paths=[]
    for kind in ('road','settlement','city'):
        paths.extend((CARD/f'models/item/catan/{kind}').glob('*.json'))
    paths.extend((CARD/'models/item/catan/dice').glob('*.json'))
    paths.append(CARD/'models/item/aeroplane_chess/dice.json')
    for path in paths:
        die='dice' in path.parts or path.stem=='dice'
        body=apply(json.loads(path.read_text(encoding='utf-8')),die)
        json_file(path,body)
        relative=path.relative_to(CARD/'models/item')
        source=RP/'.source'/relative.parts[0]/'models'/relative.relative_to(relative.parts[0]).with_suffix('.bbmodel')
        if source.exists():
            editable=json.loads(source.read_text(encoding='utf-8'))
            editable['display']=body['display'];json_file(source,editable)
    json_file(RP/'.source/catan/hand-poses.json',{'models':[p.relative_to(CARD/'models').as_posix() for p in paths],
        'building':poses(),'dice':poses(True),'table_context':'none (unchanged geometry)'})


if __name__=='__main__':build()
