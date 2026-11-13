"""根据静止第一人称视口检查模型顶点，防止再次出现近处放大后裁边。"""
import itertools
import json
import math
import unittest
from boardgame_assets import CARD


class HandPoses(unittest.TestCase):
    def test_buildings_and_shared_dice_stay_in_view(self):
        paths=[p for kind in ('road','settlement','city','dice') for p in (CARD/f'models/item/catan/{kind}').glob('*.json')]
        paths.append(CARD/'models/item/aeroplane_chess/dice.json')
        paths.extend((CARD/'models/item/magical_athlete/hand').glob('*.json'))
        self.assertGreater(len(paths),12)
        for path in paths:
            body=json.loads(path.read_text(encoding='utf-8'));pose=body['display']['firstperson_righthand']
            # Java 手持静止位置，70° 物品视角、16:9；显示姿态在模型中心偏移前应用。
            angle=math.radians(pose['rotation'][1]);c=math.cos(angle);s=math.sin(angle)
            for element in body['elements']:
                for point in itertools.product(*zip(element['from'],element['to'])):
                    x,y,z=[(v-8)/16*pose['scale'][i] for i,v in enumerate(point)]
                    x,z=x*c+z*s,-x*s+z*c
                    x+=.56+pose['translation'][0]/16;y+=-.52+pose['translation'][1]/16;z+=-.72+pose['translation'][2]/16
                    self.assertLess(z,-.2,path)
                    self.assertLess(abs(x/(-z*math.tan(math.radians(35))*(16/9))),.98,path)
                    self.assertLess(abs(y/(-z*math.tan(math.radians(35)))),.98,path)
            for context in ('thirdperson_righthand','thirdperson_lefthand'):
                self.assertLessEqual(max(body['display'][context]['scale']),.32,path)

    def test_catan_and_aeroplane_share_the_same_die_pose(self):
        shared=json.loads((CARD/'models/item/aeroplane_chess/dice.json').read_text(encoding='utf-8'))['display']
        for shade in ('ivory','red'):
            die=json.loads((CARD/f'models/item/catan/dice/{shade}.json').read_text(encoding='utf-8'))
            for context in ('firstperson_righthand','firstperson_lefthand','thirdperson_righthand','thirdperson_lefthand'):
                self.assertEqual(die['display'][context],shared[context])


if __name__=='__main__':unittest.main()
